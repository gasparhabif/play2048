import wollok.game.*
import bloque.*
import tablero.*

object juego {

	method iniciar() {
		tablero.agregarBloque(new Bloque())
		configJuego.teclado()
	}

	method correrRonda(sentido) {
		if (tablero.estado() == EN_JUEGO) {
			tablero.moverBloques(sentido)
			tablero.agregarBloque(new Bloque())
		}
		if (tablero.estado() == GANO) {
			self.removerTodaVisual()
		}
		if (tablero.estado() == PERDIO) {
			self.removerTodaVisual()
		}
	}

	method removerTodaVisual() {
		game.allVisuals().forEach({ visual => game.removeVisual(visual)})
	}

}

object configJuego {

	method teclado() {
		keyboard.up().onPressDo({ juego.correrRonda(ARR)})
		keyboard.down().onPressDo({ juego.correrRonda(ABJ)})
		keyboard.right().onPressDo({ juego.correrRonda(DER)})
		keyboard.left().onPressDo({ juego.correrRonda(IZQ)})
	}

}

