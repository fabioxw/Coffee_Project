<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
body{
background: url(4.png) no-repeat center center fixed; 
  	  -webkit-background-size: cover;
  	  -moz-background-size: cover;
      -o-background-size: cover;
      background-size: cover;
	}
</style>
<meta charset="UTF-8">
<title> Benvenuto in CoffeApp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="icon" href="1.ico" type="image/x-icon"/>
<link rel="shortcut icon" href="1.ico" type="image/x-icon"/>
</head>
<body>
<!-- Barra di navigazione iniziale, indirizzata alla registrazione o accesso  -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <div class="container-fluid">
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarColor01">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link active" href="#">Home
            <span class="visually-hidden">(current)</span>
          </a>
        </li>
        <li class="nav-item">
        <!--Se l'utente seleziona "Registrati" viene indirizzato verso la Servlet Registrazione.java  -->
          <a class="nav-link" href="./registrazione">Registrati</a>
        </li>
        <li class="nav-item">
          <!--Se l'utente seleziona "Accedi" viene indirizzato verso la Servlet Login.java  -->
          <a class="nav-link" href="./login">Accedi</a>
        </li>
 

      </ul>
    </div>
  </div>
</nav>

</body>
</html>