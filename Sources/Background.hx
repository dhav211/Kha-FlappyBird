import kha.Assets;
import kha.math.Vector2;
import core.SpriteObject;

class Background extends SpriteObject {
	public function new() {
		super(Assets.images.background_day, new Vector2(0, 0), new Vector2(288, 512), 0);
	}
}
