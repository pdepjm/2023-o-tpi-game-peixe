import wollok.game.*
import navePrincipal.*

class DobleBala{

    var property position = game.center()

    method image() = "pepita.png"

    method moverHaciaAbajo() {
        self.position(position.down(1))
    }

    method chocarConBala(){
        navePrincipal.duplicarBalas()
        self.desaparecer()
    }

    method desaparecer(){
        game.removeVisual(self)
    }

}