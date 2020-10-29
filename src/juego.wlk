import wollok.game.*
import bloque.*
import tablero.*

object juego {
	method iniciar() {
		tablero.agregarBloque(new Bloque())
		configJuego.teclado()
	}
	
	method correrRonda(pos) {
		tablero.moverBloques(pos)
		tablero.agregarBloque(new Bloque())
	}
}


object configJuego {
	method teclado() {
		keyboard.up().onPressDo({juego.correrRonda(ARR)})
		keyboard.down().onPressDo({juego.correrRonda(ABJ)})
		keyboard.right().onPressDo({juego.correrRonda(DER)})
		keyboard.left().onPressDo({juego.correrRonda(IZQ)})
	}
}
