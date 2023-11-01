import wollok.game.*
import navePrincipal.*
import navesEnemigas.*
import powerUps.*

object iniciador{
	
	var property juegoEjecutandose = false
	
	method iniciar() {
	 	game.addVisual(cartelInicio)
	 	
	 	keyboard.enter().onPressDo({
			if (not self.juegoEjecutandose()) { 
	 			self.juegoEjecutandose(true)
	 			game.removeVisual(cartelInicio)
	 			
				game.addVisual(navePrincipal)
				game.addVisual(vida)
	
				const imgEnemigas = ["naveEnemiga1.png", "naveEnemiga2.png", "naveEnemiga3.png", "naveEnemiga4.png"]
		
				keyboard.right().onPressDo({navePrincipal.moverHaciaDerecha()})
				keyboard.left().onPressDo({navePrincipal.moverHaciaIzquierda()})
				keyboard.space().onPressDo({navePrincipal.disparar()})

				//Naves Chiquitas
				const navesChiquitas = [{
					const naveChiquita1 = new NaveChiquita(position=game.at(1,game.height()), nombre = "naveChiquita1", imagen = imgEnemigas.anyOne())
					game.addVisual(naveChiquita1)
					game.onTick(501, naveChiquita1.nombre(), {naveChiquita1.moverHaciaAbajo()})
				}, {
					const naveChiquita2 = new NaveChiquita(position=game.at(2,game.height()), nombre = "naveChiquita2", imagen = imgEnemigas.anyOne())
					game.addVisual(naveChiquita2)
					game.onTick(401, naveChiquita2.nombre(), {naveChiquita2.moverHaciaAbajo()})
				}, {
					const naveChiquita3 = new NaveChiquita(position=game.at(4,game.height()), nombre = "naveChiquita3", imagen = imgEnemigas.anyOne())
					game.addVisual(naveChiquita3)
					game.onTick(601, naveChiquita3.nombre(), {naveChiquita3.moverHaciaAbajo()})
				}, {
					const naveChiquita4 = new NaveChiquita(position=game.at(6,game.height()), nombre = "naveChiquita4", imagen = imgEnemigas.anyOne())
					game.addVisual(naveChiquita4)
					game.onTick(201, naveChiquita4.nombre(), {naveChiquita4.moverHaciaAbajo()})
				}, {
					const naveChiquita5 = new NaveChiquita(position=game.at(8,game.height()), nombre = "naveChiquita5", imagen = imgEnemigas.anyOne())
					game.addVisual(naveChiquita5)
					game.onTick(301, naveChiquita5.nombre(), {naveChiquita5.moverHaciaAbajo()})
				}]
			
				game.onTick(2000, "generacion naves chiquitas", {
					navesChiquitas.anyOne().apply()
				})
					
				//Naves Medianas
				const navesMedianas = [{
					const naveMediana1 = new NaveMediana(position=game.at(2,game.height()), nombre = "naveMediana1")
					game.addVisual(naveMediana1)
					game.onTick(501, naveMediana1.nombre(), {naveMediana1.moverHaciaAbajo()})
				}, {
					const naveMediana2 = new NaveMediana(position=game.at(6,game.height()), nombre = "naveMediana2")
					game.addVisual(naveMediana2)
					game.onTick(401, naveMediana2.nombre(), {naveMediana2.moverHaciaAbajo()})
				}]
					
				game.onTick(5500, "generacion naves medianas", {
					navesMedianas.anyOne().apply()
				})
				
				//Naves Grandes
				const navesGrandes = [{
					const naveGrande1 = new NaveGrande(position=game.at(1,game.height()), nombre = "naveGrande1")
					game.addVisual(naveGrande1)
					game.onTick(501, naveGrande1.nombre(), {naveGrande1.moverHaciaAbajo()})
				}, {
					const naveGrande2 = new NaveGrande(position=game.at(5,game.height()), nombre = "naveGrande2")
					game.addVisual(naveGrande2)
					game.onTick(501, naveGrande2.nombre(), {naveGrande2.moverHaciaAbajo()})
				}]
				
				game.onTick(10000, "generacion naves grandes", {
					navesGrandes.anyOne().apply()
				})
			 
				//PowerUps
				const modificadores = [duplicarBalas, recuperarVida, reducirBalas, inmovilizar]
			
				game.onTick(8000, "spawn power up", {
					const modificador = modificadores.anyOne()
					modificador.aparecer()
					game.schedule(5000, {
						if (modificador.estaEnPantalla()) modificador.desaparecer()
					})
				})
					
				game.whenCollideDo(navePrincipal, {enemigo => navePrincipal.chocarConEnemigo(enemigo)})
				
			}
	 	})
	 }

	method reiniciar(){
	 			navePrincipal.resetear()
	 			game.removeVisual(gameOver)
	 			self.iniciar()
	}
	
}

object cartelInicio{
	
	method position() = game.center()
	
	method text() = "Presiona ENTER para iniciar"
	
	method textColor() = "FFFFFFFF"
	
}

object gameOver{
	method position() = game.origin()
	
	method image() = "gameOver.jpg"
}