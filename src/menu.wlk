import wollok.game.*
import juego.*

object menu {
	method principal() {
		// game.boardGround("fondo2.jpg")
		configMenu.teclasMenuPrincipal()
		configMenu.iniciarMusica()
	}
	method configuracion() {
		configMenu.teclasConfiguracion()
	}
}


object configMenu {

	method teclasMenuPrincipal() {
		
		keyboard.s().onPressDo({juego.iniciar()})
		keyboard.c().onPressDo({menu.configuracion()})
	}
	
	method teclasConfiguracion() {
		keyboard.m().onPressDo({menu.principal()})
	}
	
	method iniciarMusica() {
//		sound.play()
//		sound.shouldLoop(true)		
	}

}