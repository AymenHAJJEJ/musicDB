package com.example.lookify.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.example.lookify.models.Image;

@Repository
public interface ImageRepository extends CrudRepository<Image, Long> {
	List<Image> findAll();
}
