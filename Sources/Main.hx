package;

import core.GameObjectManager;
import kha.Framebuffer;
import kha.Image;
import kha.Scaler;
import kha.Scaler.TargetRectangle;
import core.GameWindow;
import kha.Window;
import kha.math.Random;
import kha.Assets;
import kha.Scheduler;
import kha.System;
import core.App;
import core.Input;

class Main {
	static var backbuffer:Image;
	static var framebuffer:Framebuffer;

	public static function main() {
		System.start({title: "Flappy Bird", width: 576, height: 1024}, function(_) {
			Assets.loadEverything(function() {
				// Set the seed for random so it can be called from anywhere
				Random.init(cast(Date.now().getTime()));
				App.input = new Input();
				App.gameObjectManager = new GameObjectManager();
				App.gameWindow = new GameWindow(0, 0, 576, 1024, 288, 512, 2, 0);

				var window:Window = Window.get(0);
				var project = new Project();
				var delta:Float = 0;
				var currentTime:Float = 0;

				backbuffer = Image.createRenderTarget(288, 512);
				window.notifyOnResize(onWindowResize);

				Scheduler.addTimeTask(function() {
					delta = Scheduler.time() - currentTime;
					project.update(delta);
					App.gameObjectManager.checkMouseInputListeners();
					App.input.endFrame();
					currentTime = Scheduler.time();
				}, 0, 1 / 60);
				System.notifyOnFrames(function(frames) {
					framebuffer = frames[0];

					final graphics = backbuffer.g2;
					graphics.begin(true, Color.fromBytes(25, 25, 25));
					project.render(graphics);
					graphics.end();

					frames[0].g2.begin();
					Scaler.scale(backbuffer, frames[0], System.screenRotation);
					frames[0].g2.end();
				});
			});
		});
	}

	static function onWindowResize(width:Int, height:Int) {
		var target = Scaler.targetRect(backbuffer.width, backbuffer.height, framebuffer.width, framebuffer.height, System.screenRotation);
		var scale = Scaler.getScaledTransformation(backbuffer.width, backbuffer.height, framebuffer.width, framebuffer.height, System.screenRotation);
		App.gameWindow.setGameWindow(target.x, target.y, target.width, target.height, scale, target.scaleFactor, 0);
	}
}
