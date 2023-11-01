import wollok.game.*
import navePrincipal.*
import sonidos.*

class Modificador{

	const positionsX = [0, 1, 2, 3, 4, 5, 6, 7, 8]
	const positionsY = [5, 6, 7, 8, 9, 10, 11, 12]

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
	
	method desaparecer(){
		game.removeVisual(self)
        estaEnPantalla = false
	}
	
}

class PowerUp inherits Modificador{
	
	method chocarConBala(){
        self.desaparecer()
        powerup.play()
    }
}

class PowerDown inherits Modificador{
	
	method chocarConBala(){
        self.desaparecer()
        powerdown.play()
    }
}

//Buff
object duplicarBalas inherits PowerUp(imagen = "duplicadorBalas.png"){
	
	override method chocarConBala(){
        navePrincipal.duplicarBalas()
        super()
    }
}

object recuperarVida inherits PowerUp(imagen = "recuperadorVida.png"){
	
	override method chocarConBala(){
        navePrincipal.recuperarVida()
        super()
    }
	
}

//Debuff
object reducirBalas inherits PowerDown(imagen = "reductorBalas.png"){
	
	override method chocarConBala(){
        navePrincipal.reducirBalas()
        super()
    }
	
}

object inmovilizar inherits PowerDown(imagen = "inmovilizador.png"){
	
	override method chocarConBala(){
        navePrincipal.inmovilizar()
        super()
    }
	
}