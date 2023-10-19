import wollok.game.*

class NaveInicial {
	
	var property position
	var nombre
	
	var imagen
	
	method image() = imagen
	
	method moverHaciaAbajo() {
		self.position(position.down(1))
	}
	
	
	method chocarConBala(){
		
	}
	
	method nombre() = nombre
	
}