<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Accedi</title>
	<script type="text/javascript" src='jquery-3.6.0.min.js'></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
	<link href="style.css" rel="stylesheet" type="text/css">
	<link rel="icon" href="1.ico" type="image/x-icon"/>
	<link rel="shortcut icon" href="1.ico" type="image/x-icon"/>
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
          <a class="nav-link active" href="./index.jsp">Home
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Accedi</a>
          <span class="visually-hidden">(current)</span>
        </li>

      </ul>
    </div>
  </div>
</nav>

<!-- Form per inserire le credenziali di accesso -->
<center>
   <form  id="form1">
      
      <div class="form-group">
        <label for="email">Email</label>
        <input type="text" name="email" class="form-control">
      </div>
      <div class="form-group">
        <label for="password">Password</label>
        <input type="password" name="password" class="form-control">
      </div>
       
      <div class="form-group">
        <input type="submit" value="Invia" class="submit" class="form-control">
      </div>
    </form>


<div id="container">
</div>
</center>
</body>

<script>
	$(document).ready(function() {
	        //Validazione per il campo email per fare rispettare un certo formato 
		$.validator.addMethod("email", function(value, element) {
			var e=/^[a-zA-Z0-9._-]+@[a-zA-Z0-9-]+\.[a-zA-Z.]{2,4}$/;
	    	return this.optional(element) || e.test(value);
		});
     //validazione form
    $("#form1").validate({
        rules: {
            email: { //deve essere sia obbligatorio che rispettata la validazione
                required: true,
                email: true
            },
            password: "required"
        },
         //vengono stabiliti i messaggi di errore
        messages: {
            email: {
                required: "Inserire la tua mail",
                email: "Inserire un email di formato valido"
            },

            password: "Inserire la tua password"
        },
        
        submitHandler: function(form) {
         //richiesta verso la servlet Login.java
            $.ajax({ 
                   method: "POST", 
                   url: "./login", 
                   data: $(form).serialize(), 
                   success: function(response, textSatus, jqXHR) { 
                    if (response == "Vutente" ) {
                           location.href = response;
                      } else {
                          $("#container").html(response);
                    }
                   } 
               }); 
           }
    });
});
</script>
</html>