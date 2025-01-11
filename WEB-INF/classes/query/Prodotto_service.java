package query;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;
import model.Prodotto;

public class Prodotto_service {
	private static String QueryProdotto = "SELECT * FROM prodotto WHERE idprodotto = ?";
	private static String QueryQuantita="SELECT * FROM acquista INNER JOIN prodotto ON acquista.refprodotto=prodotto.idprodotto WHERE acquista.quantita>0";
	private static String QueryAcquisto="Select prodotto.* from  ((macchinetta INNER JOIN  possiede ON macchinetta.idmacchinetta=possiede.cod_macchinetta) INNER JOIN prodotto ON possiede.cod_prodotto= prodotto.idprodotto) WHERE macchinetta.idmacchinetta=?";
	private static String QueryTrovaProdottoMacchinetta= "SELECT prodotto.* FROM prodotto, possiede WHERE possiede.cod_prodotto=? AND possiede.cod_prodotto=prodotto.idprodotto AND possiede.cod_macchinetta=? AND possiede.quantita > 0";
	private static String QueryDecrementoQuantita= "UPDATE possiede SET quantita=quantita-1 WHERE possiede.cod_prodotto=? AND possiede.cod_macchinetta=? ";
	
	
	/*
	 * Diminuisco la quantità del prodotto a disposizione nella macchinetta
	 */
	public void decrementoQuantita(int idm, int idp) throws NamingException, SQLException {
		Connection connection = Database.esecuzione();
		PreparedStatement statement = connection.prepareStatement(QueryDecrementoQuantita);
		statement.setInt(1, idp);
		statement.setInt(2, idm);
		statement.executeUpdate();
		connection.close();
	}
	/*
	 * Seleziono i prodotti posseduti da una macchinetta con quantità maggiore di 0.
	 */
	public  Prodotto trovaProdotto(int idm,int idp) throws NamingException, SQLException
	{
		Connection connection = Database.esecuzione();
		PreparedStatement statement = connection.prepareStatement(QueryTrovaProdottoMacchinetta);
		statement.setInt(1, idp);
		statement.setInt(2, idm);
		Prodotto p=null;
		ResultSet result = statement.executeQuery();	
		if(result.next()) {
			p = new Prodotto();
			p.setId(result.getInt("idprodotto"));
			p.setNome(result.getString("nome"));
			p.setCosto(result.getInt("costo"));
			p.setDescrizione(result.getString("tipo"));
		}
		connection.close();
		return p;
	}
	
	/*public void decrementa_Quantita(int id) throws NamingException, SQLException {
		Connection connection = Database.esecuzione();
		PreparedStatement statement = connection.prepareStatement(QueryAcquisto);
		statement.setInt(1, id);
		Prodotto p=null;
	}
	*/
	
	
}
