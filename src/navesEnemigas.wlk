import wollok.game.*

object naveInicial {
	
	var property position = game.at(4,16)
	
	method image() = "pepita.png"
	
	method moverHaciaAbajo() {
		self.position(position.down(1))
	}
	
	method moverHaciaArriba() {
		self.position(position.up(1))
	}
	
}