import wollok.game.*
import navePrincipal.*

class Modificador{

	const positionsX = [1, 2, 3, 4, 5, 6, 7, 8, 9]
	const positionsY = [7, 8, 9, 10, 11, 12, 13, 14, 15]

    var property position = game.at(positionsX.anyOne(), positionsY.anyOne())
    
    var estaEnPantalla = false
    
    //var imagen

	//Imagen
    method image() = "pepita.png" // imagen

	//Esta el modificador en pantalla
	method estaEnPantalla() = estaEnPantalla

	//Aparecer
	method aparecer(){
		game.addVisual(self)
		estaEnPantalla = true
	}
	
	//Desaparecer
    method desaparecer(){
        game.removeVisual(self)
        estaEnPantalla = false
        
    }
}

//Buff
object duplicarBalas inherits Modificador{
	
	method chocarConBala(){
        navePrincipal.duplicarBalas()
        self.desaparecer()
    }
	
}

object recuperarVida inherits Modificador{
	
	method chocarConBala(){
        navePrincipal.recuperarVida()
        self.desaparecer()
    }
	
}

//Debuff
object reducirBalas inherits Modificador{
	
	method chocarConBala(){
        navePrincipal.reducirBalas()
        self.desaparecer()
    }
	
}

object inmovilizar inherits Modificador{
	
	method chocarConBala(){
        navePrincipal.inmovilizar()
        self.desaparecer()
    }
	
}