<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
body{
	background: url(caf.jpg) no-repeat center center fixed; 
  		  -webkit-background-size: cover;
  	  	-moz-background-size: cover;
     	 -o-background-size: cover;
     	 background-size: cover;
	}
</style>
	<meta charset="UTF-8">
	<title>Benvenuto</title>
	<link href="style.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src='jquery-3.6.0.min.js'></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
	<link rel="icon" href="1.ico" type="image/x-icon"/>
	<link rel="shortcut icon" href="1.ico" type="image/x-icon"/>
</head>

<body>

<form id="form2"> 
 	<center>
      	<div class="form-group">
        <label for="text">Inserisci ID della macchinetta</label>
        <input type="text" name="macchinettaID" id="macchinettaID" class="form-control">
      	</div>
       
      	<div class="form-group">
       		<button type="submit"  class="btn btn-primary">VISUALIZZA</button>
      	</div>
     </center>
      
</form>
    <br>
	<div id="container2">
     </div>
</body>

<script>
$(document).ready(function () {
	//validazione del corretto formato id
	function validateID($id) {
			var vID = /^[0-9]+$/;
			return vID.test($id);
		}
	
	$("#form2").submit(function(event) {
		event.preventDefault();
	//Controllo se l'id inserito è corretto e nel caso lo fosse faccio richiesta per la servlet
		var idm = $("#macchinettaID").val(); 
        if(validateID(idm)) {
        	$.ajax({
				type: 'GET', 
				url: './GestioneMacchinetta/Acquisto',
				data: $(this).serialize(),
				success: function (res, textSatus, jqXHR) {
					$("#container2").html(res);
				},
			}) 
        } else {
        	$("#container2").html("Inserisci correttamente i dati");
        }
			
	})

	
	
	
})

	
</script>
</html>