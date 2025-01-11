package controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Utente;
import query.Utente_service;

/**
 * Servlet implementation class Login
 */
@WebServlet("/login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    //Indirizzo verso la vista login per permettere all'utente di accedere
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String address= "/WEB-INF/view/login.jsp";
		request.getRequestDispatcher(address).forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//prendo i parametri dalla richiesta
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		Utente_service us = new Utente_service();
		Utente u = null;
		
		try {
			/*
			 * Il metodo accedi mi restituisce l'utente se è presente nel db,diversamente è null.
			 */
			u = us.accedi(email,password);
			//Quindi se il l'utente non è null allora lo posso mandare
			if(u!= null) {
				HttpSession session = request.getSession(true);
				session.setAttribute("user", u);
				response.setCharacterEncoding("UTF-8");
				response.setContentType("text/plain");
				String address= "Vutente";
			    response.getWriter().write(address);
			}else{
				//se non esiste allora segnalo una generica problematica di identificazione
				String error="Problemi con l'utente!!";
				response.setCharacterEncoding("UTF-8");
				response.setContentType("text/plain");
				response.getWriter().write(error);
			}
		} catch (NoSuchAlgorithmException | SQLException | NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
	}

}
