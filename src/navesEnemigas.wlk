import wollok.game.*
import navePrincipal.*
import sonidos.*

class NaveEnemiga {
	
	const positionsX = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    var property position = game.at(positionsX.anyOne(), game.height())
    
    var puntaje
    
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
        if (vidaEnemigo == 1){
            self.desaparecer()
            score.agregar(puntaje)
            enemigoEliminado.play()
        }  else vidaEnemigo-=1
    }

	method desaparecer(){
		game.removeVisual(self)
    	game.removeTickEvent(self.nombre())
	} 

}

class NaveChiquita inherits NaveEnemiga(vidaEnemigo = 1, puntaje = 100){}

class NaveMediana inherits NaveEnemiga(vidaEnemigo = 2, imagen = "naveMediana.png", puntaje = 250){}

class NaveGrande inherits NaveEnemiga(vidaEnemigo = 3, imagen = "naveGrande.png", puntaje = 500){}