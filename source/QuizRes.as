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
	
	public class QuizRes extends Sprite {
		[Embed(source = "/Media/fonts/Roboto-Italic.ttf", embedAsCFF = "false", fontName = "RobotoItalic")]
		private static const RobotoItalic:Class;
	 	
		[Embed(source="/Media/buttons/btn_bg.png")]
	 	private static const BgPNG:Class;
		
		private static const defFS:uint = 20;
		
		private var font:Font = new RobotoItalic();
		private var bg:Image;
		
		private var resTF:TextField;		
		private var timerTF:TextField;
		
		private var timerText:String = "01:59";
		private var resText:String = "2 / 10";
		
		public var timerValue:uint = 120;
		public var countCorrect:uint = 0;
		public var countFull:uint = 0;
		
		function QuizRes() {
			super();
			
			bg = new Image(Texture.fromBitmap(new BgPNG()));
			bg.alpha = 0.2;
			stage ? init() : addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(evt:Event = null) : void {
			try {
				removeEventListener(Event.ADDED_TO_STAGE, init);
				addChild(bg);
				
				resTF = makeTF(); 
				resTF.x = 0;
				resTF.y = 0;
				setResTF();
				
				timerTF = makeTF();
				timerTF.x = this.width / 2;
				timerTF.y = 0;
				setTimerTF();
			}
			catch (e:Error) {
				trace("QuizRes init()", e.message);
			}
		}
		
		public function setTimerTF():void {
			timerTF.text = timerText;
		}
		
		public function setResTF():void {
			resText = countCorrect.toString() + "/" + countFull.toString();
			resTF.text = resText;
		}
		
		private function makeTF():TextField {
			var tf:TextField = new TextField(this.width / 2, this.height, "", font.fontName, defFS, 0xFFFFFF);
			addChild(tf);
			tf.vAlign = VAlign.CENTER;
			tf.hAlign = HAlign.CENTER;
			
			return tf;
		}
		
	}
	
}