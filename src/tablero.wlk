import wollok.game.*
import bloque.*

object tablero {
	const bloques = []
	
	method agregarBloque(bloque) {
		if(!self.tableroCompleto()){
			bloque.position(self.espacioLibreAlAzar())
			bloque.setValorAlAzar()
			
			bloques.add(bloque)
			
			game.addVisual(bloque)
		} else {
			// Perdio
		}
	}
	
	method moverBloques(pos) {
		bloques.forEach({ bloque =>
			
			bloque.mover(pos)	
			game.whenCollideDo(bloque, { otroBloque => 
				if(bloque.valor() == otroBloque.valor()){
					game.removeVisual(otroBloque)
					bloques.remove(otroBloque)
					
					bloque.incrementar()
				} else {
					bloque.moverOpuesto(pos)			
				}
			})
		})
	}
	
	method hayBloqueEnPos(pos) = bloques.any({ bloque => bloque.coincidePosicion(pos)})
	
	method espacioLibreAlAzar() {
		const posRandom = game.at((0..3).anyOne(), (0..3).anyOne())
		
		if(self.hayBloqueEnPos(posRandom)){
			return self.espacioLibreAlAzar()		
		} else {
			return posRandom	
		}
	}
	
	method tableroCompleto() {
//		(0..4).forEach({ x => 
//			(0..4).forEach({ y => 
//				if(self.hayBloqueEnPos(game.at(x, y))) return true
//			})
//		})
		return false
	}
	
}
