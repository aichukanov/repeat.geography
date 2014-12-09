﻿package 
{
	/**
	 * ...
	 * @author aichukanov
	 */
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	
	public class Geography extends Sprite 
	{		
		private var map:Map;
		
		private var lang:String = "en";
		
		private var question:Question; 
		private var qh:Number = 40; // questionMC height
		private var bh:Number = 40; // bottom line
		private var margin:Number = 10; // margin top and bottom
		
		private var curLvl:Array = []; //["earth","europe"]
		private var curArea:String = "";
		
		private var quiz:Quiz;
		public var quizPause:Boolean = false;
		
		private var bottomLine:BottomLine;
		private var pLoader:MapPreloader;
		
		public function Geography():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			try {
				removeEventListener(Event.ADDED_TO_STAGE, init);
				
				addBottomLine();
				
				addGameMenu();
			} catch (e:Error) { trace("Geography init()",e.message); }
		}
		
		private function addBottomLine():void {
			try {
				bottomLine = new BottomLine(stage.stageWidth,bh);
				addChild(bottomLine);
				
				bottomLine.x = 0;
				bottomLine.y = stage.stageHeight - bottomLine.height;
			}
			catch (e:Error) {
				trace("Geography addBottomLine()",e.message);
			}
		}
		
		private function addGameMenu():void {
			makePreLoader();
			addMap();
		}
		
		private function addMap():void {
			try {
				addPreloader();
				
				map = new Map();
				
				curLvl = [];
				curArea = "earth";
				
				map.loadMap(curLvl,curArea);
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
					
					startQuiz(evt.data.atlas);
				}
				catch (e:Error) {
					trace("Geography onMapLoadSucces()",e.message);
				}
			}
			
			function onMapLoadError(evt:Event):void {
				trace("map load error geo");
			}
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
					areaArr.push(i);
				}
				
				quiz = new Quiz(areaArr);
				
				quiz.addEventListener(Quiz.QUIZ_FINISH,onQuizFinish);
				quiz.addEventListener(Quiz.QUIZ_NEXT_QUESTION,onNextQuestion);
				quiz.nextQuestion();
				
				setListenersQuiz(obj);
			}catch (e:Error) { trace("Geography startQuiz()",e.message); }
		}
		
		private function onNextQuestion(evt:Event):void {
			var aName:String = evt.data.areaName; // area name
			removeChild(question);
			question = null;
			
			question = new Question("Where is " + aName + "?", stage.stageWidth, qh);
			addChild(question);
			swapChildren(question,bottomLine);
		}
		
		private function onQuizFinish(evt:Event):void {
			removeChild(question);
			question = null;
			
			map.clearMap();
		}
		
		private function setListenersQuiz(obj:Object):void {
			try {
				var a:Area;
				for (var i:String in obj) {
					//try {
						a = map.getChildByName(i) as Area;
						a ? a.addEventListener(Area.AREA_SELECTED, onSelectArea) : null;
					//}catch (e:Error) { trace("Geography setListenersQuiz() for i",i,e.message); }
				}
			}catch (e:Error) { trace("Geography setListenersQuiz()",e.message); }
		}
		
		private function onSelectArea(evt:Event):void {
			try {
				if (!quizPause) {
					var area:Area = evt.currentTarget as Area;
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
			catch (e:Error) { trace("Geography onSelectArea()",e.message); }
		}		
	}
}