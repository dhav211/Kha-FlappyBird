package core;

import kha.math.Vector2i;

class Animation {
	public var name:String;
	public var frames:Array<Vector2i>;
	public var numberOfFrames:Int;
	public var currentFrame:Int;
	public var frameLength:Float;
	public var currentFrameLength:Float;
	public var isLooped:Bool;

	public function new(name:String, frames:Array<Vector2i>, fps:Int, ?isLooped:Bool = true) {
		this.name = name;
		this.frames = frames;
		numberOfFrames = frames.length;
		currentFrame = 0;
		frameLength = fps / 60;
		currentFrameLength = 0;
		this.isLooped = isLooped;
	}
}
