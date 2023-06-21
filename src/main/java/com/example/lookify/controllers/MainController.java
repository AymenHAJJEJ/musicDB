package com.example.lookify.controllers;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.lookify.models.Album;
import com.example.lookify.models.LoginUser;
import com.example.lookify.models.Rating;
import com.example.lookify.models.Song;
import com.example.lookify.models.User;
import com.example.lookify.services.AlbumService;
import com.example.lookify.services.ImageService;
import com.example.lookify.services.SongService;
import com.example.lookify.services.UserService;

@Controller
public class MainController {

	@Autowired
	private UserService userService;
	@Autowired
	private SongService songService;
	@Autowired
	private AlbumService albumService;
	@Autowired
	private ImageService imageService;
	
	private static String UPLOAD_FOLDER = "src/main/resources/static/images/";
	
	@GetMapping("/")
	public String index(Model model) {
        model.addAttribute("newUser", new User());
        model.addAttribute("loginUser", new LoginUser());
        return "index.jsp";
    }
	
	@PostMapping("/register")
	public String register(
			@Valid @ModelAttribute("newUser") User newUser, 
	        BindingResult result, 
	        Model model, 
	        HttpSession session) {

		userService.register(newUser, result);

	    if(result.hasErrors()) {
	    	model.addAttribute("loginUser", new LoginUser());
	        return "index.jsp";
	    }
	     
	    session.setAttribute("userId", newUser.getId());
	     
	    return "redirect:/dashboard";
	}

