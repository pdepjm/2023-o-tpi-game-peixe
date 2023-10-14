import wollok.game.*

class NaveInicial {
	
	var property position
	
	method image() = "pepita.png"
	
	method moverHaciaAbajo() {
		self.position(position.down(1))
	}
	
}