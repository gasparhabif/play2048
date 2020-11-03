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

	const property bloques = []
	var property estado = EN_JUEGO
	const property espaciosDisponibles = #{}

	method popularEspaciosDisponibles() {
		4.times({ x => 4.times({ y => espaciosDisponibles.add(game.at(x - 1, y - 1))})})
	}

	method ocuparEspacio(espacio) {
		espaciosDisponibles.remove(espacio)
	}

	method liberarEspacio(bloque) {
		espaciosDisponibles.add(bloque.position())
	}

	method agregarBloque(bloque) {
		if (self.estado() == EN_JUEGO) {
			bloque.position(self.espacioLibreAlAzar())
			bloque.setValorAlAzar()
			bloques.add(bloque)
			game.addVisual(bloque)
		}
	}

	method moverBloques(sentido) {
		if (espaciosDisponibles.size() > 0) {
			bloques.forEach({ bloque => self.combinarBloques(bloque, sentido)})
			self.refrescarEspacios()
		} else {
			estado = PERDIO
		}
	}

	method combinarBloques(bloque, sentido) {
		const posFutura = self.calcularPosicionFutura(bloque, sentido)
		if (bloque.puedeMoverA(posFutura, bloques)) {
			self.moverEnSentido(bloque, sentido)
			self.comprobarColisiones(bloque)
		}
	}

	method comprobarColisiones(bloque) {
		game.whenCollideDo(bloque, { otroBloque =>
			if (bloque.valor() == otroBloque.valor()) {
				self.eliminarBloque(otroBloque)
				bloque.incrementar()
				if (bloque.valor() == 2048) {
					estado = GANO
				}
			}
		})
	}

	method eliminarBloque(bloque) {
		game.removeVisual(bloque)
		self.liberarEspacio(bloque)
		bloques.remove(bloque)
	}

	method calcularPosicionFutura(bloque, sentido) {
		if (sentido == ARR) return game.at(bloque.position().x(), bloque.position().y() + 1)
		if (sentido == ABJ) return game.at(bloque.position().x(), bloque.position().y() - 1)
		if (sentido == DER) return game.at(bloque.position().x() + 1, bloque.position().y())
		if (sentido == IZQ) return game.at(bloque.position().x() - 1, bloque.position().y())
		return game.origin()
	}

	method moverEnSentido(bloque, sentido) {
		self.liberarEspacio(bloque)
		if (sentido == ARR) bloque.arriba()
		if (sentido == ABJ) bloque.abajo()
		if (sentido == DER) bloque.derecha()
		if (sentido == IZQ) bloque.izquierda()
		self.ocuparEspacio(bloque.position())
	}

	method refrescarEspacios() {
		espaciosDisponibles.removeAll(espaciosDisponibles)
		self.popularEspaciosDisponibles()
		bloques.forEach({ bloque => espaciosDisponibles.remove(bloque.position())})
	}

	method espacioLibreAlAzar() {
		if (espaciosDisponibles.size() > 0) {
			const espacio = espaciosDisponibles.anyOne()
			self.ocuparEspacio(espacio)
			return espacio
		} else {
			estado = PERDIO
			return game.origin()
		}
	}

}

