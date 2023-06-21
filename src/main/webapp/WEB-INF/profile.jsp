<%@ page language="java" contentType="text/html; charset=windows-1256" pageEncoding="windows-1256"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="windows-1256">
<script src="/static/js/script.js"></script>
<title><c:out value="${user.name}" /></title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="/CSS/general_style.css" />
<link href="https://fonts.cdnfonts.com/css/playfair-display"
	rel="stylesheet">
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
		<div class="row justify-content-center">
		<div class="col-md-6">
			<div class="card text-center">
				<div class="card-body">
					<h4 class="card-title"  style="white-space: pre;">Y O U R    P R O F I L E</h4>
					<img alt="pic" src="${user.image.imageUrl}" height="200" width="200" class="rounded-circle">
					<form action="/uploadImage" method="post" enctype="multipart/form-data" class="w-100 mt-3">
						<p class="text-danger"><c:out value="${message}"/></p>
						<div class="form-group">
							<label>Select File:</label>
							<input type="file" name="pic" class="form-control mb-3">
						</div>
						<input type="hidden" name="user" value="${user.id}"/>
						<input type="submit" class="btn btn-success mb-3" value="Submit">
					</form>
					<p>Email: <c:out value="${user.email}"/></p>
					<p>Following: <c:out value="${user.getFollowing().size()}"/></p>
					<p>Followers: <c:out value="${user.getFollowers().size()}"/></p>
				
				</div>
		
			</div>
						<c:forEach items="${users}" var="user">
			<div class="action">
			    <img alt="pic" src="${user.image.imageUrl}" height="70" width="70" class="rounded-circle">
			    <a href="/follow/${user.id}" onclick="removeUser(event, ${user.id})">Follow <c:out value="${user.name}"/></a>
			</div>
		</c:forEach>
		</div>
	</div>
	</div>
</body>
</html>