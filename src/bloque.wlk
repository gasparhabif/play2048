import wollok.game.*

class Bloque {

	var property position = game.origin()
	var property valor = 2

	method image() = "assets/bloques/" + valor.toString() + ".png"

	method incrementar() {
		valor *= 2
	}

	method coincidePosicion(pos) = self.position().x() == pos.x() && self.position().y() == pos.y()

	method puedeMoverA(pos, bloques) {
		return bloques.all({ bloque => (bloque.position() != pos || self.valor() == bloque.valor()) })
	}

	method arriba() {
		if (self.puedeMoverseArriba()) {
			position = self.position().up(1)
		}
	}

	method abajo() {
		if (self.puedeMoverseAbajo()) {
			position = self.position().down(1)
		}
	}

	method izquierda() {
		if (self.puedeMoverseIzquierda()) {
			position = self.position().left(1)
		}
	}

	method derecha() {
		if (self.puedeMoverseDerecha()) {
			position = self.position().right(1)
		}
	}

	method puedeMoverseArriba() = game.height() > self.position().y() + 1

	method puedeMoverseAbajo() = 0 <= self.position().y() - 1

	method puedeMoverseDerecha() = game.width() > self.position().x() + 1

	method puedeMoverseIzquierda() = 0 <= self.position().x() - 1

	// Un azar en el que el 80% de las chances son de que 
	// el valor sea 2, y el 20% de que sea 4
	method setValorAlAzar() {
		const random = (0 .. 10).anyOne()
		if (random <= 8) self.valor(2) else self.valor(4)
	}

}

