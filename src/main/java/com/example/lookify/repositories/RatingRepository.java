package com.example.lookify.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.example.lookify.models.Rating;

@Repository
public interface RatingRepository extends CrudRepository<Rating, Long> {
	
}
