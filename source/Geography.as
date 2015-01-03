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
	import starling.display.Image;
	import starling.display.Button;
	import starling.display.Quad;
	import flash.utils.getTimer;
	
	public class Geography extends Sprite 
	{	
		private static const otherTextObj:Object = {
			question_en: "Where is ",
			question_ru: "Где находится "
		}

		private const topLevelMap:String 	= "earth"; //"earth"
		private const timeToAnswer:uint 	= 5000;	// 5 секунд на ответ
		
		private const qh:Number 	= 0; // questionMC height
		private const bh:Number 	= 0; // bottom line height
		private const margin:Number = 0; // margin top and bottom
	
		private var lang:String		= "en";
		private var curLvl:Array	= []; //["earth","europe"]
		private var curArea:String	= topLevelMap;
		
		private var map:Map;
		private var question:Question;
		private var quiz:Quiz;
		private var quizRes:QuizRes;
		
		public var quizStarted:Boolean	= false;
		public var quizPause:Boolean 	= false;
		
		private var bottomLine:BottomLine;
		private var pLoader:MapPreloader;
		
		private var gameMenu:GameMenu = new GameMenu();
		
		private var quizObj:Object = new Object;
		
		private var pointTimer:uint = 0;
		private var pointCounter:uint = 0;
		
		private var userObj:Object = {
			userName: "user",
			allPoints: 0,
			areaPoints: 0
		}
		
		public function Geography():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			try {
				removeEventListener(Event.ADDED_TO_STAGE, init);
				
				addBottomLine();
				addGameMenu();
				makePreLoader();
				addMap();
			}
			catch (e:Error) { trace("Geography init()",e.message); }
		}
		
		private function addBottomLine():void {
			try {
				bottomLine = new BottomLine(stage.stageWidth,bh);
				addChild(bottomLine);
				bottomLine.visible = false;
				bottomLine.x = 0;
				bottomLine.y = stage.stageHeight - bottomLine.height;
				
				bottomLine.tf.text = "hi, " + userObj.userName + ". You have " + userObj.allPoints + " points";
			}
			catch (e:Error) {
				trace("Geography addBottomLine()",e.message);
			}
		}
		
		private function addGameMenu():void {
			try {
				if (!contains(gameMenu)) {
					addChild(gameMenu);
					gameMenu.startBtn.addEventListener(TouchEvent.TOUCH, onStartTouch);
					gameMenu.stopBtn.addEventListener(TouchEvent.TOUCH, onStopTouch);
					gameMenu.upBtn.addEventListener(TouchEvent.TOUCH, onUpTouch);
					
					//gameMenu.enBtn.addEventListener(TouchEvent.TOUCH, switchLanguage);
					//gameMenu.ruBtn.addEventListener(TouchEvent.TOUCH, switchLanguage);
				}
			}
			catch (e:Error) {
				trace("Geography addGameMenu()",e.message);
			}
		}
		
		private function switchLanguage(evt:TouchEvent):void {
			try {
				var t:Touch = evt.touches[0];
				
				if (!quizStarted) {
					if (t.phase == TouchPhase.ENDED) {
						lang = (evt.currentTarget as Button).name;
						addMap();
					}
				}
			}
			catch (e:Error) {
				trace("Geography switchLanguage()",e.message);
			}
		}
		
		private function removeGameMenu():void {
			try {
				removeChild(gameMenu);
				gameMenu.dispose();
			}
			catch (e:Error) {
				trace("Geography removeGameMenu()",e.message);
			}
		}
		
		private function onStartTouch(evt:TouchEvent):void {
			try {
				var t:Touch = evt.touches[0];
								
				if (!quizStarted) {
					if (t.phase == TouchPhase.ENDED) {
						startQuiz(quizObj);
					}
				}
				else {
					trace("quiz already started");
				}
			}
			catch (e:Error) {
				trace("Geography onStartTouch()",e.message);
			}
		}
		
		private function onStopTouch(evt:TouchEvent):void {
			try {
				if (quizStarted) {
					var t:Touch = evt.touches[0];
					if (t.phase == TouchPhase.ENDED) {
						onQuizFinish();
					}
				}
				else {
					trace("You should start Quiz before stop");
				}
			}
			catch (e:Error) {
				trace("Geography onStartTouch()",e.message);
			}
		}
		
		private function onUpTouch(evt:TouchEvent):void {
			try {
				var t:Touch = evt.touches[0];
				if (!quizStarted) {
					if (t.phase == TouchPhase.ENDED) {
						goUpMap();
					}
				}
				else {
					trace("quiz already started");
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
				map.addEventListener(MapEvent.MAP_LOAD_SUCCESS,onMapLoadSuccess);
				map.addEventListener(MapEvent.MAP_LOAD_ERROR,onMapLoadError);
				
				map.loadMap(curLvl,curArea,lang);
			}
			catch (e:Error) {
				trace("Geography addMap()",e.message);
				bottomLine.tf.text = "addMap() " + e.message;
			}
			
			function onMapLoadSuccess(evt:Event):void {
				try {
					//bottomLine.tf.text = "onMapLoadSucces() ok";
					removePreloader();
					
					addChild(map);
					
					swapChildren(map,bottomLine);
					
					var sc:Number = (stage.stageHeight - (qh + margin) - (bh + margin)) / map.height;
					//var sc:Number = 600 / map.height;
					//trace("sc",sc,"height:", map.height,stage.height);
					if (sc > (stage.stageWidth - 160) / map.width) {
						sc = (stage.stageWidth - 160) / map.width;
					}
					map.scaleX = sc;
					map.scaleY = sc;
					map.y = (stage.stageHeight - map.height) / 2;
					map.x = 160 + ((stage.stageWidth - 160) - map.width) / 2;
					
					//addGameMenu();
					
					//quizObj = evt.data.atlas;
					quizObj = evt.data.langObj;
					setListenersMap(quizObj);
					
					//startQuiz(evt.data.atlas);
					//if (quizStarted) {
						//addNewQuestion(quiz.areaName);
					//}
				}
				catch (e:Error) {
					bottomLine.tf.text = "onMapLoadSucces()" + e.message;
					trace("Geography onMapLoadSucces()",e.message);
				}
			}
			
			function onMapLoadError(evt:Event):void {
				try {
					//bottomLine.tf.text = "onMapLoadError()";
					// если не загружается нужная, то грузим карту уровнем выше
					goUpMap();
				}
				catch (e:Error) {
					bottomLine.tf.text = "onMapLoadError()" + e.message;
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
			!contains(pLoader) ? addChild(pLoader) : null;
		}
		
		private function removePreloader():void {
			pLoader.hidePL();
			contains(pLoader) ? removeChild(pLoader) : null;
		}
		
		private function startQuiz(obj:Object):void {
			try {
				var areaArr:Array = new Array;
				
				for (var i:String in obj) {
					//areaArr.push(i);
					areaArr.push(obj[i].areaName);
				}
				gameMenu.quizOn();
				
				quizStarted = true;
				
				if (quizRes) {
					removeChild(quizRes);
					quizRes.dispose();
					quizRes = null;
				}
				quizRes = new QuizRes();
				quizRes.countFull = areaArr.length;
				addChild(quizRes);
				quizRes.x = stage.stageWidth - quizRes.width;
				
				quizRes.startTimer();
				pointTimer = getTimer();
				pointCounter = 0;
				
				quiz = new Quiz(areaArr);
				
				quiz.addEventListener(Quiz.QUIZ_FINISH,onQuizFinish);
				quiz.addEventListener(Quiz.QUIZ_NEXT_QUESTION,onNextQuestion);
				quiz.nextQuestion();
			}catch (e:Error) { trace("Geography startQuiz()",e.message); }
		}
		
		private function onNextQuestion(evt:Event):void {
			try {
				var aName:String = evt.data.areaName; // area name
				addNewQuestion(aName);
			}
			catch (e:Error) {
				trace("Geography onNextQuestion()",e.message);
			}
		}
		
		private function addNewQuestion(aName:String):void {
			removeChild(question);
			question = null;
			
			// если оставлять спрайт с языками, то нужно сравнение, чтобы ровно по центру.
			//var leftMargin:Number 	= gameMenu.stopBtn.width > gameMenu.langSprite.width 
									//? gameMenu.stopBtn.width : gameMenu.langSprite.width;
			// если языки прячем, то только двойная stopBtn
			var leftMargin:Number 	= gameMenu.stopBtn.width;
									
			var qw:Number = stage.stageWidth - leftMargin * 2; 
			question = new Question(otherTextObj["question_" + lang] + quizObj[aName].transName + "?", qw, qh);
			
			addChild(question);
			question.y = 0;
			question.x = stage.stageWidth / 2 - question.width / 2;
			//swapChildren(question,bottomLine);
			swapChildren(question,gameMenu);
		}
		
		private function onQuizFinish(evt:Event = null):void {
			try {
				//quiz.dispose();
				removeChild(question);
				question.dispose();
				question = null;
				
				quizRes.stopTimer();
				quizStarted = false;
				
				quizRes.initFull();
				quizRes.setPointsTF(pointCounter);
				quizRes.x = (stage.stageWidth - quizRes.width) / 2;
				quizRes.y = (stage.stageHeight - quizRes.height) / 2 - 50;
				
				var q:Quad = new Quad(stage.stageWidth,stage.stageHeight,0x000000);
				addChild(q);
				q.alpha = 0.01;
				q.addEventListener(TouchEvent.TOUCH,onOkRes);
				q.useHandCursor = true;
				
				userObj.allPoints < pointCounter ? userObj.allPoints = pointCounter : null;
				bottomLine.tf.text = "hi, " + userObj.userName + ". You have " + userObj.allPoints + " points";
				
				map.setAreaDef();
				gameMenu.quizOff();
			}
			catch (e:Error) {
				trace("Geography onQuizFinish()",e.message);
			}
			
			function onOkRes(evt:TouchEvent):void {
				try {
					var t:Touch = evt.touches[0];
					
					if (t.phase == TouchPhase.ENDED) {
						removeChild(evt.currentTarget as Quad);
						quizRes.dispose();
						removeChild(quizRes);
					}
				} catch (e:Error) {
					trace("Geography onQuizFinish onOkRes()",e.message);
				}
			}
		}
		
		private function setListenersMap(obj:Object):void {
			try {
				var a:Area;
				for (var i:String in obj) {
					//try {
						a = map.areaSprite.getChildByName(obj[i].areaName) as Area;
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
						trace(getTimer() - pointTimer);
						var timeSpent:int = getTimer() - pointTimer;
						pointTimer += timeSpent;
						
						var areaRight:Area = map.areaSprite.getChildByName(quiz.areaName) as Area;
						var isWrong:Boolean = map.onResponse(area,areaRight);
						
						if (!isWrong) {
							// если потрачено времени больше, чем положено в timeToAnswer,
							// то не даем очков
							if (timeSpent < timeToAnswer) {
								pointCounter += timeToAnswer - timeSpent
							}
							
							quizRes.countCorrect++;
							quizRes.setResTF();
						}
						
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