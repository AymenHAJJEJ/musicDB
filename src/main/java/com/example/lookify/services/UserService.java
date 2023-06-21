package com.example.lookify.services;

import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.example.lookify.models.LoginUser;
import com.example.lookify.models.User;
import com.example.lookify.repositories.UserRepository;

@Service
public class UserService {
	
	@Autowired
	private UserRepository userRepo;
	
	public List<User> allUsers(){
		return userRepo.findAll();
	}
	
	public User register(User newUser, BindingResult result) {
		if (result.hasErrors()) {
			return null;
		}
		
		Optional<User> potentialUser = userRepo.findByEmail(newUser.getEmail());
    	if(potentialUser.isPresent()) {
    		result.rejectValue("email", "email", "Email already taken.");
    	}
    	
    	if(!newUser.getPassword().equals(newUser.getConfirm())) {
    	    result.rejectValue("confirm", "Matches", "Passwords must match!");
    	}
    	
    	String hashed = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
    	newUser.setPassword(hashed);
    	return userRepo.save(newUser);
	}
	
	public User login(LoginUser newLoginUser, BindingResult result) {
        
    	Optional<User> potentialUser = userRepo.findByEmail(newLoginUser.getEmail());
    	
    	if(!potentialUser.isPresent()) {
    		result.rejectValue("email", "Matches", "Invalid Login!");
    		return null;
    	}
    	
    	User user = potentialUser.get();
        
    	if(!BCrypt.checkpw(newLoginUser.getPassword(), user.getPassword())) {
    	    result.rejectValue("password", "Matches", "Invalid Login!");
    	}
    	
    	if(result.hasErrors()) {
        	return null;
        }

    	return user;
    }
    
    public User findUser(Long id) {
    	
    	User user = userRepo.findById(id).orElse(null);
    	return user;
    }
    
    public void addFollower(User user, User userToFollow) {
    	List<User> following = user.getFollowing();
    	following.add(userToFollow);
    	userRepo.save(user);
    }
    
    public List<User> findAllUsersExceptLoggedIn(Long loggedInUserId) {
        return userRepo.findAllExceptLoggedInUser(loggedInUserId);
    }
}
