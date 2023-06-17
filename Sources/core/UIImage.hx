package core;

import kha.math.Vector2;
import kha.Image;
import kha.graphics2.Graphics;

class UIImage extends UIObject {
	var sprite:Image;

	public function new(position:Vector2, size:Vector2, rotation:Float, sprite:Image) {
		super(position, size, rotation);

		this.sprite = sprite;
	}

	public override function render(graphics:Graphics) {
		super.render(graphics);

		graphics.pushRotation(Utils.degToRad(rotation), size.x * 0.5 + position.x, size.y * 0.5 + position.y);
		if (isVisible)
			graphics.drawImage(sprite, position.x, position.y);
		graphics.popTransformation();
	}
}
