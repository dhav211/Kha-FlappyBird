package core;

import core.GameObject;
import kha.math.Vector2i;

typedef GameObjectEventHandler = {
	object:GameObject,
	hasMouseEntered:Bool,
	mouseEnter:() -> Void,
	mouseExit:() -> Void,
	mouseClick:(Vector2i) -> Void
}

class GameObjectManager {
	var gameObjectEventHandlers:Array<GameObjectEventHandler>;

	public function new() {
		gameObjectEventHandlers = new Array<GameObjectEventHandler>();
	}

	public function checkListeners() {
		var mousePos = App.input.getMouseScreenPosition();
		for (gameObject in gameObjectEventHandlers) {
			if (mousePos.x >= gameObject.object.position.x
				&& mousePos.x <= gameObject.object.position.x + gameObject.object.size.x
				&& mousePos.y >= gameObject.object.position.y
				&& mousePos.y <= gameObject.object.position.y + gameObject.object.size.y
				&& !gameObject.hasMouseEntered) {
				gameObject.mouseEnter();
				gameObject.hasMouseEntered = true;
			} else if ((mousePos.x < gameObject.object.position.x
				|| mousePos.x > gameObject.object.position.x + gameObject.object.size.x
				|| mousePos.y < gameObject.object.position.y
				|| mousePos.y > gameObject.object.position.y + gameObject.object.size.y)
				&& gameObject.hasMouseEntered) {
				gameObject.mouseExit();
				gameObject.hasMouseEntered = false;
			} else if (App.input.isMouseButtonJustPressed(0) && gameObject.hasMouseEntered) {
				gameObject.mouseClick(mousePos);
			}
		}
	}

	public function addGameObject(object:GameObject, mouseEnter:() -> Void, mouseExit:() -> Void, mouseClick:(Vector2i) -> Void) {
		gameObjectEventHandlers.push({
			object: object,
			hasMouseEntered: false,
			mouseEnter: mouseEnter,
			mouseExit: mouseExit,
			mouseClick: mouseClick
		});
	}
}
