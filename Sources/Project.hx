package;

import core.UIText;
import haxe.Timer;
import core.App;
import core.Input;
import core.Collisions.Collisons;
import kha.math.Random;
import kha.math.Vector2;
import kha.Assets;
import kha.Framebuffer;

enum GameState {
	Intro;
	Gameplay;
	Dead;
	GameOver;
}

class Project {
	var bird:Bird;
	var background:Background;
	var groundPieces:Array<Ground>;
	var pipes:Array<Pipe>;
	var restartButton:RestartButton;

	var currentGameState:GameState = Intro;
	var pipeSpawnTime:Float = 2;
	var currentPipeSpawnTime:Float = 0;
	var score:Int = 0;
	var scoreText:UIText;
	var isRestarting:Bool = false;

	public function new() {
		bird = new Bird(new Vector2(100, 256), onGameOver);
		background = new Background();
		groundPieces = [new Ground(new Vector2(0, 400))];
		pipes = new Array<Pipe>();
		scoreText = new UIText(new Vector2(130, 20), new Vector2(0, 0), 0, "0", 48, Assets.fonts.flappy_font);
		restartButton = new RestartButton(onRestartButtonClicked);
		restartButton.isVisible = false;
	}

	public function update(delta:Float) {
		bird.update(delta);

		switch (currentGameState) {
			case Intro:
				if (App.input.isMouseButtonJustPressed(0)) {
					currentGameState = Gameplay;
					bird.setCurrentGameState(currentGameState);
				}
			case Gameplay:
				handleGroundPieces(delta);
				handlePipes(delta);
				handleCollisions();
			case Dead:
				currentGameState = Dead;
			case GameOver:
				if (isRestarting) {
					bird = new Bird(new Vector2(100, 256), onGameOver);
					groundPieces = [new Ground(new Vector2(0, 400))];
					pipes = new Array<Pipe>();
					currentGameState = Intro;
					score = 0;
					scoreText.setText(Std.string(score));
					isRestarting = false;
					restartButton.isVisible = false;
				}
		}
	}

	public function render(framebuffer:Framebuffer) {
		final graphics = framebuffer.g2;
		graphics.begin(true, Color.fromBytes(25, 25, 25));
		background.render(graphics);

		for (i in 0...pipes.length) {
			pipes[i].render(graphics);
		}

		for (i in 0...groundPieces.length) {
			groundPieces[i].render(graphics);
		}

		bird.render(graphics);
		restartButton.render(graphics);
		scoreText.render(graphics);
		graphics.end();
	}

	function handleGroundPieces(delta:Float) {
		var i:Int = groundPieces.length - 1;
		while (i >= 0) {
			groundPieces[i].update(delta);

			if (i == 0 && groundPieces[i].position.x <= -48 && !groundPieces[i].hasSpawnedNext) {
				groundPieces.push(new Ground(new Vector2(286, 400)));
				groundPieces[i].hasSpawnedNext = true;
			} else if (i == 0 && groundPieces[i].position.x <= -336) {
				groundPieces.remove(groundPieces[i]);
			}

			i--;
		}
	}

	function handlePipes(delta:Float) {
		if (currentPipeSpawnTime <= pipeSpawnTime) {
			currentPipeSpawnTime += delta;
		} else {
			final MIN_Y_POS = -275;
			final MAX_Y_POS = -100;
			final GAP = 100;
			final PIPE_LENGTH = 320;
			var pipeYPos:Float = Random.getIn(MIN_Y_POS, MAX_Y_POS);
			pipes.push(new Pipe(new Vector2(288, pipeYPos), 180));
			pipes.push(new Pipe(new Vector2(288, pipeYPos + PIPE_LENGTH + GAP), 0));

			currentPipeSpawnTime = 0;
		}

		var i:Int = pipes.length - 1;
		while (i >= 0) {
			pipes[i].update(delta);

			if (pipes[i].position.x <= -52) {
				pipes.remove(pipes[i]);
			}

			if (i % 2 == 0 && pipes[i].position.x + pipes[i].size.x < bird.position.x && !pipes[i].hasScoreCounted) {
				pipes[i].hasScoreCounted = true;
				score++;
				scoreText.setText(Std.string(score));
			}

			i--;
		}
	}

	function handleCollisions() {
		var hasCollided:Bool = false;

		for (pipe in pipes) {
			if (Collisons.circleRectangle(bird.radius, bird.position.x + bird.originPoint.x, bird.position.y + bird.originPoint.y, pipe.position.x,
				pipe.position.y, pipe.size.x, pipe.size.y)) {
				hasCollided = true;
			}
		}

		for (ground in groundPieces) {
			if (Collisons.circleRectangle(bird.radius, bird.position.x + bird.originPoint.x, bird.position.y + bird.originPoint.y, ground.position.x,
				ground.position.y, ground.size.x, ground.size.y)) {
				hasCollided = true;
			}
		}

		if (bird.position.y < -32) {
			hasCollided = true;
		}

		if (hasCollided) {
			bird.kill();
			currentGameState = Dead;
		}
	}

	function onGameOver() {
		currentGameState = GameOver;
		restartButton.isVisible = true;
	}

	function onRestartButtonClicked() {
		if (currentGameState == GameOver) {
			isRestarting = true;
		}
	}
}