	@PostMapping("/login")
	public String login(@Valid @ModelAttribute("loginUser") LoginUser loginUser, 
	         BindingResult result, Model model, HttpSession session) {

	    User user = userService.login(loginUser, result);

	    if(result.hasErrors()) {
	    	model.addAttribute("newUser", new User());
	        return "index.jsp";
	    } else {
			session.setAttribute("userId", user.getId());
			return "redirect:/dashboard";
		}
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	@GetMapping("/follow/{id}")
    public String followUser(@PathVariable Long id, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if(userId==null) {
			return "redirect:/";
		}
		User followedUser = userService.findUser(id);
		User user = userService.findUser(userId);
		userService.addFollower(user, followedUser);
		return "redirect:/profile";
	}
	
	@GetMapping("/dashboard")
	public String dashboard(Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if(userId == null) {
			return "redirect:/";
		}
		model.addAttribute("user", userService.findUser(userId));
		model.addAttribute("albums", albumService.allAlbums());
		return "dashboard.jsp";
	}
	
	@GetMapping("/profile")
	public String userProfile(Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if(userId == null) {
			return "redirect:/";
		}
		model.addAttribute("users", userService.findAllUsersExceptLoggedIn(userId));
		model.addAttribute("user", userService.findUser(userId));
		return "profile.jsp";
	}
	
	@PostMapping("/dashboard")
	public String dashboard(@RequestParam("singer") String singer, Model model) {
		model.addAttribute("singer", singer);
		return "redirect:/search/"+singer;
	}
	
	@GetMapping("/search/{singer}")
	public String searchResult(@PathVariable("singer") String singer, Model model) {
		model.addAttribute("albums", albumService.findBySinger(singer));
		model.addAttribute("searchTerm", singer);
		return "searchResults.jsp";
	}
	
	@GetMapping("/albums/new")
	public String newAlbum() {
		return "/album/new.jsp";
	}
	
	@PostMapping("/upload")
	public String uploadToFolder(
			@RequestParam("pic") MultipartFile file,
			@RequestParam("title") String title,
			@RequestParam("singer") String singer,
			@RequestParam("releaseDate") @DateTimeFormat(pattern = "yyyy-MM-dd") Date releaseDate,
			HttpSession session,
			RedirectAttributes redirectAttr
			) throws IOException{
		User user = userService.findUser((Long) session.getAttribute("userId"));
		if(file.isEmpty()) {
			redirectAttr.addFlashAttribute("fileMessage", "Upload field cannot be empty");
			return "redirect:/albums/new";
		}
		if (title.length() < 3) {
			redirectAttr.addFlashAttribute("titleMessage","Your title must be at least 3 characters !!!");
			return "redirect:/albums/new";
		}
		if (singer.length() < 3) {
			redirectAttr.addFlashAttribute("singerMessage","Your singer name must be at least 3 characters !!!");
			return "redirect:/albums/new";
		}
		if (releaseDate == null) {
			redirectAttr.addFlashAttribute("dateMessage","Please enter a date");
			return "redirect:/albums/new";
		}
		
		try {
			byte[] bytes = file.getBytes();
			Path path = Paths.get(UPLOAD_FOLDER, file.getOriginalFilename());
			Files.write(path, bytes);	
			String url = "/images/" + file.getOriginalFilename();
			albumService.uploadPic(url, title, singer, releaseDate, user);
		}
		catch(IOException e) {
			e.printStackTrace();
		}
		
		return "redirect:/dashboard";
	}
	
    @PostMapping("/update/{id}")
    public String updateAlbum(
            @PathVariable("id") Long id,
            @RequestParam("pic") MultipartFile file,
            @RequestParam("title") String title,
            @RequestParam("singer") String singer,
            @RequestParam("releaseDate") @DateTimeFormat(pattern = "yyyy-MM-dd") Date releaseDate,
            HttpSession session,
            RedirectAttributes redirectAttr
    ) throws IOException {

        Album album = albumService.findAlbum(id);
        if (album == null) {
            redirectAttr.addFlashAttribute("errorMessage", "Album not found");
            return "redirect:/albums/edit/" + id;
        }
        
        if (title.length() < 3) {
            redirectAttr.addFlashAttribute("titleMessage", "Your title must be at least 3 characters!");
            return "redirect:/albums/edit/" + id;
        }
        if (singer.length() < 3) {
            redirectAttr.addFlashAttribute("singerMessage", "Your singer name must be at least 3 characters!");
            return "redirect:/albums/edit/" + id;
        }
        
        if (!file.isEmpty()) {
        	try {
                byte[] bytes = file.getBytes();
                String fileName = file.getOriginalFilename();
                
                // Create the file path
                String filePath = Paths.get(UPLOAD_FOLDER, fileName).toString();
                
                // Save the file to the upload directory
                Files.write(Paths.get(filePath), bytes);
                
                // Update the album picture URL
                album.setImageUrl(filePath);
            } catch (IOException e) {
                e.printStackTrace();
                // Handle the file upload exception appropriately
            }
        }
        album.setTitle(title);
        album.setSinger(singer);
        album.setReleaseDate(releaseDate);
        albumService.updateAlbum(album);
        
        return "redirect:/dashboard";
    }

	
	@PostMapping("/uploadImage")
	public String uploadToStatic(
			@RequestParam("pic") MultipartFile file,
			HttpSession session,
			RedirectAttributes redirectAttr
			) throws IOException{
		User user = userService.findUser((Long) session.getAttribute("userId"));
		if(file.isEmpty()) {
			redirectAttr.addFlashAttribute("message", "Upload field cannot be empty");
			return "redirect:/profile";
		}
		
		try {
			byte[] bytes = file.getBytes();
			Path path = Paths.get(UPLOAD_FOLDER, file.getOriginalFilename());
			Files.write(path, bytes);	
			String url = "/images/" + file.getOriginalFilename();
			imageService.uploadImage(url, user);
		}
		catch(IOException e) {
			e.printStackTrace();
		}
		
		return "redirect:/profile";
	}
	
	@GetMapping("/albums/{id}")
	public String albumDetail(@PathVariable("id") Long id, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if(userId==null) {
			return "redirect:/";
		}
		model.addAttribute("user",userService.findUser(userId));
	    model.addAttribute("album", albumService.findAlbum(id));
	    return "/album/detail.jsp";
	}
	
	@GetMapping("/albums/edit/{id}")
	public String edit(@PathVariable("id") Long id, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if(userId==null) {
			return "redirect:/";
		}
		model.addAttribute("user",userService.findUser(userId));
	    model.addAttribute("album", albumService.findAlbum(id));
	    return "/album/edit.jsp";
	}

	@PutMapping("/albums/{id}/edit")
	public String editAlbum( @Valid 
			@ModelAttribute("album") Album album,
			BindingResult result,
			@PathVariable("id") Long id,
			Model model) {
		
		if(result.hasErrors()) {
			return "/album/edit.jsp";
		}else {
			albumService.updateAlbum(album);
			return "redirect:/dashboard";
		}
	}
	
	@ModelAttribute("newRating")
	public Rating createRatingModel() {
	    return new Rating();
	}
	
	@PostMapping("/album/rating")
	public String addRating(
			@Valid 
			@ModelAttribute("newRating") Rating newRating, BindingResult result) {
		if (result.hasErrors()) {
	        return "/album/detail.jsp";
	    } 
	    
        albumService.createRating(newRating); 
        return "redirect:/dashboard";
	}
	
	@GetMapping("/songs/new")
	public String newSong(@ModelAttribute("newSong") Song newSong, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if(userId==null) {
			return "redirect:/";
		}
		model.addAttribute("user",userService.findUser(userId));
		model.addAttribute("albums", albumService.allAlbums());
		return "/song/new.jsp";
	}
	
	@PostMapping("/songs/new")
	public String addSong(
			@Valid
			@ModelAttribute("newSong") Song newSong,
			BindingResult result
			) {
		if (result.hasErrors()) {
			return "/song/new.jsp";
		}
		songService.createSong(newSong);
		return "redirect:/dashboard";
	}
	
	@GetMapping("/songs/{id}/edit")
	public String editSong(@PathVariable("id") Long id, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if(userId==null) {
			return "redirect:/";
		}
		model.addAttribute("user",userService.findUser(userId));
		model.addAttribute("song", songService.findSong(id));
	    model.addAttribute("albums", albumService.allAlbums());
	    return "/song/edit.jsp";
	}

	@PutMapping("/songs/{id}/edit")
	public String updateSong( @Valid 
			@ModelAttribute("song") Song song,
			BindingResult result,
			@PathVariable("id") Long id,
			Model model) {
		
		if(result.hasErrors()) {
			return "/song/edit.jsp";
		}else {
			songService.updateSong(song);
			return "redirect:/dashboard";
		}
	}
	
	@GetMapping("/song/like/{id}")
	public String like(@PathVariable("id") Long id, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		Long songId = id;		
		User liker = userService.findUser(userId);
		Song likedSong = songService.findSong(songId);
		songService.addLiker(liker, likedSong);
		return "redirect:/albums/" + id;
	}

	@DeleteMapping("/deleteAlbum/{id}")
	public String deleteAlbum(@PathVariable Long id) {
		albumService.deleteAlbum(id);
		return "redirect:/dashboard";
	}
	
	@DeleteMapping("/deleteSong/{id}")
	public String deleteSong(@PathVariable Long id) {
		songService.deleteSong(id);
		return "redirect:/dashboard";
	}
	
}
