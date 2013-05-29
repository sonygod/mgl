package mgl;
class C { // Color
	public var ti(get, null):C; // transparent instance
	public var di(get, null):C; // dark (black) instance
	public var ri(get, null):C; // red instance
	public var gi(get, null):C; // green instance
	public var bi(get, null):C; // blue instance
	public var yi(get, null):C; // yellow instance
	public var mi(get, null):C; // magenta instance
	public var ci(get, null):C; // cyan instance
	public var wi(get, null):C; // white instance
	public var r:Int;
	public var g:Int;
	public var b:Int;
	public var i(get, null):Int; // integer value
	public function v(v:C):C { return setValue(v); }
	public var gd(get, null):C; // go dark
	public var gw(get, null):C; // go white
	public var gr(get, null):C; // go red
	public var gg(get, null):C; // go green
	public var gb(get, null):C; // go blue
	public var gbl(get, null):C; // go blink
	public function bl(color:C, ratio:Float):C { return blend(color, ratio); }

	static inline var LEVEL_VALUE = 80;
	static inline var MAX_VALUE = 250;
	static inline var WHITENESS = 0;
	static var random:R;
	static var u:U;
	public static function initialize():Void {
		random = new R();
		u = new U();
	}
	var blinkColor:C;
	public function new(r:Int = 0, g:Int = 0, b:Int = 0) {
		this.r = r;
		this.g = g;
		this.b = b;
	}
	public function getBlinkColor():C {
		if (blinkColor == null) blinkColor = new C();
		changeValueColor(blinkColor, 
			random.i(128, -64), random.i(128, -64), random.i(128, -64));
		return blinkColor;
	}
	function get_ti():C { return new C(-1); }
	function get_di():C { return new C(0, 0, 0); }
	function get_ri():C { return new C(MAX_VALUE, WHITENESS, WHITENESS); }
	function get_gi():C { return new C(WHITENESS, MAX_VALUE, WHITENESS); }
	function get_bi():C { return new C(WHITENESS, WHITENESS, MAX_VALUE); }
	function get_yi():C { return new C(MAX_VALUE, MAX_VALUE, WHITENESS); }
	function get_mi():C { return new C(MAX_VALUE, WHITENESS, MAX_VALUE); }
	function get_ci():C { return new C(WHITENESS, MAX_VALUE, MAX_VALUE); }
	function get_wi():C { return new C(MAX_VALUE, MAX_VALUE, MAX_VALUE); }
	function get_i():Int {
		return 0xff000000 + r * 0x10000 + g * 0x100 + b;
	}
	function setValue(c:C):C {
		r = c.r;
		g = c.g;
		b = c.b;
		return this;
	}
	function get_gw():C {
		return changeValue(LEVEL_VALUE, LEVEL_VALUE, LEVEL_VALUE);
	}
	function get_gd():C {
		return changeValue(-LEVEL_VALUE, -LEVEL_VALUE, -LEVEL_VALUE);
	}
	function get_gr():C {
		return changeValue(LEVEL_VALUE, Std.int(-LEVEL_VALUE / 2), Std.int(-LEVEL_VALUE / 2));
	}
	function get_gg():C {
		return changeValue(Std.int(-LEVEL_VALUE / 2), LEVEL_VALUE, Std.int(-LEVEL_VALUE / 2));
	}
	function get_gb():C {
		return changeValue(Std.int(-LEVEL_VALUE / 2), Std.int(-LEVEL_VALUE / 2), LEVEL_VALUE);
	}
	function get_gbl():C {
		return changeValue(random.i(128, -64), random.i(128, -64), random.i(128, -64));
	}
	function blend(c:C, ratio:Float):C {
		return changeValue(
			Std.int((c.r - r) * ratio),
			Std.int((c.g - g) * ratio),
			Std.int((c.b - b) * ratio));
	}

	function changeValue(rv:Int, gv:Int, bv:Int):C {
		var changedColor = new C();
		changeValueColor(changedColor, rv, gv, bv);
		return changedColor;
	}
	function changeValueColor(color:C, rv:Int, gv:Int, bv:Int):Void {
		color.v(this);
		color.r += rv; color.g += gv; color.b += bv;
		color.normalize();
	}
	function normalize():Void {
		r = u.ci(r, 0, MAX_VALUE);
		g = u.ci(g, 0, MAX_VALUE);
		b = u.ci(b, 0, MAX_VALUE);
	}
}