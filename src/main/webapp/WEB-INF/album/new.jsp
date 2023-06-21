<%@ page language="java" contentType="text/html; charset=windows-1256" pageEncoding="windows-1256"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="windows-1256">
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
	<link rel="stylesheet" href="/CSS/general_style.css" />
<link href="https://fonts.cdnfonts.com/css/playfair-display"
	rel="stylesheet">
	<title>New Album</title>
</head>
<body>
<div class="container">
<div class="navbar">
			<div class="first-list">
				<ul>
					<li><img class="nav-logo" src="/CSS/MUSIC2.png" alt="Logo">
					<li><a href="/dashboard">Home |</a></li>
					<li><a href="/songs/new">Add Song |</a></li>
					<li><a href="/albums/new">Add Album |</a></li>
					<li><a href="/profile">Profile |</a></li>
				</ul>
			</div>

			<div class="second-list">
				<ul>
					<form class="search-form" action="/dashboard" method="post">
						<input type="text" id="singer" name="singer" placeholder="Search by Singer" />
						<input type="submit" value="Search" class="btn btn-primary" />
					</form>
					<li><a class="nav-link" href="/logout">Logout</a></li>
				</ul>
			</div>
		</div>
		<hr />
	<div class="container mt-3">
		<h1 class="fw-bold mb-3">Add Album</h1>
		<form action="/upload" method="post" enctype="multipart/form-data" class="w-50">
			<div class="form-group">
				<label>Title:</label>
				<input type="text" name="title" class="form-control mb-3" required>
			</div>
			<div class="form-group">
				<label>Singer:</label>
				<input type="text" name="singer" class="form-control mb-3" required>
			</div>
			<div class="form-group">
				<label>Select File:</label>
				<input type="file" name="pic" class="form-control mb-3" required>
			</div>
			<div class="form-group">
				<label>Release Date:</label>
				<input type="date" min="yyyy-MM-dd" name="releaseDate" class="form-control mb-3" required>
			</div>
			<input type="hidden" name="user" value="${user.id}"/>
			<input type="submit" class="btn btn-success mb-3" value="submit">
		</form>
	</div>
	</div>
</body>
</html>