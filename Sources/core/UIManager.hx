package core;

import kha.math.Vector2i;
import haxe.Constraints.Function;
import core.UIObject;

typedef UIObjectEventHandler = {
	object:UIObject,
	hasMouseEntered:Bool,
	mouseEnter:() -> Void,
	mouseExit:() -> Void,
	mouseClick:(Vector2i) -> Void
}

class UIManager {
	var uiObjects:Array<UIObjectEventHandler>;

	public function new() {
		uiObjects = new Array<UIObjectEventHandler>();
	}

	public function checkListeners() {
		var mousePos = App.input.getMousePosition();
		for (uiObject in uiObjects) {
			if (mousePos.x >= uiObject.object.position.x
				&& mousePos.x <= uiObject.object.position.x + uiObject.object.size.x
				&& mousePos.y >= uiObject.object.position.y
				&& mousePos.y <= uiObject.object.position.y + uiObject.object.size.y
				&& !uiObject.hasMouseEntered) {
				uiObject.mouseEnter();
				uiObject.hasMouseEntered = true;
			} else if ((mousePos.x < uiObject.object.position.x
				|| mousePos.x > uiObject.object.position.x + uiObject.object.size.x
				|| mousePos.y < uiObject.object.position.y
				|| mousePos.y > uiObject.object.position.y + uiObject.object.size.y)
				&& uiObject.hasMouseEntered) {
				uiObject.mouseExit();
				uiObject.hasMouseEntered = false;
			} else if (App.input.isMouseButtonJustPressed(0) && uiObject.hasMouseEntered) {
				uiObject.mouseClick(mousePos);
			}
		}
	}

	public function addUIObject(object:UIObject, mouseEnter:() -> Void, mouseExit:() -> Void, mouseClick:(Vector2i) -> Void) {
		uiObjects.push({
			object: object,
			hasMouseEntered: false,
			mouseEnter: mouseEnter,
			mouseExit: mouseExit,
			mouseClick: mouseClick
		});
	}
}
