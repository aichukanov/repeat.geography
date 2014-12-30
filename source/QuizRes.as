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
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	
	public class QuizRes extends Sprite {
		[Embed(source = "/Media/fonts/Roboto-Italic.ttf", embedAsCFF = "false", fontName = "RobotoItalic")]
		private static const RobotoItalic:Class;
	 	
	 	//[Embed(source = "/Media/fonts/Roboto-Light.ttf", embedAsCFF = "false", fontName = "RobotoLight")]
		//private static const RobotoLight:Class;
		
		[Embed(source="/Media/buttons/btn_bg.png")]
	 	private static const BgPNG:Class;
		
		[Embed(source="/Media/quizres/bg_full.png")]
	 	private static const BgFullPNG:Class;
		
		private static const defFS:uint 	= 20;
		private static const defFSFull:uint = 50;
		
		private var font:Font = new RobotoItalic();
		//private var fontFull:Font = new RobotoLight();
		private var bg:Image;
		private var bgFull:Image;
		
		private var pointsTF:TextField;
		private var resTF:TextField;		
		private var timerTF:TextField;
		
		private var timerText:String = "";
		private var resText:String = "";
		
		public var timerValue:uint = 0;
		public var countCorrect:uint = 0;
		public var countFull:uint = 0;
		
		private var timerInt:uint = 0;
		
		function QuizRes() {
			super();
			
			bg = new Image(Texture.fromBitmap(new BgPNG()));
			bg.alpha = 0.2;
			
			bgFull = new Image(Texture.fromBitmap(new BgFullPNG()));
			stage ? init() : addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(evt:Event = null) : void {
			try {
				removeEventListener(Event.ADDED_TO_STAGE, init);
				this.dispose();
				
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
		
		public function initFull() : void {
			try {
				this.dispose();
				
				addChild(bgFull);
				bgFull.x = 0;
				bgFull.y = 0;
				
				pointsTF = makeTFFull(540,140,defFSFull * 2);
				pointsTF.x = 0;
				pointsTF.y = 5;
				pointsTF.autoScale = true;
				
				resTF = makeTFFull(220,70,defFSFull,"RIGHT");
				resTF.x = 310;
				resTF.y = 164;
				setResTF();
				
				timerTF = makeTFFull(220,70,defFSFull,"LEFT");
				timerTF.x = 80;
				timerTF.y = 164;
				setTimerTF();
			}
			catch (e:Error) {
				trace("QuizRes initFull()", e.message);
			}
		}
		
		public function startTimer():void {
			timerInt = setInterval(function () {
										//timerValue--;
										timerValue++;
										setTimerTF();
									},1000);
		}
		
		public function stopTimer():void {
			clearInterval(timerInt);
		}
		
		public function setTimerTF():void {
			try {
				var countMin:int = Math.floor(timerValue / 60);
				var countSec:int  = timerValue % 60;
				timerTF.text = addZero(countMin) + ":" + addZero(countSec);
			}
			catch (e:Error) {
				trace("QuizRes setTimerTF()",e.message);
			}
		}
		
		
		public function setResTF():void {
			try {
				resText = countCorrect.toString() + "/" + countFull.toString();
				resTF.text = resText;
			}
			catch (e:Error) {
				trace("QuizRes setResTF()",e.message);
			}
		}
		
		public function setPointsTF(points:uint, str:String = "points"):void {
			pointsTF.text = points.toString() + " " + str;
		}
		
		private function makeTF():TextField {
			var tf:TextField = makeTFFull(this.width / 2, this.height, defFS);
			addChild(tf);
			return tf;
		}
		
		private function makeTFFull(w:Number, h:Number,fs:uint,pos:String = "CENTER"):TextField {
			var tf:TextField = new TextField(w, h, "", font.fontName, fs, 0xFFFFFF);
			addChild(tf);
			tf.vAlign = VAlign.CENTER;
			tf.hAlign = HAlign[pos];
			
			return tf;
		}
		
		private function addZero(num:uint):String {
			var str:String = num > 9 ? num.toString() : "0" + num.toString();
			return str;
		}
	}
	
}