package 
{
	/**
	 * ...
	 * @author aichukanov
	 */
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	
	public class Geography extends Sprite 
	{	
		private static const otherTextObj:Object = {
			//question: "Where is "
			question: "Где находится "
		}
	
		private static const topLevelMap:String = "earth"; //"earth"
	
		private var map:Map;
		
		private var lang:String = "ru";
		
		private var question:Question; 
		private var qh:Number = 40; // questionMC height
		private var bh:Number = 40; // bottom line
		private var margin:Number = 10; // margin top and bottom
		
		private var curLvl:Array = []; //["earth","europe"]
		private var curArea:String = topLevelMap;
		
		private var quiz:Quiz;
		public var quizStarted:Boolean	= false;
		public var quizPause:Boolean 	= false;
		
		private var bottomLine:BottomLine;
		private var pLoader:MapPreloader;
		
		private var gameMenu:GameMenu = new GameMenu();
		
		private var quizObj:Object = new Object;
		
		public function Geography():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			try {
				removeEventListener(Event.ADDED_TO_STAGE, init);
				
				addBottomLine();
				//addGameMenu();
				makePreLoader();
				addMap();
			}
			catch (e:Error) { trace("Geography init()",e.message); }
		}
		
		private function addBottomLine():void {
			try {
				bottomLine = new BottomLine(stage.stageWidth,bh);
				addChild(bottomLine);
				
				bottomLine.x = 0;
				bottomLine.y = stage.stageHeight - bottomLine.height;
				
				//bottomLine.tf.text = "hi";
			}
			catch (e:Error) {
				trace("Geography addBottomLine()",e.message);
			}
		}
		
		private function addGameMenu():void {
			try {
				addChild(gameMenu);
				gameMenu.startBtn.addEventListener(TouchEvent.TOUCH, onStartTouch);
				gameMenu.upBtn.addEventListener(TouchEvent.TOUCH, onUpTouch);
				//gameMenu.x = stage.width  / 2 - gameMenu.width  / 2;
				//gameMenu.y = stage.height / 2 - gameMenu.height / 2;
			}
			catch (e:Error) {
				trace("Geography addGameMenu()",e.message);
			}
		}
		
		private function removeGameMenu():void {
			try {
				removeChild(gameMenu);
				gameMenu.startBtn.removeEventListener(TouchEvent.TOUCH, onStartTouch);
			}
			catch (e:Error) {
				trace("Geography removeGameMenu()",e.message);
			}
		}
		
		private function onStartTouch(evt:TouchEvent):void {
			try {
				var t:Touch = evt.touches[0];
				if (t.phase == TouchPhase.ENDED) {
					
					removeGameMenu();
					startQuiz(quizObj);
					//makePreLoader();
					//addMap();
				}
			}
			catch (e:Error) {
				trace("Geography onStartTouch()",e.message);
			}
		}
		
		private function onUpTouch(evt:TouchEvent):void {
			try {
				var t:Touch = evt.touches[0];
				if (t.phase == TouchPhase.ENDED) {
					goUpMap();
				}
			}
			catch (e:Error) {
				trace("Geography onStartTouch()",e.message);
			}
		}
		
		private function addMap():void {
			try {
				//bottomLine.tf.text = "addMap() " + curArea.toString() + " " + curArea;
				if (map) {
					removeChild(map);
					map.clearMap();
					map = null;
				}
				addPreloader();
				
				map = new Map();
				
				map.loadMap(curLvl,curArea,lang);
				map.addEventListener(MapEvent.MAP_LOAD_SUCCESS,onMapLoadSuccess);
				map.addEventListener(MapEvent.MAP_LOAD_ERROR,onMapLoadError);
			}
			catch (e:Error) {
				trace("Geography addMap()",e.message);
			}
			
			function onMapLoadSuccess(evt:Event):void {
				try {
					removePreloader();
					
					addChild(map);
					
					swapChildren(map,bottomLine);
					
					var sc:Number = (stage.stageHeight - (qh + margin) - (bh + margin)) / map.height;
					if (sc > stage.stageWidth / map.width) {
						sc = stage.stageWidth / map.width;
					}
					map.scaleX = sc;
					map.scaleY = sc;
					
					map.y = qh - margin;
					map.x = (stage.stageWidth - map.width) / 2;
					
					addGameMenu();
					
					//quizObj = evt.data.atlas;
					quizObj = evt.data.langObj;
					setListenersMap(quizObj);
					//startQuiz(evt.data.atlas);
				}
				catch (e:Error) {
					//bottomLine.tf.text = "onMapLoadSucces()" + e.message;
					trace("Geography onMapLoadSucces()",e.message);
				}
			}
			
			function onMapLoadError(evt:Event):void {
				try {
					// если не загружается нужная, то грузим карту уровнем выше
					goUpMap();
				}
				catch (e:Error) {
					//bottomLine.tf.text = "onMapLoadError()" + e.message;
					trace("Geography addMap onMapLoadError()",e.message);
				}
			}
		}
		
		private function goUpMap():void {
			if (curLvl.length == 0) {
				curArea = topLevelMap;
			}
			else {
				curArea = curLvl.pop();
			}
			addMap();
		}
		
		private function makePreLoader():void {
			try {
				pLoader = new MapPreloader();
			}
			catch (e:Error) {
				trace("Geography makePreLoader",e.message);
			}
		}
		
		private function addPreloader():void {
			!stage.contains(pLoader) ? stage.addChild(pLoader) : null;
		}
		
		private function removePreloader():void {
			pLoader.hidePL();
			stage.contains(pLoader) ? stage.removeChild(pLoader) : null;
		}
		
		private function startQuiz(obj:Object):void {
			try {
				var areaArr:Array = new Array;
				
				for (var i:String in obj) {
					//areaArr.push(i);
					areaArr.push(obj[i].areaName);
				}
				
				quizStarted = true;
				quiz = new Quiz(areaArr);
				
				quiz.addEventListener(Quiz.QUIZ_FINISH,onQuizFinish);
				quiz.addEventListener(Quiz.QUIZ_NEXT_QUESTION,onNextQuestion);
				quiz.nextQuestion();
			}catch (e:Error) { trace("Geography startQuiz()",e.message); }
		}
		
		private function onNextQuestion(evt:Event):void {
			try {
				var aName:String = evt.data.areaName; // area name
				removeChild(question);
				question = null;
				
				question = new Question(otherTextObj["question"] + quizObj[aName].transName + "?", stage.stageWidth, qh);
				addChild(question);
				swapChildren(question,bottomLine);
			}
			catch (e:Error) {
				trace("Geography onNextQuestion()",e.message);
			}
		}
		
		private function onQuizFinish(evt:Event):void {
			try {
				removeChild(question);
				question = null;
				
				quizStarted = false;
				
				map.setAreaDef();
				addGameMenu();
			}
			catch (e:Error) {
				trace("Geography onQuizFinish()",e.message);
			}
		}
		
		private function setListenersMap(obj:Object):void {
			try {
				var a:Area;
				for (var i:String in obj) {
					//try {
						a = map.getChildByName(obj[i].areaName) as Area;
						a ? a.addEventListener(Area.AREA_SELECTED, onSelectArea) : null;
					//}catch (e:Error) { trace("Geography setListenersMap() for i",i,e.message); }
				}
			}catch (e:Error) { trace("Geography setListenersMap()",e.message); }
		}
		
		private function onSelectArea(evt:Event):void {
			try {
				var area:Area = evt.currentTarget as Area;
				if (quizStarted) {
					if (!quizPause) {
						var areaRight:Area = map.getChildByName(quiz.areaName) as Area;
						var isWrong:Boolean = map.onResponse(area,areaRight);
						
						quizPause = true;
						map.addEventListener(Map.RESPONSE_END,onResponseEnd);
						
						function onResponseEnd(evt:Event):void {
							map.removeEventListener(evt.type,onResponseEnd);
							quizPause = false;
							quiz.nextQuestion();
						}
					}
				}
				else {
					curLvl.push(curArea); 
					curArea = area.name;
					
					addMap();
				}
			}
			catch (e:Error) { trace("Geography onSelectArea()",e.message); }
		}
	}
}