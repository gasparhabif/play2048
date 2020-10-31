import wollok.game.*
import bloque.*

const ARR = "ARR"

const ABJ = "ABJ"

const IZQ = "IZQ"

const DER = "DER"

const EN_JUEGO = 0

const PERDIO = 1

const GANO = 2

object tablero {

	const bloques = []
	var property estado = EN_JUEGO

	method agregarBloque(bloque) {
		if (self.estado() == EN_JUEGO) {
			// bloque.position(self.espacioLibreAlAzar(#{}))
			bloque.setValorAlAzar()
			bloques.add(bloque)
			game.addVisual(bloque)
		}
	}

	method moverBloques(sentido) {
		if (self.algunBloquePuedeMoverse(sentido)) {
			bloques.forEach({ bloque => self.combinarBloques(bloque, sentido)})
		} else {
			bloques.forEach({ b => game.say(b, "Perdimos :(")})
			estado = PERDIO
		}
	}

	method algunBloquePuedeMoverse(sentido) = bloques.any({ bloque => bloque.puedeMoverA(self.calcularPosicionFutura(bloque, sentido), bloques) })

	method combinarBloques(bloque, sentido) {
		const posFutura = self.calcularPosicionFutura(bloque, sentido)
		if (bloque.puedeMoverA(posFutura, bloques)) {
			self.moverEnSentido(bloque, sentido)
			game.whenCollideDo(bloque, { otroBloque =>
				if (bloque.valor() == otroBloque.valor()) {
					game.removeVisual(otroBloque)
					bloques.remove(otroBloque)
					bloque.incrementar()
					if (bloque.valor() == 2048) {
						game.say(bloque, "Wii gane")
						estado = GANO
					}
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

	method espacioLibreAlAzar(yaSalieron) {
		const posRandom = game.at((0 .. 3).anyOne(), (0 .. 3).anyOne())
		if (!yaSalieron.contains(posRandom)) {
			yaSalieron.add(posRandom)
			if (self.tableroCompleto()) {
				estado = PERDIO
				bloques.forEach({ b => game.say(b, "Perdimos :(")})
				return game.origin()
			} else {
				if (self.hayBloqueEnPos(posRandom)) {
					return self.espacioLibreAlAzar(yaSalieron)
				} else {
					return posRandom
				}
			}
		} else {
			return self.espacioLibreAlAzar(yaSalieron)
		}
	}

	method tableroCompleto() {
		4.times({ x => 4.times({ y =>
			if (self.hayBloqueEnPos(game.at(x - 1, y - 1))) return true
		})})
		return false
	}

}

