package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Utente;
import query.Macchinetta_service;
import query.Utente_service;



/**
 * Servlet implementation class Logout
 */
@WebServlet("/Logout")
public class Logout extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Logout() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 HttpSession sessione = request.getSession(false);
	        Utente u= null;
	        if( sessione.getAttribute("user")!=null || sessione != null ) {
	        	
	        	Macchinetta_service ms=new Macchinetta_service();
	        	try {
	        		if(sessione.getAttribute("macchinettaID") != null) {
	        			int macchinettaID = (Integer) sessione.getAttribute("macchinettaID");
	        			/*Non sapendo se l'utente lascia connessioni aperte, per uscire 
	        			 * viene disconnesso e viene cambiato il valore dell' id.
	        			 */
	        			ms.disconnessione(macchinettaID);
						ms.cambio(macchinettaID);
						sessione.removeAttribute("user");
						sessione.invalidate();
	        		} else {
	        			sessione.removeAttribute("user");
	        			sessione.invalidate();
	        		}
					
				} catch (NamingException | SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	        	
	        	
	        }  
        	System.out.println("logout effettuato!");
			String address= "/index.jsp";
			request.getRequestDispatcher(address).forward(request, response);
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
