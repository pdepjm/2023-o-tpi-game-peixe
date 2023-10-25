import wollok.game.*

object navePrincipal {

	var property position = game.at(4,0)
	var vida = 3
	
	var cantBalas = 0
	var limiteBalas = 2
	var puedoDisparar = true
	const balas = ["bala1", "bala2", "bala3", "bala4"]
	
	var property juegoEjecutandose = false
	
	var puedeMoverse = true
	
	//Imagen
	method image() = "nave_aliada.png"
		
	//Movimiento
	method moverHaciaDerecha() {
		if (puedeMoverse) self.position(position.right(1))
	}
	
	method moverHaciaIzquierda() {
		if (puedeMoverse) self.position(position.left(1))
	}
	
	//Vida
	method vida() = vida
	
	method perderVida() {
		vida -= 1
	}
	
	//Disparar
	method disparar(){
		if(self.cantBalas() < limiteBalas && puedoDisparar){
			const bala = new Bala(nombre = balas.anyOne())
			balas.remove(bala.nombre())
			game.addVisual(bala)
			bala.dispararse()
			self.modifCantBalas(1)
			puedoDisparar = false
			game.schedule(201, {puedoDisparar = true})
		}
	}
	
	method cantBalas() = cantBalas
	
	method modifCantBalas(cantidad){
		cantBalas += cantidad
	}
	
	method recuperarBala(bala) {
		balas.add(bala)
	}
	
	//Chocar con enemigo
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
	
	// PowerUps
	method duplicarBalas(){
		limiteBalas *= 2
		game.schedule(5000, {
			limiteBalas /= 2
		})
	}
	
	method recuperarVida() {
		vida = 3.min(vida+1)
	}
	
	//PowerDowns
	method reducirBalas(){
		limiteBalas /= 2
		game.schedule(5000, {
			limiteBalas *= 2
		})
	}
	
	method inmovilizar(){
		puedeMoverse=false
		game.schedule(2500, {
			puedeMoverse = true
		})
	}
	
	//Resetear nave
	method resetear(){
		vida = 3
		position = game.at(4,0)
	}
}

class Bala {

    var nombre
    var property position = game.at(navePrincipal.position().x(), 1)

	//Imagen
    method image() = "bala_nave_aliada.png"

	//Nombre
    method nombre() = nombre

	//Movimiento
    method moverHaciaArriba() {
        self.position(position.up(1))
        if (self.fueraDelMapa()) {
            self.desaparecer()
            self.position(game.at(navePrincipal.position().x(), 1))
        }
    }
    
    method fueraDelMapa() = self.position().y() >= game.height()

	//Dispararse
    method dispararse(){
        self.position(game.at(navePrincipal.position().x(), 1))

        game.onTick(200, self.nombre(), { self.moverHaciaArriba() })

        game.whenCollideDo(self, {enemigo => 
            enemigo.chocarConBala()
            self.desaparecer()
        })
    }

	//Chocar
    method desaparecer(){
        game.removeVisual(self)
        game.removeTickEvent(self.nombre())
        navePrincipal.recuperarBala(self.nombre())
        navePrincipal.modifCantBalas(-1)
    }

    method chocarConBala () {} //En caso de que una bala choque con otra

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
	
	method chocarConBala () {} //En caso de que una bala choque con el texto
	
}

object inicio {
	
	method position() = game.center()
	
	method text() = "Presiona ENTER para iniciar"
	
	method textColor() = "FFFFFFFF"
}