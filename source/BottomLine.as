package  {
	import starling.events.Event;
	import starling.display.Sprite;
	import starling.display.Quad;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	import starling.text.TextField;
	import flash.text.Font;

	/**
	 * ...
	 * @author aichukanov
	 */
	
	public class BottomLine extends Sprite {
		public var tf:TextField;
		
		private var logo:Logo = new Logo();
		private var bg:Quad;
		private var bgWidth:Number;
		private var bgHeight:Number;
		
		public function BottomLine(_w:Number, _h:Number) {
			_w > 0 ? bgWidth = _w : null;
			_h > 0 ? bgHeight = _h : null;
			
			stage ? init() : addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init(evt:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE,init);
			
			addBG();
			addLogo();
			addTF();
		}
		
		private function addBG():void {
			//bg = new Quad(bgWidth,bgHeight,0x666666);
			bg = new Quad(bgWidth,bgHeight,0x000000);
			addChild(bg);
		}
		
		private function addLogo():void {
			addChild(logo);
			
			//var sc:Number = this.height / logo.height;
			//logo.scaleX = sc;
			//logo.scaleY = sc;
			logo.x = 0;
			logo.y = 0;
		}
		
		private function addTF():void {
			var font:Font = new CustomFont.RobotoRegular();
			tf = new TextField(this.width - logo.width - 10, this.height, "", font.fontName, 30, 0xFFFFFF);
				
			tf.vAlign = VAlign.CENTER;
			tf.hAlign = HAlign.LEFT;
			
			tf.x = logo.width + 10;
			tf.y = 0;
							
			this.addChild(tf);
			
			tf.autoScale = true;
		}		
	}
}
