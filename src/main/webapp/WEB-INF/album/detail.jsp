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
<title><c:out value="${album.title}" /></title>
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
						<input type="text" id="singer" name="singer" placeholder="Search" />
						<input type="submit" value="Search" class="btn btn-primary" />
					</form>
					<li><a class="nav-link" href="/logout">Logout</a></li>
				</ul>
			</div>
		</div>
		<div class="container mt-3">
			<div class="d-flex justify-content-between align-items-center">
				<h1 class="fw-bold">
					<c:out value="${album.title}" />
				</h1>
				<a href="/dashboard">Back</a>
			</div>
			<hr />
			<h4>Album Poster</h4>
			<div class="row mt-4">
				<div class="poster-side col-6">
					<img alt="pic" src="${album.imageUrl}" height="200" width="200">
				</div>
				<div class="col-6">
					<c:set var="found" value="false" />
					<c:forEach var="rating" items="${album.ratings}">
						<c:if test="${rating.ratedBy.id == user.id}">
							<c:set var="found" value="true" />
							<p>
								You have already rated this album:
								<c:out value="${rating.rating}" />
							</p>
						</c:if>
					</c:forEach>
					<div class="second-list">
					<c:if test="${found == false}">
						<form:form class="search-form" action="/album/rating" method="post"
							modelAttribute="newRating">
							<div >
								<form:label path="rating">Leave a rating:</form:label>
								<form:errors path="rating" class="text-danger fw-bold" />
								<form:input path="rating" />
								&nbsp;&nbsp;
							</div>
							<form:input path="ratedBy" type="hidden" value="${user.id}" />
							<form:input path="album" type="hidden" value="${album.id}" />
							<input type="submit" value="Rate!" class="btn btn-primary">
						</form:form>
					</c:if></div>
				</div>
			</div>
			<table class="table table-striped text-center mt-3">
				<thead class="bg-black text-warning">
					<tr>
						<th>Title</th>
						<th>Likes</th>
						<th>Like</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="song" items="${album.songs}">
						<tr>
							<td style="color: #8b8b8b;"><c:out value="${song.title}" /></td>
							<td style="color: #8b8b8b;"><c:out value="${song.likers.size()}" /></td>
							<td style="color: #8b8b8b;"><c:set var="liked" value="false" /> <c:forEach
									var="liker" items="${song.likers}">
									<c:if test="${liker.id eq user.id}">
										<c:set var="liked" value="true" />
									</c:if>
								</c:forEach> <c:choose>
									<c:when test="${liked}">
										<span class="text-success fw-bold">Liked</span>
									</c:when>
									<c:otherwise >
										<a class="btn btn-primary" href="/song/like/${song.id}">Like</a>
									</c:otherwise>
								</c:choose></td>
							<td><c:if test="${user.id == song.addedBy.id}">
									<a href="/songs/${song.id}/edit" class="btn btn-primary">Edit</a>
									<form:form action="/deleteSong/${song.id}" method="delete">
										<input type="submit" value="Delete" class="btn btn-primary" />
									</form:form>
								</c:if></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>