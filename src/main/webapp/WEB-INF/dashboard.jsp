<%@ page language="java" contentType="text/html; charset=windows-1256" pageEncoding="windows-1256"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="windows-1256">
<title>Home</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="/CSS/general_style.css" />
<link href="https://fonts.cdnfonts.com/css/playfair-display"
	rel="stylesheet">
</head>
<body>
	<div class="container ">
		<div class="navbar">
			<div class="first-list">
				<ul>
					<li><img class="nav-logo" src="/CSS/MUSIC2.png" alt="Logo">
					<li><a href="#">Home |</a></li>
					<li><a href="/songs/new">Add Song |</a></li>
					<li><a href="/albums/new">Add Album |</a></li>
					<li><a href="/profile">Profile |</a></li>
				</ul>
			</div>

			<div class="second-list">
				<ul>
					<form class="search-form" action="/dashboard" method="post">
						<input type="text" id="singer" name="singer"
							placeholder="Search by Singer" /> <input type="submit"
							value="Search" class="btn btn-primary" />
					</form>
					<li><a class="nav-link" href="/logout">Logout</a></li>
				</ul>
			</div>
		</div>
		<br />
		<div class="d-flex justify-content-between">
			<h4>
				Welcome,
				<c:out value="${user.name}" />
				!
			</h4>
		</div>
		<table class="table table-striped text-center mt-3">
			<thead class="bg-black ">
				<tr>
					<th style="color: #a7cdcd;">Image</th>
					<th style="color: #a7cdcd;">Title</th>
					<th style="color: #a7cdcd;">Release Date</th>
					<th style="color: #a7cdcd;">Average Rating</th>

					<th style="color: #a7cdcd;">Actions</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="album" items="${albums}">
					<tr>
						<td><img alt="pic" src="${album.imageUrl}" height="200"
							width="200"></td>
						<td class="centered-cell" style="color: white;"><a
							href="/albums/${album.id}"> <c:out value="${album.title}" />
						</a></td>
						<td class="centered-cell" style="color: white;"><fmt:formatDate
								value="${album.releaseDate}" pattern="yyyy-MM-dd"
								var="formattedDate" /> <c:out value="${formattedDate}" /></td>
						<td class="centered-cell" style="color: white;"><c:out
								value="${album.getAvgRating()}" /></td>
						<td class="centered-cell">
							<div class="action ">
							<c:if test="${user.id == album.user.id}">
								<div class="edit">
										<a href="/albums/edit/${album.id}" class="btn btn-primary">Edit</a>
								</div>
								<div class="delete">
										<form:form action="/deleteAlbum/${album.id}" method="delete">
											<input type="submit" value="Delete" class="btn btn-primary" />
										</form:form>

								</div>
								</c:if>
							</div>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	</div>
</body>
</html>