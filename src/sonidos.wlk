import wollok.game.*
import navePrincipal.*
import controladores.*
import powerUps.*
import navesEnemigas.*

class Sonido{
	
	var sonido
	method play(){
		game.sound(sonido).play()
	}
}

object disparo inherits Sonido(sonido = "disparo.mp3"){}

object powerup inherits Sonido(sonido = "powerup.mp3"){}

object powerdown inherits Sonido(sonido = "powerdown.wav"){}

object gameover inherits Sonido(sonido = "gameover.mp3"){}

object enemigoEliminado inherits Sonido(sonido = "explosion_naveEnemiga.mp3"){}
	