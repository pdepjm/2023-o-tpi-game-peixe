import wollok.game.*
import navePrincipal.*

class PowerUp{

	const positionsX = [1, 2, 3, 4, 5, 6, 7, 8, 9]
	const positionsY = [7, 8, 9, 10, 11, 12, 13, 14, 15]

    var property position = game.at(positionsX.anyOne(), positionsY.anyOne())

    method image() = "pepita.png"

    method moverHaciaAbajo() {
        self.position(position.down(1))
    }

    method desaparecer(){
        game.removeVisual(self)
    }

}

object duplicarBala inherits PowerUp{
	
	method chocarConBala(){
        navePrincipal.duplicarBalas()
        self.desaparecer()
    }
	
}