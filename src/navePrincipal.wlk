import wollok.game.*

object navePrincipal {

	var property position = game.at(4,0)
	
	var vida = 3
	
	method image() = "pepita.png"
	
	method moverHaciaDerecha() {
		self.position(position.right(1))
	}
	
	method moverHaciaIzquierda() {
		self.position(position.left(1))
	}
	
	method perderVida() {
		vida -= 1
	}
	
	method mostrarVida() {
		if (vida == 2){
			return "2"
		} else if (vida == 1){
			return "1"
		} else if (vida == 0){
			return "mori"
		} else {
			return "ya estoy muerto flaco"
		}
	}

}