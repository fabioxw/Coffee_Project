package query;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import javax.naming.NamingException;
import model.Utente;
import util.Encryption;
import model.Prodotto;

public class Utente_service {
	private static String QueryEmail = "SELECT * FROM utente WHERE email = ?";
	private static String QueryInserisci ="INSERT INTO utente (nome, cognome, email, password,credito) VALUES (?,?,?,?,0)";
    private static String QueryCancella="DELETE  FROM UTENTE WHERE email=?";
	private static String QueryPassword="SELECT * FROM utente WHERE password = ?";
	private static String UpdateCredito="UPDATE utente SET credito=credito + ? WHERE email=?";
	private static String UpdateAcquisto= "UPDATE utente SET credito=credito - ? WHERE email=?";
	
	
	/*
	 * Registrazione dell' utente
	 */
	public Utente registrazione(String nome,String cognome,String email,String password) throws SQLException,NoSuchAlgorithmException,NamingException {
	  
		Connection connection = Database.esecuzione();
		PreparedStatement statement = connection.prepareStatement(QueryEmail);
		statement.setString(1, email);
		Encryption e= new Encryption();
		e.setPlainPassword(password);
		String passwordCifrata = e.cypherPass();
		Utente u=null;
		ResultSet result = statement.executeQuery();
		//se l'utente non esiste allora significa che posso crearlo
		if (!(result.next())) {
			PreparedStatement statement1 = connection.prepareStatement(QueryInserisci);
			statement1.setString(1, nome);
			statement1.setString(2, cognome);
			statement1.setString(3, email);
			statement1.setString(4, passwordCifrata);
			statement1.executeUpdate();
			u=new Utente();
			u.setNome(nome);
			u.setCognome(cognome);
			u.setEmail(email);
			u.setCredito(0);
		}
		//in alternativa non ha senso crearlo e restituisco l'utente vuoto
		connection.close();
		return u;
		
	}
	
	/*
	 * Accesso di un utente
	 */
	public Utente accedi(String email,String password) throws SQLException, NamingException, NoSuchAlgorithmException {
		Connection connection = Database.esecuzione();
		PreparedStatement statement = connection.prepareStatement(QueryEmail);
		statement.setString(1, email);
		ResultSet result = statement.executeQuery();
		Utente u=null;
		Encryption e = new Encryption();
		e.setPlainPassword(password);
		String cPass=e.cypherPass();
		
		/*se viene trovato un utente che corrisponde a quella mail 
		 * allora controllerò se la password cifrata nel db corrisponde 
		 * alla nuova cifratura.
		 * Se è corretto allora setto il bean dell' utente, altrimenti lo restituisco nullo
		 * 
		 */
		if (result.next()) {
			if (result.getString("password").equals(cPass)) {
				u = new Utente();
				u.setNome(result.getString("nome"));
				u.setCognome(result.getString("cognome"));
				u.setEmail(result.getString("email"));
				u.setCredito(Integer.parseInt(result.getString("credito")));

				
			} else {
				u = null;
			}
		}
		connection.close();
		return u;
		
	}
		
	/*
	 * incremento del credito dell' utente
	 */
	public Utente incremento(String email,String password,int soldi) throws SQLException, NamingException, NoSuchAlgorithmException {
		
		Connection connection = Database.esecuzione();
		Utente u=null;
		Encryption e = new Encryption();
		e.setPlainPassword(password);
		var cPass=e.cypherPass();
		PreparedStatement statement = connection.prepareStatement(QueryEmail);
		statement.setString(1, email);
		ResultSet result = statement.executeQuery();
		//se esiste l'utente allora controllo se sia corretta la password
		if (result.next()) {
			if (result.getString("password").equals(cPass)) {
				/*Se è pure corretta allora
				 * Aggiorno il database
				 */
				PreparedStatement statement1 = connection.prepareStatement(UpdateCredito);
				statement1.setInt(1,soldi);
				statement1.setString(2, email);
				statement1.executeUpdate();
				//Aggiorno anche il bean
				u = new Utente();
				u.setNome(result.getString("nome"));
				u.setCognome(result.getString("cognome"));
				u.setEmail(result.getString("email"));
				u.setPassword(result.getString("password"));
				u.setCredito(soldi+result.getInt("credito"));
				
				
			}
			
		}
		return u;
		
	}
	
   //cancellazione utente 
	public  void cancella(String e) throws SQLException, NamingException {
		Connection connection = Database.esecuzione();
		PreparedStatement statement = connection.prepareStatement(QueryCancella);
		statement.setString(1, e);
		statement.executeUpdate();
		connection.close();
	}
	/*
	 * Per acquistare un prodotto verrà decrementato il suo credito con il costo del prodotto stesso.
	 */
	public void decrementoCredito(Utente u,int valore) throws NamingException, SQLException {
		Connection connection = Database.esecuzione();
		PreparedStatement statement = connection.prepareStatement(UpdateAcquisto);
		statement.setString(2, u.getEmail());
		statement.setInt(1, valore);
		statement.executeUpdate();
		u.setCredito(u.getCredito()-valore);
		connection.close();
	}
	
	//metodo in cui mi ricavo l'utente dalla mail
	public Utente ricavaUtente(String email) throws NamingException, SQLException {
		Connection connection = Database.esecuzione();
		PreparedStatement statement = connection.prepareStatement(QueryEmail);
		statement.setString(1, email);
		ResultSet result = statement.executeQuery();
		Utente u = null;
		if(result.next()) {
			//se l'utente esiste mi setto il bean 
			u = new Utente();
			u.setNome(result.getString("nome"));
			u.setCognome(result.getString("cognome"));
			u.setEmail(result.getString("email"));
			u.setPassword(result.getString("password"));
			u.setCredito(result.getInt("credito"));
		}
		connection.close();
		return u;
	}
	
	
	
	
	
	
	
}
