package core;

import kha.math.FastMatrix3;
import kha.math.FastVector2;
import kha.math.Vector2;
import kha.math.Vector2i;
import kha.input.KeyCode;
import kha.input.Keyboard;
import kha.input.Mouse;

enum ButtonState {
	Pressed;
	Down;
	Released;
	NotPressed;
}

class MouseState {
	public function new() {}

	public var buttonStates:Array<ButtonState>;
	public var position:Vector2i;
}

class Input {
	private var keyStates:Map<KeyCode, ButtonState> = new Map<KeyCode, ButtonState>();
	var mouseState:MouseState = new MouseState();

	public function new() {
		Keyboard.get().notify(onKeyDown, onKeyUp,);
		Mouse.get().notify(onMouseDown, onMouseUp, onMouseMove);

		mouseState.buttonStates = new Array<ButtonState>();
		mouseState.buttonStates = [NotPressed, NotPressed, NotPressed];
		mouseState.position = new Vector2i(0, 0);
	}

	public function endFrame() {
		for (key in keyStates.keys()) {
			if (keyStates[key] == Pressed) {
				keyStates[key] = Down;
			} else if (keyStates[key] == Released) {
				keyStates[key] = NotPressed;
			}
		}

		for (i in 0...mouseState.buttonStates.length) {
			if (mouseState.buttonStates[i] == Pressed) {
				mouseState.buttonStates[i] = Down;
			} else if (mouseState.buttonStates[i] == Released) {
				mouseState.buttonStates[i] = NotPressed;
			}
		}
	}

	public function isKeyDown(keycode:KeyCode):Bool {
		if (keyStates.exists(keycode) && keyStates[keycode] == Down) {
			return true;
		}

		return false;
	}

	public function isKeyJustPressed(keycode:KeyCode):Bool {
		if (keyStates.exists(keycode) && keyStates[keycode] == Pressed) {
			return true;
		}

		return false;
	}

	public function isKeyReleased(keycode:KeyCode):Bool {
		if (keyStates.exists(keycode) && keyStates[keycode] == Released) {
			return true;
		}

		return false;
	}

	public function getMousePosition():Vector2i {
		var inverseScale:FastMatrix3 = App.gameWindow.scale.inverse();
		var mousePositionScaled = inverseScale.multvec(new FastVector2(mouseState.position.x, mouseState.position.y));

		return new Vector2i(Std.int(mousePositionScaled.x), Std.int(mousePositionScaled.y));
	}

	public function isMouseButtonDown(button:Int):Bool {
		if (mouseState.buttonStates[button] == Down) {
			return true;
		}

		return false;
	}

	public function isMouseButtonJustPressed(button:Int):Bool {
		if (mouseState.buttonStates[button] == Pressed) {
			return true;
		}

		return false;
	}

	public function isMouseButtonReleased(button:Int):Bool {
		if (mouseState.buttonStates[button] == Released) {
			return true;
		}

		return false;
	}

	private function onKeyDown(keycode:KeyCode) {
		if (keyStates.exists(keycode)) {
			keyStates[keycode] = Pressed;
		} else {
			keyStates.set(keycode, Pressed);
		}
	}

	private function onKeyUp(keycode:KeyCode) {
		keyStates[keycode] = Released;
	}

	private function onMouseDown(button:Int, x:Int, y:Int) {
		mouseState.buttonStates[button] = Pressed;
		mouseState.position = new Vector2i(x, y);
	}

	private function onMouseUp(button:Int, x:Int, y:Int) {
		mouseState.buttonStates[button] = Released;
		mouseState.position = new Vector2i(x, y);
	}

	private function onMouseMove(oldX:Int, oldY:Int, newX:Int, newY:Int) {
		// TODO get move direction with newX/Y
		mouseState.position = new Vector2i(oldX, oldY);
	}
}
