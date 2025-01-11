package controller;

import java.io.IOException;
import model.Utente;
import java.sql.SQLException;

import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import query.Macchinetta_service;
import query.Utente_service;

/**
 * Servlet implementation class Macchinetta
 */

@WebServlet(urlPatterns = {"/Macchinetta", "/Disconnessione"})
public class Macchinetta extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Macchinetta() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String address = null;
		String uri = request.getRequestURI();
		Utente u = new Utente();
		
		try {
			switch(uri) {
			    //caso  connessione
				case "/CaffeVilla/Macchinetta": {
					//prendo l'id e controllo la disponibilità
					String identificativo=request.getParameter("macchinettaID");
					Macchinetta_service ms=new Macchinetta_service();
					switch(ms.controlloDisponibilita(Integer.parseInt(identificativo))) {
					
						case 1:{
							// se il risultato del controllo è 1 è occupata
							String error="La macchinetta è già occupata,scegline un'altra ";
							response.setCharacterEncoding("UTF-8");
							response.setContentType("text/plain");
							response.getWriter().write(error);
							break;
						}
						case 0:{
							/*
							 * Se la macchinetta selezionata è libera allora vado a connettermi.
							 * Prima cambio lo stato nel db
							 */
							ms.cambio(Integer.parseInt(identificativo));
							HttpSession session = request.getSession(false);
							u = (Utente) session.getAttribute("user");
							session.setAttribute("macchinettaID", Integer.parseInt(identificativo));
							ms.connetti(Integer.parseInt(identificativo),u.getEmail());
							String error="Ciao,sei connesso alla macchinetta";
							response.setCharacterEncoding("UTF-8");
							response.setContentType("text/plain");
							response.getWriter().write(error);
							break;
							
						}
						case -1:{
							//altri casi
							String error="Non esiste questa macchinetta,riprova";
							response.setCharacterEncoding("UTF-8");
							response.setContentType("text/plain");
							response.getWriter().write(error);
							break;
						}
						default:
							String error="Hai inserito valore non valido";
							response.setCharacterEncoding("UTF-8");
							response.setContentType("text/plain");
							response.getWriter().write(error);
							break;					
						}
					break;
				}
				//caso disconnessione
				case "/CaffeVilla/Disconnessione": {
					HttpSession session = request.getSession(false);
					Macchinetta_service ms=new Macchinetta_service();
					Utente_service us = new Utente_service();
					Utente u_old = null;
					Utente u_new = null;
					if(session.getAttribute("macchinettaID") != null) { //se l'attributo in sessione non è nullo
						int macchinettaID = (Integer) session.getAttribute("macchinettaID");
	        			ms.disconnessione(macchinettaID); //elimino la connessione tra utente e macchinetta
						ms.cambio(macchinettaID);	 // cambio la disponibilità
						u_old = (Utente) session.getAttribute("user");
						u_new = us.ricavaUtente(u_old.getEmail());
						session.removeAttribute("user");
						session.setAttribute("user", u_new); 
						String disc="Ti sei disconnesso con successo!";
						response.setCharacterEncoding("UTF-8");
						response.setContentType("text/plain");
						response.getWriter().write(disc);
					
					} else {
						String disc="Ti sei disconnesso con successo!";
						response.setCharacterEncoding("UTF-8");
						response.setContentType("text/plain");
						response.getWriter().write(disc);
					}
					break;
				}
				default: break;
			}
			
		} catch (NumberFormatException | SQLException | NamingException e) {
			
		}
		
		
	
		
		
		
		
	}

}
