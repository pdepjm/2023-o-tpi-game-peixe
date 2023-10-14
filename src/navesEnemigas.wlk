import wollok.game.*

class NaveInicial {
	
	var property position
	var nombre
	
	method image() = "pepita.png"
	
	method moverHaciaAbajo() {
		self.position(position.down(1))
	}
	
	method nombre() = nombre
	
}