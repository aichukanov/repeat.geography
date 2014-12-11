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
	
	public class GameMenu extends Sprite {
		
		public var startBtn:MenuButton;
		public var upBtn:MenuButton;
		
		function GameMenu() {
			super();
			
			startBtn = new MenuButton("START");
			upBtn = new MenuButton("UP");
			
			stage ? init() : addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(evt:Event = null) : void {
			//trace('hint init');
			try {
				removeEventListener(Event.ADDED_TO_STAGE, init);
				this.addChild(startBtn);
				startBtn.x = 0; 
				startBtn.y = 0;
				this.addChild(upBtn);
				//upBtn.x = 0;
				//upBtn.y = startBtn.height + 10;
				upBtn.x = stage.stageWidth - upBtn.width;
				upBtn.y = 0;
			}
			catch (e:Error) {
				trace("Hint init()", e.message);
			}
		}
	}
	
}