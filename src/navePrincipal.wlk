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
	
	method vida() = vida
	
	method perderVida() {
		vida -= 1
	}
	
	method disparar() {
		game.addVisual(bala)
		game.onTick(200, "disparo", { bala.moverHaciaArriba() })
	}

}

object bala {
	
	var property position = game.at(navePrincipal.position().x(), 1)
	
	method image() = "pepita.png"
	
	method moverHaciaArriba() {
		self.position(position.up(1))
	}
	
}

object vida {
	
	method position() = game.at(8, 14)
	
	method text() {
		if (navePrincipal.vida() == 3) {
			return "3/3"
		} else if (navePrincipal.vida() == 2) {
			return "2/3" 
		} else if (navePrincipal.vida() == 1) {
			return "1/3"
		} else return "0/3"
	}
	
	method textColor() = "FF0000FF" //La vida en rojo
	
}