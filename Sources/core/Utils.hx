package core;

class Utils {
	static public function radToDeg(radians:Float):Float {
		return radians * 180 / Math.PI;
	}

	static public function degToRad(degree:Float):Float {
		return degree * Math.PI / 180;
	}
}
