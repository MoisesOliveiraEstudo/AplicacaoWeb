<%@ taglib prefix = "c" 
   uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Orçamento</title>
<link rel="stylesheet" href="style/index.css">
</head>
	
<body>
	<form action="form" method="POST"> 
		<table border="1">
			<tr>
			<th>Peça</th>
			<th>Valor</th>
			</tr>
			<tr>
				<td><input type="text" name="peca" ></td>
				<td><input type="number" name="preco" ></td>
			</tr>
			<tr>
				<td><input type="text" name="peca"></td>
				<td><input type="number" name="preco"></td>
			</tr>
			<tr>
				<td><input type="text" name="peca" ></td>
				<td><input type="number" name="preco"></td>
			</tr>

			<tr>
				<td>Total</td>
				<td><input type="number" value="<c:out value='${total}'/>" disabled></td>
			</tr>
		</table>
		<input type="submit" class="btn-calcular" value="Calcular">
	</form>
</body>
</html>