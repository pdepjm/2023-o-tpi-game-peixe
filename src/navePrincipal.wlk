import wollok.game.*
import controladores.*
import sonidos.*

object navePrincipal {

	var property position = game.at(game.center().x(),0)
	var vida = 3
	
	var cantBalas = 0
	var limiteBalas = 4
	var puedoDisparar = true
	var puedeMoverse = true
	const balas = ["bala1", "bala2", "bala3", "bala4", "bala5", "bala6", "bala7", "bala8"]
	
	//Imagen
	method image() = "naveAliada.png"
		
	//Movimiento
	method moverHaciaDerecha() {
		if (puedeMoverse && self.position().x() < 8) self.position(position.right(1))
	}
	
	method moverHaciaIzquierda() {
		if (puedeMoverse && self.position().x() > 0) self.position(position.left(1))
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
		enemigo.desaparecer()
		self.perderVida()
		if (self.vida() == 0) {
			game.clear()
			game.addVisual(gameOver)
			gameover.play()
			musicaFondo.pausar()
			record.probarNuevoRecord(score.score())
			game.schedule(4000, {
				iniciador.juegoEjecutandose(false)
				iniciador.reiniciar()
			})
		}
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
        position = game.at(game.center().x(),0)
        vida = 3
        limiteBalas = 4
        puedeMoverse = true
        puedoDisparar = true
        cantBalas = 0
        balas.clear()
        balas.addAll(["bala1", "bala2", "bala3", "bala4", "bala5", "bala6", "bala7", "bala8"])
        score.resetear()
    }
}

class Bala {

    var nombre
    var property position = game.at(navePrincipal.position().x(), 1)
    
    var enPantalla = false

	//Imagen
    method image() = "bala.png"

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
    	enPantalla = true
    	disparo.play()
        self.position(game.at(navePrincipal.position().x(), 1))

        game.onTick(200, self.nombre(), { self.moverHaciaArriba() })

        game.whenCollideDo(self, {enemigo => self.chocarConEnemigo(enemigo)})
    }

	//Chocar
	method chocarConEnemigo(enemigo) {
        enemigo.chocarConBala()
        self.desaparecer()
	}
	
    method desaparecer(){
    	if (self.enPantalla()){
        	game.removeVisual(self)
        	game.removeTickEvent(self.nombre())
        	navePrincipal.recuperarBala(self.nombre())
        	navePrincipal.modifCantBalas(-1)
        	enPantalla = false
        }
    }

    method chocarConBala() {} //En caso de que una bala choque con otra
    
    method enPantalla() = enPantalla // Me permite realizar un control si la bala tiene que desaparecer 2 veces en caso
									//de que tenga dos enemigos que se crucen, y la bala colisione con ambos
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
	
	method chocarConBala() {} //En caso de que una bala choque con el texto
	
}

object score {

    var score = 0
    
    method score() = score

    method position() = game.at(0, 14)

    method agregar(puntaje){
        score += puntaje
    }

    method resetear(){
        score = 0
    }

    method text() = score.toString()

    method textColor() = "FFFFFFFF"

    method chocarConBala(){}

}

object record {
	
	var record = 0
	
	method probarNuevoRecord (puntaje) {
		record = record.max(puntaje)
	}
	
	method position() = game.at(game.center().x(), 6)
    
    method text() = "Record: " + record.toString()
    
    method textColor() = "FFFFFFFF"
}