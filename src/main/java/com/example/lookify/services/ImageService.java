package com.example.lookify.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.lookify.models.Image;
import com.example.lookify.models.User;
import com.example.lookify.repositories.ImageRepository;

@Service
public class ImageService {
	
	@Autowired
	private ImageRepository imageRepository;
	
	public void uploadImage(String imageUrl, User user) {
		Image newPic = new Image(imageUrl, user);
		imageRepository.save(newPic);
	}
}
