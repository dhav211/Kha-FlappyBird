package core;

import kha.math.Vector2i;
import kha.graphics2.Graphics;
import kha.Image;
import kha.math.Vector2;

class UIObject extends GameObject {
	public var position:Vector2;
	public var rotation:Float;
	public var size(default, null):Vector2;
	public var originPoint(default, null):Vector2;
	public var isVisible:Bool = true;

	public function new(position:Vector2, size:Vector2, rotation:Float) {
		this.position = position;
		this.size = size;
		this.rotation = rotation;
		this.originPoint = new Vector2(size.x * 0.5, size.y * 0.5);
		App.uiManager.addUIObject(this, onMouseEnter, onMouseExit, onMouseClick);
	}

	public function render(graphics:Graphics) {}

	function onMouseEnter() {}

	function onMouseExit() {}

	function onMouseClick(mousePosition:Vector2i) {}
}
