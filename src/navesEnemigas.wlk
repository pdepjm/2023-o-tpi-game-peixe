import wollok.game.*

class NaveInicial {
	
	var property position
	var nombre
	
	var imagen
	
	var vidaEnemigo
	
	method image() = imagen
	
	method moverHaciaAbajo() {
		self.position(position.down(1))
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