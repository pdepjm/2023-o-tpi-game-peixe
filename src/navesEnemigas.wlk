import wollok.game.*

class NaveInicial {
	
	var property position
	
	method image() = "pepita.png"
	
	method moverHaciaAbajo() {
		self.position(position.down(1))
	}
	
	method moverHaciaArriba() {
		self.position(position.up(1))
	}
	
}

const pepitas = [new NaveInicial(position=game.at(3,10)), new NaveInicial(position=game.at(4,10)), new NaveInicial(position=game.at(5,10))]