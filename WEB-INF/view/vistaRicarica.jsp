<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Ricarica</title>
	<link href="style.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src='jquery-3.6.0.min.js'></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
	<link rel="icon" href="1.ico" type="image/x-icon"/>
	<link rel="shortcut icon" href="1.ico" type="image/x-icon"/>
</head>

<body>
<div id="credit">Credito Residuo: ${user.credito}</div>
<br>
	 <form id="form2"> 
 
      <div class="form-group">
        <label for="password">Password</label>
        <input type="password" name="password" id="mypwd" class="form-control">
      </div>
      
       <div class="form-group">
        <label for="text">importo da inserire</label>
        <input type="text" name="myImport" id="myImport" class="form-control">
      </div>
       
      <div class="form-group">
       <br><button type="submit"  class="btn btn-primary">INVIA</button>
      </div>
      <div id="container2">
      </div>
      
    </form>

<script>
         //validazione per il credito affinchè siano messi valori corretti
		$(document).ready(function () {
			function validateCreditAmount($credit) {
 				var creditRegEx = /^[0-9]+$/;
 				return creditRegEx.test($credit);
 			}
			//validazione per la password
			function validatePassword($password) {
				var passwReg = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,20}$/;
				return passwReg.test( $password );
			}
			
			$("#form2").submit(function(event) {
				event.preventDefault();          
				var amount = $("#myImport").val(); 
		        var pwd = $("#mypwd").val();
		        //controllo se i miei valori inseriti sono validi 
		        if(validatePassword(pwd) && validateCreditAmount(amount)) {
		        	//se entrambe le validazioni sono valide proseguo 
		        	$.ajax({
						type: 'POST', 
						url: './credito',
						data: $(this).serialize(),
						success: function (res, textSatus, jqXHR) {
							$("#container2").html(res);
						},
					}) 
					//in alternativa indico un messaggio come errore 
		        } else {
		        	$("#container2").html("Inserisci correttamente i dati");
		        }
					
			})
		})	
</script>
</body>
</html>