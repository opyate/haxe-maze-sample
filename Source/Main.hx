package;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.text.TextField;
import openfl.events.Event;
import maze.Prim;
import maze.DepthFirst;
import openfl.Lib;

class Main extends Sprite {
	var inited:Bool;

	private var primMap:Array<Array<Int>>;
	private var depthfirstMap:Array<Array<Int>>;

	private var primBitmap:Bitmap;
	private var depthfirstBitmap:Bitmap;

	function resize(e) {
		if (!inited) {
			init();
		}
		// else (resize or orientation change)
	}

	function init() {
		if (inited) {
			return;
		}
		inited = true;

		drawMaze(DepthFirst.make(33, 33, "foo"), 50, 50, "DepthFirst");
		drawMaze(Prim.make(33, 33, "foo"), 450, 50, "Prim");
	}

	function drawMaze(maze:Array<Array<Int>>, x: Int, y: Int, name: String) {
		trace(maze);

		var bitmap:Bitmap = new Bitmap();
		bitmap.scaleX = bitmap.scaleY = 10;
		bitmap.x = x;
		bitmap.y = y;

		var data:BitmapData = new BitmapData(maze.length, maze[0].length, false, 0xFFF5BF);

		for (y in 0...maze.length) {
			for (x in 0...maze[0].length) {
				var value:Int = maze[y][x];

				if (value == 1) {
					data.setPixel(x, y, 0xFF6E42);
				}
			}
		}

		bitmap.bitmapData = data;

		addChild(bitmap);

		header(name, x, y - 40);
	}

	function header(str:String, x:Int, y:Int) {
		var text:TextField = new TextField();
		text.text = str;
		text.x = x;
		text.y = y;

		text.setTextFormat(new openfl.text.TextFormat("_typewriter", 16, 0x000000, true));
		text.selectable = false;
		text.width = 800;
		text.height = 40;
		addChild(text);
	}

	public function new() {
		super();
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) {
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		init();
	}

	public static function main() {
		// static entry point
		Lib.current.stage.align = openfl.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = openfl.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
