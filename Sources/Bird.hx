import Project.GameState;
import core.App;
import kha.math.Vector2i;
import kha.Assets;
import kha.math.Vector2;
import core.SpriteObject;

class Bird extends SpriteObject {
	var gravity:Float = -14.5;
	var deathFallSpeed:Float = 750;
	var jumpForce:Float = 5.5;
	var velocity:Float = 0;
	var isDead:Bool = false;
	var currentGameState:GameState = Intro;
	var onGameOverHandler:() -> Void;

	public function new(position:Vector2, onGameOverHandler:() -> Void) {
		super(position, new Vector2(34, 24), 0, Assets.images.bird);
		this.onGameOverHandler = onGameOverHandler;
		animationPlayer.addAnimation("flap", [new Vector2i(0, 0), new Vector2i(34, 0), new Vector2i(68, 0)], 4);
		animationPlayer.addAnimation("glide", [new Vector2i(34, 0)], 4);
		animationPlayer.play("flap");
	}

	public override function update(delta:Float) {
		super.update(delta);
		switch (currentGameState) {
			case Intro:
				handleAnimations();

			case Gameplay:
				if (!isDead) {
					handleFlight(delta);
				} else if (isDead && position.y < 380) {
					position.y += deathFallSpeed * delta;
				} else if (isDead && position.y >= 380) {
					onGameOverHandler();
				}

				handleAnimations();

			default:
				handleAnimations();
		}
	}

	public override function kill() {
		super.kill();
		isDead = true;
	}

	public function setCurrentGameState(state:GameState) {
		currentGameState = state;
	}

	private function handleFlight(delta:Float) {
		velocity += gravity * delta;

		if (App.input.isMouseButtonJustPressed(0)) {
			velocity = jumpForce;
		}

		position.y -= velocity;
	}

	private function handleAnimations() {
		if (velocity >= 0 && !isDead) {
			animationPlayer.play("flap");
		} else if (velocity < 0 && !isDead) {
			animationPlayer.play("glide");
		} else if (isDead) {
			animationPlayer.play("glide");
		}
	}
}
