<%@ page language="java" contentType="text/html; charset=windows-1256"
    pageEncoding="windows-1256"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="windows-1256">
	<title>Add Song</title>
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
	<div class="container mt-3">
		<h1 class="fw-bold mb-3">Add Song</h1>
		<form:form action="/songs/new" method="post" class="w-50" modelAttribute="newSong">
			<div class="form-group mb-3">
				<form:label path="title">Title:</form:label>
				<form:errors class="text-danger fw-bold" path="title"/>
				<form:input class="form-control mb-3" path="title"/>
			</div>
			<div class="form-group mb-3">
				<form:label path="album">Album:</form:label>
				<form:select class="form-control mb-3" path="album">
					<option Disabled Selected>----- SELECT AN ALBUM -----</option>
					<c:forEach var="album" items="${albums}">
						<form:option value="${album.id}">
							<c:out value="${album.title}"/>
						</form:option>
					</c:forEach>
				</form:select>
			</div>
			<div class="form-row">
				<form:input type="hidden" path="addedBy" value="${user.id}"/>
			</div>
			<input type="submit" value="Submit" class="btn btn-success"/>
		</form:form>
	</div>
	</div>
</body>
</html>