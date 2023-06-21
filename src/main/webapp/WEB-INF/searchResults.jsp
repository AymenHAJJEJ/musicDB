<%@ page language="java" contentType="text/html; charset=windows-1256" pageEncoding="windows-1256"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="windows-1256">
<title>Search</title>
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
					<li><a class="nav-link" href="/logout">Logout</a></li>
				</ul>
			</div>
		</div>
		<hr />
	<div class="container mt-3">
		<h4 class="fw-bold">Albums released by <c:out value="${searchTerm}"></c:out> :</h4>
	 	<table class="table table-striped text-center mt-3">
			<thead class="bg-black text-warning">
				<tr>
					<th>Name</th>
					<th>Release Date</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="album" items="${albums}">
					<tr>
						<td style="color: white;" >
							<c:out value="${album.title}"></c:out>
						</td>
						<td style="color: white;">
							<fmt:formatDate value="${album.releaseDate}" pattern="d MMMM, yyyy" var="formattedDate" />
							<c:out value="${formattedDate}" />
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
	</div>
	</div>
</body>
</html>