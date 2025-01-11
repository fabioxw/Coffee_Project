package controller;
import model.Utente;
import query.Utente_service;
import java.io.IOException;
import java.sql.SQLException;
import java.security.NoSuchAlgorithmException;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet implementation class Registrazione
 */
@WebServlet("/registrazione")
public class Registrazione extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Registrazione() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    //Con questa richiesta Get, indirizzo verso la vista che permette all' utente di registrarsi
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String address= "/WEB-INF/view/registrazione.jsp";
		request.getRequestDispatcher(address).forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	//
	//Da registrazione.jsp faccio una richiesta asincrona Post, passando i dati inseriti nel form
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nome = request.getParameter("nome");
		String cognome = request.getParameter("cognome");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		Utente u=new Utente();
		Utente_service us = new Utente_service();
	
		try {
			//una volta presi dalla richiesta i parametri, registro l'utente
			u=us.registrazione(nome, cognome, email, password);
			if( u != null) {
				//se l'utente non è nullo allora inserisco in sessione  con  chiave user 
				HttpSession session = request.getSession(true);
				session.setAttribute("user", u);
				response.setCharacterEncoding("UTF-8");
				response.setContentType("text/plain");
				String address= "Vutente";
			    response.getWriter().write(address);
			    
				//Nel caso in cui l'utente sia già presente,viene lanciato un errore.
			} else {
			  	String error="Questa mail risulta già utilizzata";
				response.setCharacterEncoding("UTF-8");
				response.setContentType("text/plain");
				response.getWriter().write(error);
			}
		} catch (NamingException | SQLException | NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		
		
	}

}
