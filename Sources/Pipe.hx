import kha.Assets;
import kha.math.Vector2;
import core.SpriteObject;

class Pipe extends SpriteObject {
	public var hasScoreCounted:Bool = false;

	public function new(position:Vector2, rotation:Float) {
		super(Assets.images.pipe_green, position, new Vector2(52, 320), rotation);
	}

	public override function update(delta:Float) {
		super.update(delta);

		position.x -= 125 * delta;
	}
}
