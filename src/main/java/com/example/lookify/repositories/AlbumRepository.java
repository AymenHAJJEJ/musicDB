package com.example.lookify.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.example.lookify.models.Album;

@Repository
public interface AlbumRepository extends CrudRepository<Album, Long> {
	
	List<Album> findAll();
	List<Album> findBySingerContaining(String singer);
}
