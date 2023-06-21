package com.example.lookify.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.lookify.models.Song;
import com.example.lookify.models.User;
import com.example.lookify.repositories.SongRepository;

@Service
public class SongService {

	@Autowired
	private SongRepository songRepository;
	
	public List<Song> allSongs(){
		return songRepository.findAll();
	}
	
	public Song createSong(Song song) {
		return songRepository.save(song);
	}
	
	public Song updateSong(Song song) {
		return songRepository.save(song);
	}
	
	public Song findSong(Long id) {
		Optional<Song> optionalSong = songRepository.findById(id);
		if (optionalSong.isPresent()) {
			return optionalSong.get();
		} else {
			return null;
		}
	}

	public void deleteSong(Long id) {
		Optional<Song> optionalSong = songRepository.findById(id);
		if (optionalSong.isPresent()) {
			songRepository.deleteById(id);
		}
	}
    
    public void addLiker(User user, Song song) {
    	List<User> likers = song.getLikers();
        likers.add(user);
        songRepository.save(song);
    }
}
