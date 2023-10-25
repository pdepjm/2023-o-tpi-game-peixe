import wollok.game.*

object navePrincipal {

	var property position = game.at(4,0)
	var vida = 3
	
	var cantBalas = 0
	var limiteBalas = 1
	const balas = ["bala1", "bala2"]
	
	var property juegoEjecutandose = false
	
	method cantBalas() = cantBalas
	
	method modifCantBalas(cantidad){
		cantBalas += cantidad
	}
	
	method recuperarBala(bala) {
		balas.add(bala)
	}
	
	method image() = "nave_aliada.png"
	
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
		if(self.cantBalas() < limiteBalas){
			const bala = new Bala(nombre = balas.anyOne())
			balas.remove(bala.nombre())
			game.addVisual(bala)
			bala.dispararse()
			self.modifCantBalas(1)
		}
	}
	
	method chocarConEnemigo(enemigo){
		if (self.vida() == 1) {
			game.schedule(4000, {
				//game.stop()
				game.clear()
				self.juegoEjecutandose(false)
				game.addVisual(inicio)
			})
			//game.addVisual(moriste.png) --Imagen de game over.
		}
		enemigo.desaparecer()
		self.perderVida()
	}
	
	method duplicarBalas(){
		limiteBalas *= 2
		game.schedule(5000, {
			limiteBalas /= 2
		})
	}
}

class Bala {

    var nombre
    var property position = game.at(navePrincipal.position().x(), 1)

    method image() = "bala_nave_aliada.png"

    method nombre() = nombre

    method fueraDelMapa() = self.position().y() >= game.height()

    method moverHaciaArriba() {
        self.position(position.up(1))
        if (self.fueraDelMapa()) {
            self.desaparecer()
            self.position(game.at(navePrincipal.position().x(), 1))
        }
    }

    method dispararse(){
        self.position(game.at(navePrincipal.position().x(), 1))

        game.onTick(200, self.nombre(), { self.moverHaciaArriba() })

        game.whenCollideDo(self, {enemigo => 
            enemigo.chocarConBala()
            if (enemigo.image() != "bala_nave_aliada.png") self.desaparecer()
        })
    }

    method desaparecer(){
        game.removeVisual(self)
        game.removeTickEvent(self.nombre())
        navePrincipal.recuperarBala(self.nombre())
        navePrincipal.modifCantBalas(-1)
    }

    method chocarConBala () {}

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

object inicio {
	
	method position() = game.center()
	
	method text() = "Presiona ENTER para iniciar"
	
	method textColor() = "FFFFFFFF"
}