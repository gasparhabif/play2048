import wollok.game.*
import juego.*

object menu {

	method principal() {
		game.boardGround("assets/fondos/tablero.png")
		configMenu.teclasMenuPrincipal()
		configMenu.iniciarFondoDinamico()
	}

	method configuracion() {
		configMenu.teclasConfiguracion()
	}

}

object configMenu {

	method teclasMenuPrincipal() {
		keyboard.s().onPressDo({ juego.iniciar()
			self.pararFondoDinamico()
		})
		keyboard.c().onPressDo({ menu.configuracion()})
	}

	method teclasConfiguracion() {
		keyboard.m().onPressDo({ menu.principal()})
	}

	method iniciarFondoDinamico() {
		game.addVisual(fondoDinamico)
		game.onTick(750, "fondoItermitente", { fondoDinamico.cambiar()})
	}

	method pararFondoDinamico() {
		game.removeVisual(fondoDinamico)
		game.removeTickEvent("fondoItermitente")
	}

}

object fondoDinamico {

	var property position = game.origin()
	var property flash = false
	var property imagen = "assets/fondos/background.png"

	method image() = imagen

	method cambiar() {
		if (flash) {
			self.imagen("assets/fondos/background.png")
		} else {
			self.imagen("assets/fondos/background-flash.png")
		}
		self.flash(!flash)
	}

}

