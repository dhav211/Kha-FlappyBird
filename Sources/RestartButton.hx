import core.UIImage;
import kha.math.Vector2i;
import kha.Assets;
import kha.math.Vector2;
import core.UIObject;

class RestartButton extends UIImage {
	var clickHandler:() -> Void;

	public function new(clickHandler:() -> Void) {
		super(new Vector2(100, 250), new Vector2(130, 46), 0, Assets.images.restart);

		this.clickHandler = clickHandler;
	}

	override function onMouseClick(mousePosition:Vector2i) {
		clickHandler();
	}
}
