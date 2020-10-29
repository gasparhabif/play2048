import wollok.game.*
import bloque.*

const ARR = "ARR"

const ABJ = "ABJ"

const IZQ = "IZQ"

const DER = "DER"

object tablero {

	const bloques = []
	var property perdio = false

	method agregarBloque(bloque) {
		if (!perdio) {
			bloque.position(self.espacioLibreAlAzar())
			bloque.setValorAlAzar()
			bloques.add(bloque)
			game.addVisual(bloque)
		} else {
			perdio = true
			bloques.forEach({ b => game.say(b, "PERDIIIII")})
		}
	}

	method moverBloques(sentido) {
		bloques.forEach({ bloque => self.combinarBloques(bloque, sentido)})
	}

	method combinarBloques(bloque, sentido) {
		const posFutura = self.calcularPosicionFutura(bloque, sentido)
		if (bloque.puedeMoverA(posFutura, bloques)) {
			self.moverEnSentido(bloque, sentido)
			game.whenCollideDo(bloque, { otroBloque =>
				if (bloque.valor() == otroBloque.valor()) {
					game.removeVisual(otroBloque)
					bloques.remove(otroBloque)
					bloque.incrementar()
				} else {
					game.say(bloque, "No hay movimientos posibles")
				}
			})
		}
	}

	method calcularPosicionFutura(bloque, sentido) {
		if (sentido == ARR) return game.at(bloque.position().x(), bloque.position().y() + 1)
		if (sentido == ABJ) return game.at(bloque.position().x(), bloque.position().y() - 1)
		if (sentido == DER) return game.at(bloque.position().x() + 1, bloque.position().y())
		if (sentido == IZQ) return game.at(bloque.position().x() - 1, bloque.position().y())
		return game.origin()
	}

	method moverEnSentido(bloque, sentido) {
		if (sentido == ARR) bloque.arriba()
		if (sentido == ABJ) bloque.abajo()
		if (sentido == DER) bloque.derecha()
		if (sentido == IZQ) bloque.izquierda()
	}

	method hayBloqueEnPos(pos) = bloques.any({ bloque => bloque.coincidePosicion(pos) })

	method espacioLibreAlAzar() {
		const posRandom = game.at((0 .. 3).anyOne(), (0 .. 3).anyOne())
		if (self.tableroCompleto()) {
			perdio = true
			return game.origin()
		} else {
			if (self.hayBloqueEnPos(posRandom)) {
				return self.espacioLibreAlAzar()
			} else {
				return posRandom
			}
		}
	}

	method tableroCompleto() {
		4.times({ x => 4.times({ y =>
			if (self.hayBloqueEnPos(game.at(x - 1, y - 1))) return true
		})})
		return false
	}

}

