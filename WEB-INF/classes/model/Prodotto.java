package model;

public class Prodotto {
    
	private int id;
	private String nome;
	private int costo;
	private String descrizione;
	
	public Prodotto() {
		
	}
	
	public void setId(int id) {
		this.id=id;
	}
	
	public void setNome(String nome) {
		this.nome = nome;
	}
	
	public void setCosto(int costo) {
		this.costo = costo;
	}
	
	
	
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	
	public int getId() {
		return this.id;
	}
	
	public String getNome() {
		return this.nome;
	}
	
	public int getCosto() {
		return this.costo;
	}
	
	
	 
	public String getDescrizione() {
		return this.descrizione;
	}
	
	public String toString() {
		return "id: " + this.id + "nome: " + this.nome + " costo: " + this.costo;
	}
	
}
