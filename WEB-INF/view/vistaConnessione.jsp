<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Connettiti con la macchinetta</title>
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
       		<button type="submit" name="conn" id="conn" class="btn btn-primary">Connettiti</button>
       		<button type="submit" name="disc" id="disc" class="btn btn-primary" hidden>Disconnettiti</button>
      	</div>
      </center>
      
      
    </form>
	<div id="container2">
     </div>
</body>
<script>
	
	$(document).ready(function () {
	//validazione per l'id della macchinetta che viene inserita dall' utente
	function validateID($id) {
			var vID = /^[0-9]+$/;
			return vID.test($id);
		}
	
	
	$("#form2").submit(function(event) {
		event.preventDefault();
		//prendo il valore dell' id per poterlo sottoporre al validate
		var idm = $("#macchinettaID").val(); 
		if( $("#conn").prop('hidden') == false ) {
			if(validateID(idm)) { // se i parametri sono corretti faccio richiesta verso la servlet
	        	$.ajax({
	        		type: 'POST', 
					url: './Macchinetta',
					data: $(this).serialize(),
					success: function (res, textSatus, jqXHR) {
						if(res.trim() == "La macchinetta è già occupata,scegline un'altra") {
							$("#container2").html(res);
						} else{
							$("#conn").prop('hidden',true);
							$("#disc").prop('hidden',false);
							$("#container2").html(res);
						}
						
					},
				})
			}  else { // se non sono corretti i dati scrivo nel div l'errore
        		$("#container2").html("Inserisci correttamente i dati");
        	}
		 } else {
			 if(validateID(idm)) { // se i parametri sono corretti faccio richiesta verso la servlet
		        	$.ajax({
		        		type: 'POST', 
						url: './Disconnessione',
						data: $(this).serialize(),
						success: function (res, textSatus, jqXHR) {
							
							$("#conn").prop('hidden',false);
							$("#disc").prop('hidden',true);
							
							$("#container2").html(res);
						},
					}) 
		 		}  else { // se non sono corretti i dati scrivo nel div l'errore
	        	 $("#container2").html("Inserisci correttamente i dati");
	          }
		 }
			
	})
})

</script>

</html>