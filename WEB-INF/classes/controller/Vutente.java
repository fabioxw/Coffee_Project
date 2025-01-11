package controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

import model.Utente;

import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import query.Macchinetta_service;
import query.Utente_service;

/**
 * Servlet implementation class Vutente
 */
@WebServlet(urlPatterns = {"/Vutente", "/ConnessioneMacchinetta", "/credito","/eliminazione"})
public class Vutente extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Vutente() {
        super();
        // TODO Auto-generated constructor stub
    }
    

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String address = null;
		String uri = request.getRequestURI();
		//Prendo la sessione corrente
		HttpSession session = request.getSession(false);
		/*
		 * Metto  reindirizzamenti per non fare accedere a chi non è ancora autenticato
		 * nelle sezioni dedicate all' utente
		 * 
		 */
		if(session == null || (session.getAttribute("user") == null)) {
			if(uri.endsWith("ConnessioneMacchinetta") || uri.endsWith("credito") || uri.endsWith("eliminazione")) {
				response.sendRedirect("index.jsp");
			} else {
				response.sendRedirect("index.jsp");
			}
		} else {
			/*Diversamente se la sessione non è nulla 
			ogni volta che passo dalla sessione mi resetta le cache.
			In base al valore dell' uri lo indirizzo su viste differenti
			*/
			response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
			response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
			response.setDateHeader("Expires", 0);
			
			
			switch(uri) {
			   //richiesta proveniente da vistaUtente.jsp per accedere alla vista connessione
				case "/CaffeVilla/ConnessioneMacchinetta": { 
					address= "/WEB-INF/view/vistaConnessione.jsp";
					request.getRequestDispatcher(address).forward(request, response);
					break;
				} //richiesta proveniente da vistaUtente.jsp per accedere alla vista ricarica credito
				case "/CaffeVilla/credito": {
					address= "/WEB-INF/view/vistaRicarica.jsp";
					request.getRequestDispatcher(address).forward(request, response);
					break;
				} //indirizzamento verso la pagina home utente una volta autenticati
				case "/CaffeVilla/Vutente": {
					address= "/WEB-INF/view/vistaUtente.jsp";
					request.getRequestDispatcher(address).forward(request, response);
					break;
				}
				default:
					break;
			}
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String address = null;
		String uri = request.getRequestURI();
		try {
			switch(uri) {
			//Richiesta proveniente da VistaRicarica una volta inseriti i dati giusti per l'accredito.
			case "/CaffeVilla/credito": {
				/*
				 * prendo la sessione corrente e da li i corrispettivi
				 * parametri password e credito 
				 */
				HttpSession session = request.getSession(false);
				String password = request.getParameter("password");
				int amount = (int) Float.parseFloat(request.getParameter("myImport")); 
				Utente u_old = (Utente) session.getAttribute("user");
			    Utente u_new=null; 
			    Utente_service us=new Utente_service();
			    u_new=us.incremento(u_old.getEmail(), password, amount);
			    
			    /*se il nuovo utente è nullo significa che nel metodo incremento qualcosa non è andata
			     * quindi segnalare messaggio di errore */
			    if(u_new == null) {
			    	String error="Password errata!";
					response.setCharacterEncoding("UTF-8");
					response.setContentType("text/plain");
					response.getWriter().write(error);
			    } else {
			    	// se tutto va bene allora aggiorno l'utente nuovo in sessione e segnalo l'accredito 
			    	session.removeAttribute("user");
					session.setAttribute("user", u_new);
					String success="Credito ricaricato!";
					response.setCharacterEncoding("UTF-8");
					response.setContentType("text/plain");
					response.getWriter().write(success);
			    }
				break;
			}
			/*
			 * Prendo la mail dalla sessione e viene eliminato l'account
			 */
			case "/CaffeVilla/eliminazione":{
				HttpSession sessione = request.getSession(false);
				Utente u_old = (Utente) sessione.getAttribute("user");
				Utente_service us=new Utente_service();
				Macchinetta_service ms=new Macchinetta_service();
				String mail=u_old.getEmail();
				if( sessione.getAttribute("macchinettaID")!= null  ) {
					int idm=(int) sessione.getAttribute("macchinettaID");
					  ms.disconnessione(idm);
					  ms.cambio(idm);
							}
				us.cancella(mail);
				sessione.invalidate();
				address= "/index.jsp";
				request.getRequestDispatcher(address).forward(request, response);
				break;
			}
			
			default:
				break;
		}
		} catch (NoSuchAlgorithmException | SQLException | NamingException e) {
			e.printStackTrace();
		}
		
		
	}

}
