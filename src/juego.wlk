import wollok.game.*
import bloque.*
import tablero.*

object juego {

	method iniciar() {
		tablero.agregarBloque(new Bloque())
		configJuego.teclado()
		configJuego.cheats()
	}

	method correrRonda(sentido) {
		if (tablero.estado() == EN_JUEGO) {
			tablero.moverBloques(sentido)
			tablero.agregarBloque(new Bloque())
		} else {
			self.removerTodaVisual()
			if (tablero.estado() == GANO) game.addVisual(visualGano)
			if (tablero.estado() == PERDIO) game.addVisual(visualPerdio)
		}
	}

	method removerTodaVisual() {
		game.allVisuals().forEach({ visual => game.removeVisual(visual)})
	}

}

object visualGano {

	var property position = game.origin()

	method image() = "assets/fondos/win.png"

}

object visualPerdio {

	var property position = game.origin()

	method image() = "assets/fondos/lose.png"

}

object configJuego {

	method teclado() {
		keyboard.up().onPressDo({ juego.correrRonda(ARR)})
		keyboard.down().onPressDo({ juego.correrRonda(ABJ)})
		keyboard.right().onPressDo({ juego.correrRonda(DER)})
		keyboard.left().onPressDo({ juego.correrRonda(IZQ)})
	}

	method cheats() {
		keyboard.l().onPressDo({ tablero.estado(PERDIO)})
		keyboard.g().onPressDo({ tablero.estado(GANO)})
	}

}

