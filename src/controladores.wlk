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
                    const naveChiquita = new NaveChiquita(nombre = "naveChiquita1", imagen = imgEnemigas.anyOne())
                    game.addVisual(naveChiquita)
                    game.onTick(250, naveChiquita.nombre(), {naveChiquita.moverHaciaAbajo()})
                }, {
                	const naveChiquita = new NaveChiquita(nombre = "naveChiquita2", imagen = imgEnemigas.anyOne())
                    game.addVisual(naveChiquita)
                    game.onTick(300, naveChiquita.nombre(), {naveChiquita.moverHaciaAbajo()})
                }, {
                	const naveChiquita = new NaveChiquita(nombre = "naveChiquita3", imagen = imgEnemigas.anyOne())
                    game.addVisual(naveChiquita)
                    game.onTick(350, naveChiquita.nombre(), {naveChiquita.moverHaciaAbajo()})
                }, {
                	const naveChiquita = new NaveChiquita(nombre = "naveChiquita4", imagen = imgEnemigas.anyOne())
                    game.addVisual(naveChiquita)
                    game.onTick(400, naveChiquita.nombre(), {naveChiquita.moverHaciaAbajo()})
                }]

                game.onTick(2000, "generacion naves chiquitas", {navesChiquitas.anyOne().apply()})

                //Naves Medianas
               	const navesMedianas = [{
               		const naveMediana = new NaveMediana(nombre = "naveMediana1")
                    game.addVisual(naveMediana)
                    game.onTick(450, naveMediana.nombre(), {naveMediana.moverHaciaAbajo()})
               	}, {
               		const naveMediana = new NaveMediana(nombre = "naveMediana2")
                    game.addVisual(naveMediana)
                    game.onTick(550, naveMediana.nombre(), {naveMediana.moverHaciaAbajo()})
               	}, {
               		const naveMediana = new NaveMediana(nombre = "naveMediana3")
                    game.addVisual(naveMediana)
                    game.onTick(650, naveMediana.nombre(), {naveMediana.moverHaciaAbajo()})
               	}]

                game.onTick(5000, "generacion naves medianas", {navesMedianas.anyOne().apply()})

                //Naves Grandes
                const navesGrandes = [{
               		const naveGrande = new NaveGrande(nombre = "naveGrande1")
                    game.addVisual(naveGrande)
                    game.onTick(700, naveGrande.nombre(), {naveGrande.moverHaciaAbajo()})
               	}, {
               		const naveGrande = new NaveGrande(nombre = "naveGrande2")
                    game.addVisual(naveGrande)
                    game.onTick(800, naveGrande.nombre(), {naveGrande.moverHaciaAbajo()})
               	}]

                game.onTick(8000, "generacion naves grandes", {navesGrandes.anyOne().apply()})
			 
				//PowerUps
				const modificadores = [duplicarBalas, recuperarVida, reducirBalas, inmovilizar]
			
				game.onTick(7000, "spawn power up", {
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
	 	musicaFondo.resumir()
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

object musicaFondo{
	
	const musiquita = game.sound("sonidofondo.mp3")
	
	method iniciar(){
		musiquita.shouldLoop(true)
		musiquita.volume(0.02)
		game.schedule(1, {musiquita.play()})
	}
	
	method pausar(){
		musiquita.pause()
	}
	
	method resumir(){
		musiquita.resume()
	}
}