import kha.Assets;
import kha.math.Vector2;
import core.SpriteObject;

class Ground extends SpriteObject {
	public var hasSpawnedNext:Bool = false;

	public function new(position:Vector2) {
		super(Assets.images.base, position, new Vector2(336, 112), 0);
	}

	public override function update(delta:Float) {
		super.update(delta);
		position.x -= 125 * delta;
	}
}
