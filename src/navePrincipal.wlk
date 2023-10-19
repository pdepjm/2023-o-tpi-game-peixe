import wollok.game.*

object navePrincipal {

	var property position = game.at(4,0)
	var vida = 3
	
	//method juegoEjecutandose () = false
	
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
	
	method resetear(){
		vida = 3
		position = game.at(4,0)
	}
	
	method disparar(){
		game.addVisual(bala)
		bala.disparse()
	}
	
	method chocarConEnemigo(enemigo){
		if (self.vida() == 1) {
			game.schedule(4000, {
				game.stop()
				//game.clear()
				//navePrincipal.juegoEjecutandose() = false
				//game.addVisual(pantallaInicio)
			})
			//game.addVisual(moriste.png) --Imagen de game over.
		}
		enemigo.desaparecer()
		self.perderVida()
	}
}

object bala {
	
	var property position = game.at(navePrincipal.position().x(), 1)
	
	method image() = "pepita.png"
	
	method mePase() = self.position().y() >= game.height()
	
	method moverHaciaArriba() {
		self.position(position.up(1))
		
		if (self.mePase()) {
			self.desaparecer()
        	self.position(game.at(navePrincipal.position().x(), 1))
		}
	}
	
	method disparse(){
		self.position(game.at(navePrincipal.position().x(), 1))
		
		game.onTick(200, "disparo", { self.moverHaciaArriba() })
		
		game.whenCollideDo(self, {enemigo => 
			enemigo.chocarConBala()
			self.desaparecer()
		})
	}
	
	method desaparecer(){
		game.removeVisual(self)
    	game.removeTickEvent("disparo")
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