package  {
	import starling.events.Event;
	import starling.display.Sprite;
	import starling.display.Quad;
	import starling.text.TextField;
	import flash.text.Font;
	import starling.utils.VAlign;
	import starling.utils.HAlign;

	/**
	 * ...
	 * @author aichukanov
	 */
	
	public class Question extends Sprite {
		private var bg:Quad;
		private var tf:TextField; 
		
		private var qText:String = "";			// question text
		
		private var fSize:uint = 30; 			// font size
		private var fColor:uint = 0xFFFFFF;		// font color
		private var bgColor:uint = 0x666666;	// background color
		
		private var qWidth:Number = 300;		// question sprite width 
		private var qHeight:Number = 100; 		// question sprite height
		
		public function Question(_qText:String, _w:Number = -1,_h:Number = -1, _cTF:int = -1, _cBG:int = -1) {
			qText = _qText;
			_w > 0 ? qWidth = _w : null;
			_h > 0 ? qHeight = _h : null;
			
			_cTF > 0 ? fColor = _cTF : null;
			_cBG > 0 ? bgColor = _cBG : null;
			
			stage ? init() : addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init(evt:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE,init);
			
			makeBG();
			makeTF();
		}
		
		private function makeBG():void {
			bg = new Quad(qWidth,qHeight,bgColor);
			bg.x = 0;
			bg.y = 0;
			//this.addChild(bg);
		}
		
		private function makeTF():void {
			var font:Font = new CustomFont.RobotoItalic();
			tf = new TextField(qWidth, qHeight, qText, font.fontName, fSize, fColor);
			
			tf.vAlign = VAlign.TOP;
			tf.hAlign = HAlign.CENTER;
			
			tf.x = bg.x;
			tf.y = bg.y;
			tf.italic = true;
			//this.addChild(bg);
			this.addChild(tf);
			
			tf.autoScale = true;
			//bg.height = tf.textBounds.height;
			//tf.height = bg.height;
		}
	}
}
