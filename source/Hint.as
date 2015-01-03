package 
{
	/**
	 * ...
	 * @author aichukanov
	 */
	
	import starling.display.Sprite;
	import starling.display.Image;
	import starling.events.Event;
	
	import flash.text.Font;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.text.TextFieldAutoSize;
	import starling.utils.VAlign;
	import starling.utils.HAlign;
	
	public class Hint extends Sprite {	 	
		[Embed(source="/Media/hint/hint.png")]
	 	private static const HintPNG:Class;
		
		private static const defFS:uint = 30;
		
		private var desc:String;
		private var bg:Image;
		private var tf:TextField;
		private var font:Font = new CustomFont.RobotoItalic();
		
		function Hint(str:String) {
			super();
			
			bg = new Image(Texture.fromBitmap(new HintPNG()));
			desc = str;
			stage ? init() : addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(evt:Event = null) : void {
			//trace('hint init');
			try {
				removeEventListener(Event.ADDED_TO_STAGE, init);
				
				tf = new TextField(bg.width, bg.height, desc, font.fontName, defFS, 0x000000);
				
				tf.vAlign = VAlign.CENTER;
				tf.hAlign = HAlign.CENTER;
				
				tf.x = bg.x;
				tf.y = bg.y;
								
				this.addChild(bg);
				this.addChild(tf);
				
				tf.autoScale = true;
				bg.height = tf.textBounds.height;
				tf.height = bg.height;
				
				//setSizes();
				//addEventListener(Event.ADDED_TO_STAGE,setSizes);
			}
			catch (e:Error) {
				trace("Hint init()", e.message);
			}
		}
		/*
		public function setSizes(evt:Event = null):void {
			//trace(bg.height);
			var fs:uint = defFS; // def font size
			tf.fontSize = fs;
			//tf.bounds.size = tf.textBounds.size;
			tf.height = tf.textBounds.height;
			bg.bounds.size = tf.textBounds.size;
			//bg.height = tf.height;
			
			//trace( tf.textBounds.height,tf.fontSize);
			while (tf.textBounds.height >= tf.height && fs > 1) {
				fs--;
				tf.fontSize = fs;
			}
			
			fs -= 2;
			tf.fontSize = fs;
			
			//trace( tf.textBounds.height,tf.fontSize);
			//tf.bounds.size = tf.textBounds.size;
			tf.height = tf.textBounds.height;
			bg.bounds.size = tf.textBounds.size;
			//bg.bounds.size = tf.textBounds.size;
		}
		*/
	}
	
}