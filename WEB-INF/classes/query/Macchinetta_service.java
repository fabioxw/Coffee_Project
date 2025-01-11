package query;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.NamingException;
import java.util.HashMap;
import model.Macchinetta;
import model.Prodotto;
import model.Utente;

public class Macchinetta_service {
	private static String QueryID = "SELECT * FROM macchinetta WHERE idmacchinetta = ?";
    private static String QueryStato ="UPDATE macchinetta SET stato = ? WHERE idmacchinetta=?";
    private static String QueryLista="Select prodotto.* from  ((macchinetta INNER JOIN  possiede ON macchinetta.idmacchinetta=possiede.cod_macchinetta) INNER JOIN prodotto ON possiede.cod_prodotto= prodotto.idprodotto) WHERE macchinetta.idmacchinetta=?";
	private static String QueryConnessione="INSERT INTO  connessione(cod_macchinetta,email_utente) VALUES (?,?)";
	private static String QueryConnessioneUtente = "SELECT email_utente FROM connessione WHERE cod_macchinetta=?";
	private static String QueryDisconnessione="DELETE FROM connessione where cod_macchinetta= ? ";
	
	/*
	 * Gli viene passato l'id e ritorna disponibilità a  0 se libero, 1 se occupato,altri casi -1
	 */
	public int controlloDisponibilita(int id) throws SQLException, NamingException {
		Connection connection = Database.esecuzione();
		PreparedStatement statement = connection.prepareStatement(QueryID);
		statement.setInt(1,id);
		int disponibilita;
		ResultSet result = statement.executeQuery();
		if ((result.next())) {
			if(result.getInt("stato")==0){
				disponibilita=0;
				
			}else {
				disponibilita=1;	
			}
		}else {
			disponibilita=-1;
		}
		connection.close();
		return disponibilita;
	}
	
	/*
	 * Cambio i valore dello stato in base alle esigenze 
	 * da 1 a 0 se devo liberarla
	 * da 0 a 1 se devo occuparla
	 */
	public Macchinetta cambio(int id) throws SQLException, NamingException {
		//seleziono la macchinetta nel db in base all'id da front end
		Connection connection = Database.esecuzione();
		Macchinetta m = new Macchinetta();
		PreparedStatement statement = connection.prepareStatement(QueryID);
		statement.setInt(1,id);
		ResultSet result = statement.executeQuery();
		
		if(result.next()) {
			//se esiste allora setto i valori dal db e setto il bean
			m.setIDmacchinetta(result.getInt("idmacchinetta"));
			m.setModello(result.getString("modello"));
			m.setStato(result.getInt("stato"));
			
			switch(m.getStato()) {
			   case 0: {
				   //se è 0 setto a 1 cosi occupo la macchinetta modificando sia db che bean
				   PreparedStatement st = connection.prepareStatement(QueryStato);
				   st.setInt(1,1);
				   st.setInt(2, id);
				   st.executeUpdate();
				   m.setStato(1);
				  break;
			   }
			   //se è a 1 la setto a 0 e la libero  settando sia db che bean
			   case 1: {
				   PreparedStatement st = connection.prepareStatement(QueryStato);
				   st.setInt(1,0);
				   st.setInt(2, id);
				   st.executeUpdate();
				   m.setStato(0);
			   }
			   default: break;
			}
		}	
		connection.close();
		return m;
	}
	
	/*
	 * Check,serve per controllare l'esistenza della macchinetta 
	 */
	public Macchinetta check(int id) throws SQLException, NamingException {
		Connection connection = Database.esecuzione();
		Macchinetta m=null;
		PreparedStatement statement=connection.prepareStatement(QueryID);
		statement.setInt(1,id);
		ResultSet result = statement.executeQuery();
		if(result.next()) {
			m=new Macchinetta();
			m.setIDmacchinetta(result.getInt("idmacchinetta"));
			m.setModello(result.getString("modello"));
			m.setStato(result.getInt("stato"));
			//visto che sto settando il bean,gli associo i prodotti presenti
			m.setListaProdotti(this.associazione(id));
		
		}
		
		connection.close();
		return m;
		
	}
	
	/*
	 * Creo un hashmap in cui l'id prodotto è la chiave e il valore è il prodotto.
	 * Seelzioni i prodotti posseduti dalla macchinetta e setto il bean.
	 * 
	 */
	public HashMap<Integer,Prodotto> associazione(int id) throws SQLException, NamingException{
		HashMap<Integer,Prodotto> m=new HashMap<Integer,Prodotto>();
		Connection connection = Database.esecuzione();
		PreparedStatement statement=connection.prepareStatement(QueryLista);
		statement.setInt(1,id);
		ResultSet result = statement.executeQuery();
	    if(result.next()) {
	    	do { //uso il do/while per scorrere la lista fino ad esaurimento
		    	Prodotto p=new Prodotto();
		    	p.setId(result.getInt("idprodotto"));
		    	p.setNome(result.getString("nome"));
		    	p.setDescrizione(result.getString("tipo"));
		    	p.setCosto(result.getInt("costo"));
		    	m.put(result.getInt("idprodotto"), p);
	    	}while(result.next());
	    }
	    else
	    {
	    	m=null;
	    }
		connection.close();
		return m;
	}
	
	/* metodo per effettuare associaione Macchinetta-Utente,
	inserisco nella tabella connessione una tupla corrispondente
	con id della macchinetta e la mail presa dalla sessione
	*/
	public void connetti(int idm,String emailu) throws NamingException, SQLException {
		Connection connection = Database.esecuzione();
		PreparedStatement statement=connection.prepareStatement(QueryConnessione);
		statement.setInt(1,idm);
		statement.setString(2, emailu);
		statement.executeUpdate();
		
	}
	
	/*
	 * Dato l'id della macchinetta mi permette di ricavare la mail dell' utente ad esso connesso
	 */
	public String getEmailUtente(int idm) throws NamingException, SQLException {
		Connection connection = Database.esecuzione();
		PreparedStatement statement = connection.prepareStatement(QueryConnessioneUtente);
		statement.setInt(1, idm);
		ResultSet res = statement.executeQuery();
		String u_email = null;
		if(res.next()) {
			u_email = res.getString("email_utente");
		
		}
		connection.close();
		return u_email;
	}
	
	/*
	 * Metodo inverso a connessione, serve per eliminare la tupla nella tabella corrispondente all' id
	 */
	public void disconnessione(int id) throws NamingException, SQLException {
		Connection connection = Database.esecuzione();
		PreparedStatement statement = connection.prepareStatement(QueryDisconnessione);
		statement.setInt(1, id);
		statement.executeUpdate();
		
	}
	
	
	
}
