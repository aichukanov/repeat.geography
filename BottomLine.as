package  {
	import starling.events.Event;
	import starling.display.Sprite;
	import starling.display.Quad;

	/**
	 * ...
	 * @author aichukanov
	 */
	
	public class BottomLine extends Sprite {
		[Embed(source = "/Media/fonts/Roboto-Italic.ttf", embedAsCFF = "false", fontName = "RobotoItalic")]
		private static const RobotoItalic:Class;
		
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
		}
		
		private function addBG():void {
			bg = new Quad(bgWidth,bgHeight,0x666666);
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
	}
}
