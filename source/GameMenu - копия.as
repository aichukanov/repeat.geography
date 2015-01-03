package 
{
	/**
	 * ...
	 * @author aichukanov
	 */
	
	import starling.display.Sprite;
	import starling.display.Image;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.utils.VAlign;
	import starling.utils.HAlign;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.events.Event;
	
	import flash.text.Font;
	import flash.display.Bitmap;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import starling.display.Button;
		
	public class GameMenu extends Sprite {	
	 	[Embed(source = "/Media/flags/flags.png")]
		private static const FlagsPNG:Class;
		
		[Embed(source="Media/flags/flags.xml",mimeType="application/octet-stream")]
	 	public static const FlagsXML:Class;
				
		public var startBtn:MenuButton 	= new MenuButton("START");
		public var stopBtn:MenuButton 	= new MenuButton("STOP");
		public var upBtn:MenuButton		= new MenuButton("UP");
		
		//public var enBtn:Image;
		//public var ruBtn:Image;
		public var enBtn:Button;
		public var ruBtn:Button;
		
		public var langSprite:Sprite = new Sprite();
		
		private var tAtlas:TextureAtlas;
		
		function GameMenu() {
			try {
				super();
				
				tAtlas = new TextureAtlas(Texture.fromBitmap(new FlagsPNG()), XML(new FlagsXML()));
				
				enBtn = new Button(tAtlas.getTexture("en"));
				enBtn.name = "en";
				ruBtn = new Button(tAtlas.getTexture("ru"));
				ruBtn.name = "ru";
				
				stage ? init() : addEventListener(Event.ADDED_TO_STAGE, init);
			}
			catch (e:Error) {
				trace("GameMenu()",e.message);
			}
		}
		
		private function init(evt:Event = null) : void {
			//trace('hint init');
			try {
				removeEventListener(Event.ADDED_TO_STAGE, init);
				addChild(langSprite);
				
				addStartBtn();
				addUpBtn();
				
				addEnBtn();
				addRuBtn();
			}
			catch (e:Error) {
				trace("GameMenu init()", e.message);
			}
		}
		
		public function quizOn():void {
			removeBtn(startBtn);
			removeBtn(upBtn);
			
			removeChild(langSprite);
			
			addStopBtn();
		}
		
		public function quizOff():void {
			removeBtn(stopBtn);
			
			addStartBtn();
			addUpBtn();
			
			addChild(langSprite);
		}
		
		private function removeBtn(btn:MenuButton):void {
			try {
				if (contains(btn)) {
					removeChild(btn);
				}
			}
			catch (e:Error) {
				trace("GameMenu removeBtn()",e.message);
			}
		}
		
		// START Button
		private function addStartBtn():void {
			try {
				if (!contains(startBtn)) {
					addChild(startBtn);
					startBtn.x = 0;
					startBtn.y = 0;
					startBtn.addEventListener(TouchEvent.TOUCH, onTouch);
				}
			}
			catch (e:Error) {
				trace("GameMenu addStartBtn()",e.message);
			}
		}
		
		// STOP Button 
		private function addStopBtn():void {
			try {
				if (!contains(stopBtn)) {
					addChild(stopBtn);
					stopBtn.x = 0;
					stopBtn.y = 0;
				}
			}
			catch (e:Error) {
				trace("GameMenu addStopBtn()",e.message);
			}
		}
		
		// STOP Button 
		private function addUpBtn():void {
			try {
				if (!contains(upBtn)) {
					addChild(upBtn);
					upBtn.x = startBtn.width + 10;
					upBtn.y = 0;
				}
			}
			catch (e:Error) {
				trace("GameMenu addUpBtn()",e.message);
			}
		}
		
		private function addEnBtn():void {
			try {
				if (!langSprite.contains(enBtn)) {
					langSprite.addChild(enBtn);
					enBtn.x = stage.stageWidth - enBtn.width;
					enBtn.y = 0;
				}
			}
			catch (e:Error) {
				trace("GameMenu addEnBtn()",e.message);
			}
		}
		
		private function addRuBtn():void {
			try {
				if (!langSprite.contains(ruBtn)) {
					langSprite.addChild(ruBtn);
					ruBtn.x = stage.stageWidth - ruBtn.width - enBtn.width - 10;
					ruBtn.y = 0;
				}
			}
			catch (e:Error) {
				trace("GameMenu addRuBtn()",e.message);
			}
		}
		
		private function onTouch(evt:TouchEvent):void {
			var t:Touch = evt.touches[0];
			t = evt.touches[0];
			if (t.phase == TouchPhase.HOVER) {
				Mouse.cursor = MouseCursor.BUTTON;
			}
			
			t = evt.getTouch(evt.currentTarget as Image, TouchPhase.HOVER);
			
			if (t) {
				Mouse.cursor = MouseCursor.ARROW;
			}
			
			/*
			trace(t.phase);
			if (t.phase == TouchPhase.HOVER) {
				Mouse.cursor = MouseCursor.HAND;
			}
			else {
				if (t.phase == TouchPhase.MOVED) {
					//
				}
			}
			*/
		}
		
	}
	
}