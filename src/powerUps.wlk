import wollok.game.*
import navePrincipal.*
import sonidos.*

class Modificador{

	const positionsX = [1, 2, 3, 4, 5, 6, 7, 8, 9]
	const positionsY = [7, 8, 9, 10, 11, 12, 13, 14, 15]

    var property position = game.at(positionsX.anyOne(), positionsY.anyOne())
    
    var estaEnPantalla = false
    
    var imagen

	//Imagen
    method image() = imagen

	//Esta el modificador en pantalla
	method estaEnPantalla() = estaEnPantalla

	//Aparecer
	method aparecer(){
		game.addVisual(self)
		estaEnPantalla = true
	}
	
}

class PowerUp inherits Modificador{
	
	method desaparecer(){
		game.removeVisual(self)
        estaEnPantalla = false
        powerup.play()
	}
}

class PowerDown inherits Modificador{
	
	method desaparecer(){
		game.removeVisual(self)
        estaEnPantalla = false
        powerdown.play()
	}
}

//Buff
object duplicarBalas inherits PowerUp(imagen = "duplicadorBalas.png"){
	
	method chocarConBala(){
        navePrincipal.duplicarBalas()
        self.desaparecer()
    }
}

object recuperarVida inherits PowerUp(imagen = "recuperadorVida.png"){
	
	method chocarConBala(){
        navePrincipal.recuperarVida()
        self.desaparecer()
    }
	
}

//Debuff
object reducirBalas inherits PowerDown(imagen = "reductorBalas.png"){
	
	method chocarConBala(){
        navePrincipal.reducirBalas()
        self.desaparecer()
    }
	
}

object inmovilizar inherits PowerDown(imagen = "inmovilizador.png"){
	
	method chocarConBala(){
        navePrincipal.inmovilizar()
        self.desaparecer()
    }
	
}