import wollok.game.*

class NaveInicial {
	
	var property position
	var nombre
	
	var imagen
	
	//var vida
	
	method image() = imagen
	
	method moverHaciaAbajo() {
		self.position(position.down(1))
	}
	
	
	method chocarConBala(){
		self.desaparecer()
		//if (vida == 0) self.desaparecer() else vida-=1
	}

	method desaparecer(){
		game.removeVisual(self)
    	game.removeTickEvent(self.nombre())
	} 
	
	method nombre() = nombre
	
}