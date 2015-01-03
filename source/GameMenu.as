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
	import starling.display.Quad;
	import starling.text.BitmapFont;
		
	public class GameMenu extends Sprite {
	 	[Embed(source = "/media/flags/flags.png")]
		private static const FlagsPNG:Class;
		
		[Embed(source="media/flags/flags.xml",mimeType="application/octet-stream")]
	 	public static const FlagsXML:Class;
				
	 	[Embed(source = "/media/buttons/arrow_expand.png")]
		private static const ArrowExpandPNG:Class;
		
		private var font:Font = new CustomFont.RobotoRegular();
		
		public var startBtn:MenuButton;
		public var studyBtn:MenuButton;
		public var stopBtn:MenuButton;
		public var upBtn:MenuButton;
		
		//public var startBtn:MenuButton 	= new MenuButton("START");
		//public var stopBtn:MenuButton 	= new MenuButton("STOP");
		//public var upBtn:MenuButton		= new MenuButton("UP");
		
		//public var enBtn:Image;
		//public var ruBtn:Image;
		public var enBtn:Button;
		public var ruBtn:Button;
		
		public var userSprite:Sprite 	= new Sprite();
		public var pointsSprite:Sprite 	= new Sprite();
		public var gameBtnsSprite:Sprite = new Sprite();
		public var mapBtnsSprite:Sprite = new Sprite();
		public var langSprite:Sprite 	= new Sprite();
		
		private var tAtlas:TextureAtlas;
		
		function GameMenu() {
			try {
				super();
				
				tAtlas = new TextureAtlas(Texture.fromBitmap(new FlagsPNG()), XML(new FlagsXML()));
				
				enBtn = new Button(tAtlas.getTexture("en"));
				enBtn.name = "en";
				ruBtn = new Button(tAtlas.getTexture("ru"));
				ruBtn.name = "ru";
				/*
				var texture:Texture = Texture.fromBitmap(new FontTexture());
				var xml:XML = XML(new FontXml());
				TextField.registerBitmapFont(new BitmapFont(texture, xml));
				*/
				stage ? init() : addEventListener(Event.ADDED_TO_STAGE, init);
			}
			catch (e:Error) {
				trace("GameMenu()",e.message);
			}
		}
		
		public function init(evt:Event = null) : void {
			try {
				this.dispose();
				
				addBG();
				addUser();
				addPoints();
				addGameBtns();
				addMapBtns();
				addLangSprite();
			}
			catch (e:Error) {
				trace("GameMenu init()", e.message);
			}
		}
		
		public function quizOn():void {
			(gameBtnsSprite.getChildByName("tf") as TextField).text = "Press to stop:";
			gameBtnsSprite.removeChild(studyBtn);
			gameBtnsSprite.removeChild(startBtn);
			gameBtnsSprite.addChild(stopBtn);
			
			removeChild(mapBtnsSprite);			
			removeChild(langSprite);
		}
		
		public function quizOff():void {
			(gameBtnsSprite.getChildByName("tf") as TextField).text = "Press to start:";
			
			gameBtnsSprite.removeChild(stopBtn);
			gameBtnsSprite.addChild(studyBtn);
			gameBtnsSprite.addChild(startBtn);
			
			addChild(mapBtnsSprite);			
			addChild(langSprite);
		}
		
		private function addBG():void {
			var bg:Quad = new Quad(160,720,0x000000);
			addChild(bg);
		}
		
		private function addUser():void {
			addChild(userSprite);
			userSprite.x = 5;
			userSprite.y = 5; 
			
			var avatar:Quad = new Quad(150,150,0x666666)
			userSprite.addChild(avatar);
			avatar.x = 0;
			avatar.y = 0;
			
			var tf:TextField = makeTF(150,46.2,16);
			userSprite.addChild(tf);
			
			tf.x = 0;
			tf.y = 155;
			tf.autoScale = true;
			tf.text = "UserName \n UserSurname";
		}
				
		private function addPoints():void {
			var tf:TextField;
			var q:Quad;
			
			addChild(pointsSprite);
			pointsSprite.x = 5;
			pointsSprite.y = 230;
			
			tf = makeTF(150,27.75,18);
			pointsSprite.addChild(tf);
			//tf.x = 5;
			//tf.y = 230;
			tf.x = 0;
			tf.y = 0;
			tf.autoScale = true;
			tf.text = "Points";
			
			q = new Quad(150,2,0xFFFFFF);
			pointsSprite.addChild(q);
			//q.x = 5;
			//q.y = 260;
			q.x = 0;
			q.y = 30;
			
			tf = makeTF(150,27.75,18, "LEFT");
			pointsSprite.addChild(tf);
			//tf.x = 5;
			//tf.y = 265;
			tf.x = 0;
			tf.y = 35;
			tf.autoScale = true;
			tf.text = "Total: 3.6m";
			
			tf = makeTF(150,27.75,18, "LEFT");
			pointsSprite.addChild(tf);
			//tf.x = 5;
			//tf.y = 290;
			tf.x = 0;
			tf.y = 60;
			tf.autoScale = true;
			tf.text = "Best: 230.8k";
			
			q = new Quad(80,2,0xFFFFFF);
			pointsSprite.addChild(q);
			//q.x = 40;
			//q.y = 325;
			q.x = 35;
			q.y = 95;
			
			tf = makeTF(150,27.75,18, "LEFT");
			pointsSprite.addChild(tf);
			//tf.x = 5;
			//tf.y = 330;
			tf.x = 0;
			tf.y = 100;
			tf.autoScale = true;
			tf.text = "Area: 130.1k";
			
			q = new Quad(150,2,0xFFFFFF);
			pointsSprite.addChild(q);
			//q.x = 5;
			//q.y = 360;
			q.x = 0;
			q.y = 130;
		}
				
		private function addGameBtns():void {
			!contains(gameBtnsSprite) ? addChild(gameBtnsSprite) : null;
			gameBtnsSprite.x = 5;
			gameBtnsSprite.y = 395;
			
			var tf:TextField = makeTF(150,26,16, "LEFT");
			gameBtnsSprite.addChild(tf);
			tf.name = "tf";
			tf.x = 0;
			tf.y = 0;
			tf.autoScale = true;
			
			tf.text = "Press to start:";
			
			studyBtn = new MenuButton("STUDY");
			gameBtnsSprite.addChild(studyBtn);
			studyBtn.x = 0;
			studyBtn.y = 25;
			
			startBtn = new MenuButton("CHALLENGE");
			gameBtnsSprite.addChild(startBtn);
			startBtn.x = 0;
			startBtn.y = 65;
			
			//tf.text = "Press to stop:";
			stopBtn = new MenuButton("STOP");
			//gameBtnsSprite.addChild(stopBtn);
			stopBtn.x = 0;
			stopBtn.y = 25;
		}
				
		private function addMapBtns():void {
			addChild(mapBtnsSprite);
			mapBtnsSprite.x = 5;
			mapBtnsSprite.y = 550;
			
			var tf:TextField = makeTF(150,70,16, "LEFT");
			mapBtnsSprite.addChild(tf);
			//tf.x = 5;
			//tf.y = 550;
			tf.x = 0;
			tf.y = 0;
			tf.autoScale = true;
			tf.text = "To change the region select one on the map or press:";
			
			upBtn = new MenuButton("REGION UP");
			mapBtnsSprite.addChild(upBtn);
			//upBtn.x = 5;
			//upBtn.y = 620;
			upBtn.x = 0;
			upBtn.y = 70;
		}
				
		private function addLangSprite():void {
			addChild(langSprite);
			//langSprite.x = 70;
			//langSprite.y = 670;
			langSprite.x = 20;
			langSprite.y = 670;
			
			var tf:TextField = makeTF(50,41,28, "LEFT");
			langSprite.addChild(tf);
			//tf.x = 20;
			//tf.y = 670;
			tf.x = 0;
			tf.y = 0;
			tf.autoScale = true;
			tf.text = "EN";
			
			langSprite.addChild(enBtn);
			enBtn.x = 50;
			enBtn.y = 0;
			
			var btn:Button = new Button(Texture.fromBitmap(new ArrowExpandPNG()));
			langSprite.addChild(btn);
			btn.x = 115;
			btn.y = 0;
		}
		
		private function makeTF(w:Number, h:Number,fs:uint,pos:String = "CENTER"):TextField {
			var tf:TextField = new TextField(w, h, "", font.fontName, fs, 0xFFFFFF);
			tf.vAlign = VAlign.CENTER;
			tf.hAlign = HAlign[pos];
			
			return tf;
		}
		
	}
	
}