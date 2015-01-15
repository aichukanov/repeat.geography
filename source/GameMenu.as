package 
{
	/**
	 * ...
	 * @author aichukanov
	 */
		
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.display.Quad;
		
	public class GameMenu extends Sprite {		
		public var txt:Object;
		
		public var startBtn:MenuButton;
		public var studyBtn:MenuButton;
		public var stopBtn:MenuButton;
		public var upBtn:MenuButton;
		
		public var userSprite:Sprite 	= new Sprite();
		public var pointsSprite:Sprite 	= new Sprite();
		public var gameBtnsSprite:Sprite = new Sprite();
		public var mapBtnsSprite:Sprite = new Sprite();
		
		public var langSprite:LangSprite;
		public var curLang:String;
		
		function GameMenu(_lang:String = "en") {
			try {
				super();
				curLang = _lang;
				
				txt = {
					userName: "UserName \n UserSurname",
					
					en: {
						pressToStop: "Press to stop:",
						pressToStart: "Press to start:",
		
						points: "Points",
						
						total: "Total: 3.6m",
						best: "Best: 230.8k",
						area: "Area: 130.1k",
						
						study: "STUDY",
						challenge: "CHALLENGE",
						stop: "STOP",
						regionUp: "REGION UP", 
						
						toChangeRegion: "To change the region select one on the map or press:"
					},
					
					ru: {
						pressToStop: "Прервать:",
						pressToStart: "Нажмите для старта:",
		
						points: "Очки",
						
						total: "Всего: 3.6m",
						best: "Лучший: 230.8k",
						area: "Область: 130.1k",
						
						study: "ОБУЧЕНИЕ",
						challenge: "СОРЕВНОВАНИЕ",
						stop: "СТОП",
						regionUp: "ВВЕРХ", 
						
						toChangeRegion: "Нажмите, чтобы сменить область:"
					}
				}
				
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
			(gameBtnsSprite.getChildByName("tf") as TextField).text = txt[curLang].pressToStop; //"Press to stop:"
			gameBtnsSprite.removeChild(studyBtn);
			gameBtnsSprite.removeChild(startBtn);
			gameBtnsSprite.addChild(stopBtn);
			
			removeChild(mapBtnsSprite);			
			//removeChild(langSprite);
		}
		
		public function quizOff():void {
			(gameBtnsSprite.getChildByName("tf") as TextField).text = txt[curLang].pressToStart; //"Press to start:";
			
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
			
			var tf:TextField = CustomTF.makeTF(150,46.2,16);
			userSprite.addChild(tf);
			
			tf.x = 0;
			tf.y = 155;
			tf.autoScale = true;
			tf.text = txt.userName;
		}
				
		private function addPoints():void {
			var tf:TextField;
			var q:Quad;
			
			addChild(pointsSprite);
			pointsSprite.x = 5;
			pointsSprite.y = 230;
			
			tf = CustomTF.makeTF(150,27.75,18);
			pointsSprite.addChild(tf);
			tf.x = 0;
			tf.y = 0;
			tf.autoScale = true;
			tf.text = txt[curLang].points; // "Points";
			
			q = new Quad(150,2,0xFFFFFF);
			pointsSprite.addChild(q);
			q.x = 0;
			q.y = 30;
			
			tf = CustomTF.makeTF(150,27.75,18, "LEFT");
			pointsSprite.addChild(tf);
			tf.x = 0;
			tf.y = 35;
			tf.autoScale = true;
			tf.text = txt[curLang].total; // "Total: 3.6m";
			
			tf = CustomTF.makeTF(150,27.75,18, "LEFT");
			pointsSprite.addChild(tf);
			tf.x = 0;
			tf.y = 60;
			tf.autoScale = true;
			tf.text = txt[curLang].best; // "Best: 230.8k";
			
			q = new Quad(80,2,0xFFFFFF);
			pointsSprite.addChild(q);
			q.x = 35;
			q.y = 95;
			
			tf = CustomTF.makeTF(150,27.75,18, "LEFT");
			pointsSprite.addChild(tf);
			tf.x = 0;
			tf.y = 100;
			tf.autoScale = true;
			tf.text = txt[curLang].area; // "Area: 130.1k";
			
			q = new Quad(150,2,0xFFFFFF);
			pointsSprite.addChild(q);
			q.x = 0;
			q.y = 130;
		}
				
		private function addGameBtns():void {
			//if (contains(gameBtnsSprite)) {
				//removeChild(gameBtnsSprite);
			//}
			addChild(gameBtnsSprite);			
			
			gameBtnsSprite.x = 5;
			gameBtnsSprite.y = 395;
			
			var tf:TextField = CustomTF.makeTF(150,26,16, "LEFT");
			gameBtnsSprite.addChild(tf);
			tf.name = "tf";
			tf.x = 0;
			tf.y = 0;
			tf.autoScale = true;
			
			tf.text = txt[curLang].pressToStart; // "Press to start:";
			
			studyBtn = new MenuButton(txt[curLang].study); // "STUDY"
			gameBtnsSprite.addChild(studyBtn);
			studyBtn.x = 0;
			studyBtn.y = 25;
			
			startBtn = new MenuButton(txt[curLang].challenge); // "CHALLENGE"
			gameBtnsSprite.addChild(startBtn);
			startBtn.x = 0;
			startBtn.y = 65;
			
			//tf.text = "Press to stop:";
			stopBtn = new MenuButton(txt[curLang].stop); // "STOP");
			//gameBtnsSprite.addChild(stopBtn);
			stopBtn.x = 0;
			stopBtn.y = 25;
		}
				
		private function addMapBtns():void {
			addChild(mapBtnsSprite);
			mapBtnsSprite.x = 5;
			mapBtnsSprite.y = 550;
			
			var tf:TextField = CustomTF.makeTF(150,70,16, "LEFT");
			mapBtnsSprite.addChild(tf);
			tf.x = 0;
			tf.y = 0;
			tf.autoScale = true;
			tf.text = txt[curLang].toChangeRegion; // "To change the region select one on the map or press:";
			
			upBtn = new MenuButton(txt[curLang].regionUp); // "REGION UP");
			mapBtnsSprite.addChild(upBtn);
			upBtn.x = 0;
			upBtn.y = 70;
		}
				
		private function addLangSprite():void {
			langSprite = new LangSprite(curLang);
			langSprite.addEventListener(LangEvent.SWITCH_LANGUAGE, switchLanguage);
			addChild(langSprite);
			langSprite.x = 5;
			langSprite.y = 660;
		}
		
		private function switchLanguage(evt:Event):void {
			curLang = evt.data.newLang;
			//init();
			dispatchEventWith(LangEvent.SWITCH_LANGUAGE,false,evt.data);
		}
	}
	
}