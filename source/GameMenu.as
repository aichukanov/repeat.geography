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
	import starling.textures.TextureAtlas;
	import flash.display.Bitmap;
	
	public class GameMenu extends Sprite {	
	 	[Embed(source = "/Media/flags/flags.png")]
		private static const FlagsPNG:Class;
		
		[Embed(source="Media/flags/flags.xml",mimeType="application/octet-stream")]
	 	public static const FlagsXML:Class;
				
		public var startBtn:MenuButton;
		public var upBtn:MenuButton;
		
		public var enBtn:Image;
		public var ruBtn:Image;
		
		function GameMenu() {
			super();
			
			startBtn = new MenuButton("START");
			upBtn = new MenuButton("UP");
			
			var tAtlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new FlagsPNG()), XML(new FlagsXML()));
			
			enBtn = new Image(tAtlas.getTexture("en"));
			enBtn.name = "en";
			ruBtn = new Image(tAtlas.getTexture("ru"));
			ruBtn.name = "ru";
			
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
				upBtn.x = startBtn.width + 10;
				upBtn.y = 0;
				
				this.addChild(enBtn);
				enBtn.x = stage.stageWidth - enBtn.width;
				enBtn.y = 0;
				
				this.addChild(ruBtn);
				ruBtn.x = stage.stageWidth - ruBtn.width - enBtn.width - 10;
				ruBtn.y = 0;
				
				//upBtn.x = 0;
				//upBtn.y = startBtn.height + 10;
				
				//upBtn.x = stage.stageWidth - upBtn.width;
				//upBtn.y = 0;
			}
			catch (e:Error) {
				trace("GameMenu init()", e.message);
			}
		}
	}
	
}