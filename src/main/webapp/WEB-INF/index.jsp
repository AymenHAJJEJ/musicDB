<%@ page language="java" contentType="text/html; charset=windows-1256" pageEncoding="windows-1256"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="windows-1256">
	<title>Music DB</title>
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="/CSS/general_style.css" />
	<link href="https://fonts.cdnfonts.com/css/playfair-display" rel="stylesheet">
                
</head>
<body>
	<div class="container mt-5">
	<div class="d-flex justify-content-center">
			<img class="index-logo" alt="logo" src="/CSS/MUSIC2.png">
		</div>
		<div class="row">
			<div class="col-6">
				<div class="card">
					<div class="card-header">
						<h1 class="fw-bold">Register</h1>
					</div>
					<div class="card-body">
						<form:form action="/register" method="post" modelAttribute="newUser">
							<form:errors class="text-danger fw-bold mb-5" path="*"/>
							<div class="mb-3 row">
								<form:label path="name" class="col-sm-4 col-form-label">Name:</form:label>
								<div class="col-sm-8">
									<form:input path="name" class="form-control"/>
								</div>
							</div>
							<div class="mb-3 row">
								<form:label path="email" class="col-sm-4 col-form-label">Email:</form:label>
								<div class="col-sm-8">
									<form:input type="email" path="email" class="form-control"/>
								</div>
							</div>
							<div class="mb-3 row">
								<form:label path="password" class="col-sm-4 col-form-label">Password:</form:label>
								<div class="col-sm-8">
									<form:input type="password" path="password" class="form-control"/>
								</div>
							</div>
							<div class="mb-3 row">
								<form:label path="confirm" class="col-sm-4 col-form-label">Confirm PW:</form:label>
								<div class="col-sm-8">
									<form:input type="password" path="confirm" class="form-control"/>
								</div>
							</div>
							<input type="submit" value="Register" class="btn btn-success float-end"/>
						</form:form>
					</div>
				</div>
			</div>
			<div class="col-6">
				<div class="card">
					<div class="card-header">
						<h1 class="fw-bold">Log in</h1>
					</div>
					<div class="card-body">
						<form:form action="/login" method="post" modelAttribute="loginUser">
							<form:errors class="text-danger fw-bold mb-5" path="*"/>
							<div class="mb-3 row">
								<form:label path="email" class="col-sm-4 col-form-label">Email:</form:label>
								<div class="col-sm-8">
									<form:input type="email" path="email" class="form-control"/>
								</div>
							</div>
							<div class="mb-3 row">
								<form:label path="password" class="col-sm-4 col-form-label">Password:</form:label>
								<div class="col-sm-8">
									<form:input type="password" path="password" class="form-control"/>
								</div>
							</div>
							<input type="submit" value="Log In" class="btn btn-success float-end"/>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
