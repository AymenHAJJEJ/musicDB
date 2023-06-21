package com.example.lookify.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.lookify.models.User;


@Repository
public interface UserRepository extends CrudRepository<User, Long> {
	
	List<User> findAll();
	Optional<User> findByEmail(String email);
	@Query("SELECT u FROM User u WHERE u.id <> :loggedInUserId")
    List<User> findAllExceptLoggedInUser(@Param("loggedInUserId") Long loggedInUserId);
}
