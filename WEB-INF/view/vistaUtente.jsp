<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link href="stile.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src='jquery-3.6.0.min.js'></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">

	<title>Vista Utente</title>

	<link rel="icon" href="1.ico" type="image/x-icon"/>
	<link rel="shortcut icon" href="1.ico" type="image/x-icon"/>
	<style>
	.logo {
      display:block;
      margin:0px auto;
      text-align:center;
      }
	</style>
</head>

<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  		<div class="container-fluid">
    		  <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
    		  <span class="navbar-toggler-icon"></span>
    		</button>
    	<div class="collapse navbar-collapse" id="navbarColor01">
      		<ul class="navbar-nav me-auto">
        		<li class="nav-item">
          	 		<a class="nav-link active" href="Vutente">Home</a>
        		</li>
        		<li class="nav-item">
        		  <a class="nav-link" href="#" id="C">Connettiti</a>
         		  <span class="visually-hidden">(current)</span>
       			</li>
       		 	<li class="nav-item">
        	  		<a class="nav-link" href="#" id="r">Credito</a>
        		</li>
        		<li class="nav-item">
          		  <a class="nav-link" href="#" id="EC" >Elimina Account</a>
        		</li>
        		<li class="nav-item">
          		  <a class="nav-link" href="./Logout" id="e" >Esci</a>
        		</li>
      		</ul>
       </div>
     </div>
  </nav>

   <div id="container">
         <center>
            <div id="top">
           			<marquee><center><img src="3.png" id="logo" width="300" height="300" ></center>
                 	Ciao ${user.nome},Benvenuto nella tua area riservata!
                 	</marquee>
                <br>
            </div>
            </center>
            
            <center>		
            <iframe  style: width=420px; height=620px; name="fint" src="Macchinetta.png"></iframe>
            </center>	
    </div>
	<div id="prova">	
	
	</div>
	</center>
</body>
<script>
$(document).ready(function () {
			$("#C").on("click", function (){
				$.ajax({
					type: 'GET',
					url: './ConnessioneMacchinetta',
					success: function(res) {
						$('#container').html(res);
					}
				})
			})
			
			$("#r").on("click", function (){
				$.ajax({
					type: 'GET',
					url: './credito',
					success: function(res) {
						$('#container').html(res);
					}
				})
			})
			$("#EC").on("click", function (){
				$.ajax({
					type: 'POST',
					url: './eliminazione',
					success: function(res) {
						window.location = "./index.jsp";
						
					}
				})
			})
			
			
		})
</script>
</html>