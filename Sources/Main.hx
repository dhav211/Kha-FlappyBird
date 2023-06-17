package;

import core.UIManager;
import kha.math.Random;
import kha.Assets;
import kha.Scheduler;
import kha.System;
import core.App;
import core.Input;

class Main {
	public static function main() {
		System.start({title: "Flappy Bird", width: 288, height: 512}, function(_) {
			Assets.loadEverything(function() {
				// Set the seed for random so it can be called from anywhere
				Random.init(cast(Date.now().getTime()));
				App.input = new Input();
				App.uiManager = new UIManager();
				var project = new Project();
				var delta:Float = 0;
				var currentTime:Float = 0;

				Scheduler.addTimeTask(function() {
					delta = Scheduler.time() - currentTime;
					project.update(delta);
					App.uiManager.checkListeners();
					App.input.endFrame();
					currentTime = Scheduler.time();
				}, 0, 1 / 60);
				System.notifyOnFrames(function(frames) {
					project.render(frames[0]);
				});
			});
		});
	}
}
