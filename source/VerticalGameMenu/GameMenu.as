package VerticalGameMenu
{
	/**
	 * ...
	 * @author aichukanov
	 */
		
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.display.Quad;
	import starling.display.Image;
	import starling.textures.Texture;
	import flash.display.BitmapData;
	
	import Localization.*;
			
	public class GameMenu extends Sprite {		
		public var txt:Object;
		
		public var userObj:Object = {
			//userName: "UserName \n UserSurname",
			userName: "UserName UserSurname",
			textureAvatar: null
		}
		
		public var userSprite:UserSprite;
		public var pointsSprite:PointsSprite;
		public var gameBtnsSprite:GameBtnsSprite;
		public var mapBtnsSprite:MapBtnsSprite;
		public var langSprite:LangSprite;
		
		public var curLang:String;
		
		function GameMenu(_lang:String = "en") {
			try {
				super();
				curLang = _lang;
				
				txt = {					
					en: {
						pointSprite: {
							points: "Points",
							total: "Total: 3.6m",
							best: "Best: 230.8k",
							area: "Area: 130.1k"
						},
						
						gameBtnsSprite: {
							pressToStop: "Press to stop:",
							pressToStart: "Press to start:",
			
							study: "STUDY",
							challenge: "CHALLENGE",
							stop: "STOP"
						},						
						
						mapBtnsSprite: {
							regionUp: "REGION UP",
							toChangeRegion: "To change the region select one on the map or press:"
						}
					},
					
					ru: {
						pressToStop: "Прервать:",
						pressToStart: "Нажмите для старта:",
		
						points: "Очки",
						
						total: "Всего: 3.6m",
						best: "Лучший: 230.8k",
						area: "Область: 130.1k",
						
						study: "ОБУЧЕНИЕ",
						challenge: "ВЫЗОВ",
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
			gameBtnsSprite.quizOn();
			removeChild(mapBtnsSprite);
		}
		
		public function quizOff():void {
			gameBtnsSprite.quizOff();
			addChild(mapBtnsSprite);
		}
		
		private function addBG():void {
			var bg:Quad = new Quad(160,720,0x000000);
			addChild(bg);
		}
		
		private function addUser():void {
			userSprite = new UserSprite(userObj.userName,userObj.textureAvatar);
			
			addChild(userSprite);
			userSprite.x = 5;
			userSprite.y = 5;
		}
				
		private function addPoints():void {
			pointsSprite = new PointsSprite(txt[curLang].pointSprite);
			addChild(pointsSprite);
			pointsSprite.x = 5;
			pointsSprite.y = 230;
		}
				
		private function addGameBtns():void {
			gameBtnsSprite = new GameBtnsSprite(txt[curLang].gameBtnsSprite);
			addChild(gameBtnsSprite);
			gameBtnsSprite.x = 5;
			gameBtnsSprite.y = 395;
		}
				
		private function addMapBtns():void {
			mapBtnsSprite = new MapBtnsSprite(txt[curLang].mapBtnsSprite);
			addChild(mapBtnsSprite);
			mapBtnsSprite.x = 5;
			mapBtnsSprite.y = 550;
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