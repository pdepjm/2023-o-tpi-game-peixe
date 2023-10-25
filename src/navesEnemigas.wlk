import wollok.game.*
import navePrincipal.*

class NaveEnemiga {
	
	var property position
	var nombre
	
	var imagen
	
	var vidaEnemigo
	
	method image() = imagen
	
	method fueraDelMapa() = self.position().y() <= -1
	
	method moverHaciaAbajo() {
		self.position(position.down(1))
		if (self.fueraDelMapa()) {
			navePrincipal.chocarConEnemigo(self)
		}
	}
	
	method chocarConBala(){
		if (vidaEnemigo == 1) self.desaparecer() else vidaEnemigo-=1
	}

	method desaparecer(){
		game.removeVisual(self)
    	game.removeTickEvent(self.nombre())
	} 
	
	method nombre() = nombre
	
}