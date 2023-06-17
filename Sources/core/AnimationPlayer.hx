package core;

import kha.math.Vector2i;

class AnimationPlayer {
	var animations:Map<String, Animation>;
	var currentAnimation:String;
	var isPaused:Bool;

	public function new() {
		animations = new Map<String, Animation>();
		currentAnimation = "";
	}

	public function addAnimation(name:String, frames:Array<Vector2i>, fps:Int) {
		var animation:Animation = new Animation(name, frames, fps);
		animations.set(name, animation);
	}

	public function play(name:String) {
		if (currentAnimation != name) {
			currentAnimation = name;
		}
	}

	public function update(delta:Float) {
		if (!isPaused && currentAnimation != "") {
			animations[currentAnimation].currentFrameLength += delta;

			if (animations[currentAnimation].currentFrameLength >= animations[currentAnimation].frameLength) {
				animations[currentAnimation].currentFrame++;
				animations[currentAnimation].currentFrameLength = 0;
			}

			if (animations[currentAnimation].currentFrame >= animations[currentAnimation].numberOfFrames) {
				animations[currentAnimation].currentFrame = 0;
				// TODO Signal that the animation is done
			}
		}
	}

	public function pause() {
		isPaused = true;
	}

	public function resume() {
		isPaused = false;
	}

	public function stop() {
		currentAnimation = "";
	}

	public function getCurrentFrame():Vector2i {
		if (currentAnimation != "") {
			return animations[currentAnimation].frames[animations[currentAnimation].currentFrame];
		}

		return new Vector2i(0, 0);
	}
}
