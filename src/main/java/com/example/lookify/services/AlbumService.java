package com.example.lookify.services;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.lookify.models.Album;
import com.example.lookify.models.Rating;
import com.example.lookify.models.User;
import com.example.lookify.repositories.AlbumRepository;
import com.example.lookify.repositories.RatingRepository;

@Service
public class AlbumService {
	
	@Autowired
	private AlbumRepository albumRepository;
	@Autowired
	private RatingRepository ratingRepository;
	
	public List<Album> allAlbums(){
		return albumRepository.findAll();
	}
	
	public Album updateAlbum(Album album) {
		return albumRepository.save(album);
	}
	
	public Album findAlbum(Long id) {
		Optional<Album> optionalAlbum = albumRepository.findById(id);
		if (optionalAlbum.isPresent()) {
			return optionalAlbum.get();
		} else {
			return null;
		}
	}

	public void deleteAlbum(Long id) {
		Optional<Album> optionalAlbum = albumRepository.findById(id);
		if (optionalAlbum.isPresent()) {
			albumRepository.deleteById(id);
		}
	}
	
	public List<Album> findBySinger(String singer){
		return albumRepository.findBySingerContaining(singer);
	}
	
	public void createRating(Rating newRating) {
    	ratingRepository.save(newRating);
    }
	
	public void uploadPic(String imageUrl, String title, String singer, Date releaseDate, User user) {
		Album newPic = new Album(imageUrl, title, singer, releaseDate, user);
		albumRepository.save(newPic);
	}

}
