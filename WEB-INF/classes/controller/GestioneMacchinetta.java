package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import query.Macchinetta_service;
import query.Prodotto_service;
import query.Utente_service;
import model.Macchinetta;
import model.Prodotto;
import model.Utente;

/**
 * Servlet implementation class GestioneMacchinetta
 */
@WebServlet(urlPatterns ={"/GestioneMacchinetta","/IngressoMacchinetta","/GestioneMacchinetta/Acquisto"})
public class GestioneMacchinetta extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneMacchinetta() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String address = null;
		String uri = request.getRequestURI();
		switch(uri) {
			
			case "/CaffeVilla/IngressoMacchinetta": {
				address= "/WEB-INF/view/vistaMacchinette.jsp";
				request.getRequestDispatcher(address).forward(request, response);
				break;
			}
			case "/CaffeVilla/GestioneMacchinetta/Acquisto": {
				//ricevo la richiesta dalla vistaMacchinette.jsp e prendo l'id della macchinetta
				String id=request.getParameter(("macchinettaID"));
				Macchinetta_service ms=new Macchinetta_service();
				Macchinetta ma = new Macchinetta();
				
				try {
					//controllo se esiste e mi salvo l'intera macchinetta sulla variabile ma
					ma = ms.check(Integer.parseInt(id));
					if(ma!=null) {
						//setto la risposta da mandare alla pagina 
						request.setAttribute("macchinetta",ma);
						address= "/WEB-INF/view/vistaAcquisti.jsp";
						request.getRequestDispatcher(address).forward(request, response);
					}
				} catch (NumberFormatException | SQLException | NamingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				break;
			}
			default:
				break;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String address = null;
		String uri = request.getRequestURI();
		Utente u = new Utente();
		Prodotto p = new Prodotto();
		
		switch(uri) {
		
			case "/CaffeVilla/GestioneMacchinetta/Acquisto": {
				Macchinetta_service ms=new Macchinetta_service();
				Utente_service us=new Utente_service();
				Prodotto_service ps=new Prodotto_service();
				//prendo id prodotto e macchinetta dal frontend
				int idm=Integer.parseInt(request.getParameter("idmacchinetta"));
				int idp=Integer.parseInt(request.getParameter("prodottoID"));
				try {
					//ricavo email dell' utente
					String email_utente = ms.getEmailUtente(idm);
	
					u = us.ricavaUtente(email_utente);
					p = ps.trovaProdotto(idm, idp);
					
					//se il prodotto non è disponibile 
					if(p == null) {
						String error="Prodotto non disponibile!";
						response.setCharacterEncoding("UTF-8");
						response.setContentType("text/plain");
						response.getWriter().write(error);
					} else if(u.getCredito() >= p.getCosto()) { //se il credito è sufficiente
						us.decrementoCredito(u, p.getCosto());
						ps.decrementoQuantita(idm, idp);
						String success="Prodotto  " + p.getNome() + "  acquistato con successo!" ;
						response.setCharacterEncoding("UTF-8");
						response.setContentType("text/plain");
						response.getWriter().write(success);						
						
					} else if(u.getCredito() < p.getCosto()) { //se il credito è insufficiente
						String error="Credito insufficiente!";
						response.setCharacterEncoding("UTF-8");
						response.setContentType("text/plain");
						response.getWriter().write(error);
					}
					
					
				} catch (NamingException | SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				
				break;
			}
			default:
				break;
		}
		
	}

}
