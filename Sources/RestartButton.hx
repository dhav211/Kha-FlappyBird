import core.SpriteObject;
import kha.math.Vector2i;
import kha.Assets;
import kha.math.Vector2;

class RestartButton extends SpriteObject {
	var clickHandler:() -> Void;

	public function new(clickHandler:() -> Void) {
		super(Assets.images.restart, new Vector2(100, 250), new Vector2(130, 46), 0);

		this.clickHandler = clickHandler;
	}

	override function onMouseClick(mousePosition:Vector2i) {
		clickHandler();
	}
}
