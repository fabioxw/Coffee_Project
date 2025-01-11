<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<style>

		.container {
					background: #FFF; 
					font-size: 1.2em;
					margin: 0 auto;
					padding: 0 10px 4px;
					width: 780px;
		}
	</style>
	<meta charset="UTF-8">
	<link href="style.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src='jquery-3.6.0.min.js'></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
	<title>Registrati</title>
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
          <a class="nav-link" href="#">Registrati</a>
          <span class="visually-hidden">(current)</span>
        </li>
      </ul>
    </div>
  </div>
</nav>

<center>
   <form  id="form1">
      <div class="form-group">
        <label for="nome">Nome</label>
        <input type="text" name="nome" class="form-control">
      </div>
      <div class="form-group">
        <label for="cognome">Cognome</label>
        <input type="text" name="cognome" class="form-control">
      </div>
 
      <div class="form-group">
        <label for="email">Email</label>
        <input type="text" name="email" class="form-control">
      </div>
 
      <div class="form-group">
        <label for="password">Password</label>
        <input type="password" name="password" id="mypwd" class="form-control">
      </div>
      
       <div class="form-group">
        <label for="password">Ripeti Password</label>
        <input type="password" name="ripetizionePassword" class="form-control">
      </div>
       
      <div class="form-group">
        <!-- <input type="submit" value="Registrati" class="submit" class="form-control"> -->
       <br><button type="submit"  class="btn btn-primary">Registrati</button>
      </div>
      <div id="container">
      </div>
    </form>
</center>
<br><br>

</body>

<script>
	$().ready(function() {
    // Validazione per la password,sfruttando una  regex
		$.validator.addMethod( "regex", function(value, element, regexp) {
 	   	var passRe = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[!_@#\$%\^&\*]).{5,20}$/;
  	  	return this.optional(element) || passRe.test(value);
	  	},
	"La password deve essere tra 5 e 20 caratteri e deve contenere maiuscole,minuscole, un numero e un carattere speciale "
		);
    
    //Validazione per email,dando un formato valido
	$.validator.addMethod("email", function(value, element) {
		var e= /^[a-zA-Z0-9._-]+@[a-zA-Z0-9-]+\.[a-zA-Z.]{2,4}$/;
    	return this.optional(element) || e.test(value);
	},
	"Forse la mail non è corretta,controlla meglio"
	);

    
    //validate del form registrazione
    $("#form1").validate({
        // Definiamo le nostre regole di validazione
        rules : {
           
            nome : {
              // Definiamo il campo nome come obbligatorio
              required : true
            },
            cognome : {
                // Definiamo il campo cognome come obbligatorio
                required : true
              },
            
            email : {
            	//Campo obbligatorio e validazione formato 
                required : true,
                email : true
            },
            password : {
                required : true,
                // Settiamo la lunghezza minima e massima per il campo password,oltre a campo obbligatorio e formato 
                minlength : 5,
                maxlength : 20,
                regex : true
            },
            //il contenuto di questo campo deve essere uguale al contenuto del campo "mypwd"
            ripetizionePassword : {
            	      required : true,
            	      equalTo: "#mypwd"
            	    
            }
        },
        // Personalizzo i mesasggi di errore
        messages: {
            nome: "Inserisci il tuo nome",
            ripetizionePassword : "Ripeti la password inserita precedentemente",
            cognome: "Inserisci il tuo cognome ",
            password: {
                required: "Inserisci una password",
                minlength: "La password deve essere lunga minimo 5 caratteri",
                maxlength: "La password deve essere lunga al massimo 20 caratteri"
            },
            email: "Inserisci la tua email in formato corretto",
        },
        
        // Settiamo il submit handler per la form,mandando una richiesta asincrona
        
        submitHandler: function(form) {
        	$.ajax({
				type: 'POST', 
				url: './registrazione',
				data: $(form).serialize(),
				success: function (res,textSatus, jqXHR) {
					if(res != "Questa mail risulta già utilizzata"){
						window.location=res;
					} else {
						$("#container").html(res);
					}
				},
			}) 
            
        }
    });

   
});

</script>
</html>