import wollok.game.*
import navePrincipal.*
import sonidos.*

class NaveEnemiga {
	
	var property position
	var nombre
	
	var imagen
	
	var vidaEnemigo
	
	//Imagen
	method image() = imagen
	
	//Nombre
	method nombre() = nombre
	
	//Movimiento
	method moverHaciaAbajo() {
		self.position(position.down(1))
		if (self.fueraDelMapa()) {
			navePrincipal.chocarConEnemigo(self)
		}
	}
	
	method fueraDelMapa() = self.position().y() <= -1
	
	//Chocar
	method chocarConBala(){
		if (vidaEnemigo == 1) self.desaparecer() else vidaEnemigo-=1
	}

	method desaparecer(){
		game.removeVisual(self)
    	game.removeTickEvent(self.nombre())
    	enemigoEliminado.play()
	} 
}

class NaveChiquita inherits NaveEnemiga(vidaEnemigo = 1){}

class NaveMediana inherits NaveEnemiga(vidaEnemigo = 2, imagen = "naveMediana.png"){}

class NaveGrande inherits NaveEnemiga(vidaEnemigo = 3, imagen = "naveGrande.png"){}