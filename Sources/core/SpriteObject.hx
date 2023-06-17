package core;

import kha.math.FastMatrix3;
import kha.graphics2.Graphics;
import kha.Image;
import kha.graphics4.Graphics2;
import kha.math.Vector2;

class SpriteObject extends GameObject {
	public var position:Vector2;
	public var rotation:Float;
	public var radius:Float;
	public var size(default, null):Vector2;
	public var originPoint(default, null):Vector2;
	public var isVisible:Bool = true;

	var sprite:Image;
	var animationPlayer:AnimationPlayer;

	public function new(position:Vector2, size:Vector2, rotation:Float, sprite:Image) {
		this.position = position;
		this.sprite = sprite;
		this.size = size;
		this.rotation = rotation;
		this.radius = ((size.x + size.y) * 0.5) * 0.5;
		this.originPoint = new Vector2(size.x * 0.5, size.y * 0.5);
		animationPlayer = new AnimationPlayer();
	}

	public override function update(delta:Float) {
		animationPlayer.update(delta);
	}

	public function render(graphics:Graphics) {
		graphics.pushRotation(Utils.degToRad(rotation), size.x * 0.5 + position.x, size.y * 0.5 + position.y);
		if (isVisible)
			graphics.drawSubImage(sprite, position.x, position.y, animationPlayer.getCurrentFrame().x, animationPlayer.getCurrentFrame().y, size.x, size.y);
		graphics.popTransformation();
	}
}
