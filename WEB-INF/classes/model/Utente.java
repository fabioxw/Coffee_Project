package model;

public class Utente {

	private String nome;
	private String cognome;
	private String email;
	private String password;
	private int credito;
	
	

	public Utente() {
		
	}
	
	//metodi set

	public void setNome(String nome) {
		this.nome = nome;
	}
	
	public void setCognome(String cognome) {
		this.cognome = cognome;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public void setCredito(int credito) {
		this.credito=credito;
	}
	//Metodi get
	public String getNome() {
		return this.nome;
	}
	
	public String getCognome() {
		return this.cognome;
	}
	
	public String getEmail() {
		return this.email;
	}
	
	public String getPassword() {
		return this.password;
	}
	
	public int getCredito() {
		return this.credito;
	}
	
	@Override
	public String toString() {
		return "Nome: " + this.nome + "\n" + "Cognome: " + this.cognome;
	}
}
