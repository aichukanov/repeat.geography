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
		[Embed(source="/Media/buttons/start_btn.png")]
	 	private static const StartPNG:Class;
		
		[Embed(source="/Media/buttons/up_btn.png")]
	 	private static const UpPNG:Class;
		
		public var startBtn:Image;
		public var upBtn:Image;
		
		function GameMenu() {
			super();
			
			startBtn = new Image(Texture.fromBitmap(new StartPNG()));
			upBtn = new Image(Texture.fromBitmap(new UpPNG()));
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