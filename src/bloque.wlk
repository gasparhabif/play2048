import wollok.game.*

const ARR = "ARR"
const ABJ = "ABJ"
const IZQ = "IZQ"
const DER = "DER"

class Bloque {
	var property position = game.origin()
	
	var property valor = 2
	
	method image() = "assets/bloques/" + valor.toString() + ".png"
	
	method incrementar() {
		valor *= 2 
	}
	
	method coincidePosicion(pos) = self.position().x() == pos.x() && self.position().y() == pos.y()
	
	
	// Un azar en el que el 80% de las chances son de que 
	// el valor sea 2, y el 20% de que sea 4
	method setValorAlAzar() {
		const random = (0..10).anyOne()
		if(random <= 8) self.valor(2) else self.valor(4)
	}
	
	// Se considera que jamas habra otros movimientos que no sean arriba, abajo
	// izquierda y derecha, por eso puede dejarse fijo. 
	method mover(pos) {
		if(pos == ARR) self.arriba()
		if(pos == ABJ) self.abajo()
		if(pos == DER) self.derecha()
		if(pos == IZQ) self.izquierda()
	}
	method moverOpuesto(pos) {
		if(pos == ARR) self.abajo()
		if(pos == ABJ) self.arriba()
		if(pos == DER) self.izquierda()
		if(pos == IZQ) self.derecha()
	}
	
	method arriba() {
		if(self.puedeMoverseArriba()){
			position = self.position().up(1)
		}
	}
	
	method abajo() {
		if(self.puedeMoverseAbajo()){
			position = self.position().down(1)
		}
	}
	
	method izquierda() {
		if(self.puedeMoverseIzquierda()){
			position = self.position().left(1)
		}
	}
	
	method derecha() {
		if(self.puedeMoverseDerecha()){
			position = self.position().right(1)
		}
	}
	
	method puedeMoverseArriba() = game.height() > self.position().y() + 1
	
	method puedeMoverseAbajo() = 0 <= self.position().y() - 1
	
	method puedeMoverseDerecha() = game.width() > self.position().x() + 1
	
	method puedeMoverseIzquierda() = 0 <= self.position().x() - 1
}