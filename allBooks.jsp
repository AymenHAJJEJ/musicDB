<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- c:out ; c:forEach etc. --> 
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!-- Formatting (dates) --> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Le JAVA</title>
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/main.css"> <!-- change to match your file/naming structure -->
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/js/app.js"></script><!-- change to match your file/naming structure -->
</head>
<body>
<div class="container">
   <h1>Display All Books</h1>
   <a href="/books/new">Create Book</a>
   <hr />
   <table class="table">
   <thead>
   <tr>
   <th>ID</th>
   <th>Title</th>
   <th>Description</th>
   <th># of pages</th>
   <th>Language</th>
   <th>Actions</th>
   </tr>
   </thead>
   <tbody>
   <c:forEach items="${books }" var="oneBook">
   <tr>
   <td>${oneBook.id}</td>
   <td> <a href="/books/${oneBook.id}"> ${oneBook.title }</a></td>
   <td>${oneBook.description }</td>
   <td>${oneBook.numberOfPages }</td>
   <td>${oneBook.language }</td>
   <td><a href="/books/${oneBook.id }/edit" class="btn btn-secondary">Edit</a></td>
   </tr>
   </c:forEach>
   </tbody>
   </table>
</div>
</body>
</html>