<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Acquista cosa preferisci</title>
</head>
<body>
<div id=scelta>
         <table class="table table-dark table-striped">

          <tr>
				<th>ID</th>
				<th>Modello</th>
				<th>Stato</th>
			
			</tr>
			<tr>
				<td>${macchinetta.idmacchinetta}</td>
				<td>${macchinetta.modello}</td>
				<td>${macchinetta.stato}</td>
					
				

		</table>      
</div>	
	
	
	
	
<br><br>
	<div id="acquisto" align="center">
	<table id="tabellaProdotti" class="table table-success table-striped">
  <tr>
				<th>ID</th>
				<th>Nome</th>
				<th>Descrizione</th>
				<th>Prezzo(in euro)</th>
			</tr>
			
			     <c:forEach var="element" items="${macchinetta.listaProdotti}">
						<tr>
							<td>${element.key}</td>
							<td>${element.value.nome}</td>
							<td>${element.value.descrizione}</td>
							<td>${element.value.costo}</td>				
						</tr>
						</c:forEach>
						
					
</table>





		<form id="form1" novalidate>
			<div class="form-group">
				<label for="prodottoID"  class="form-label">ID prodotto</label><br>
				<input type="text" id="prodottoID" name="prodottoID" class="form-control w-25 productsel" required><br>
				<div class="invalid-feedback">Prodotto valido</div>
			</div>
				
				
			<div class="form-group">
			 <input type="hidden" id="idmacchinetta" name="idmacchinetta" value="${macchinetta.idmacchinetta}">
			</div>
			<input type="submit" value="invia" class="btn btn-primary">
		</form>
	</div>
	<center>
	<div id="container3">
	</div>
	</center>
</body>

<script>

$(document).ready(function () {
	//validazione dell' id inserito
	function validateID($id) {
			var pID = /^[0-9]+$/;
			return pID.test($id);
		}
	
	$("#form1").submit(function(event) { // se la validazione è corretta allora faccio richiesta
		event.preventDefault();
		var idp = $("#prodottoID").val();
        if(validateID(idp)) {
        	$.ajax({
				type: 'POST', 
				url: './GestioneMacchinetta/Acquisto',
				data: $(this).serialize(),
				success: function (res, textSatus, jqXHR) {
					$("#container3").html(res);
				},
			}) 
        } else {
        	$("#container3").html("Inserisci correttamente i dati");
        }
			
	})
	
	 // aggionamento della pagina autonomo dopo 20 secondi
	setInterval(function(){
			var idm = $("#idmacchinetta").val();
			$.ajax({
			    url: './GestioneMacchinetta/Acquisto',
			    type: 'GET',
			    data: jQuery.param({ macchinettaID: idm}),
			    success: function (res) {
			    	$("#container2").html(res);
			    },
			});
		}, 20000)
	
	
	
	
	
})



</script>
</html>