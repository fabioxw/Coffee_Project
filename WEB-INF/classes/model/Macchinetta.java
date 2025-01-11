package model;
import java.util.HashMap;

public class Macchinetta {
    
	private int idmacchinetta;
	private int stato;
	private String modello;
	private HashMap<Integer,Prodotto> listaProdotti;
	
	public Macchinetta() {
		
	}
	
	public int getIdmacchinetta() {
		return this.idmacchinetta;
	}
	public int getStato() {
		return this.stato;
	}
	
	public String getModello() {
		return this.modello;
	}
	
	public HashMap<Integer,Prodotto> getListaProdotti() {
		return this.listaProdotti;
	}
	
	
	public void setStato(int stato) {
		this.stato = stato;
	}
	
	public void setModello(String modello) {
		this.modello = modello;
	}
	public void setIDmacchinetta(int idmacchinetta) {
		this.idmacchinetta = idmacchinetta;
	}
	
	public void setListaProdotti(HashMap<Integer,Prodotto> prodotto) {
		this.listaProdotti = prodotto;
	}
	
	public String toString() {
		return "id : " + this.idmacchinetta + "modello: " + this.modello + "stato: " + this.stato;
	}
	
}
