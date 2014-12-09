package  {
	import starling.display.Sprite;
	import starling.events.Event;

	/**
	 * ...
	 * @author aichukanov
	 */
	
	public class Quiz extends Sprite{
		
		public static const QUIZ_STARTED:String = "quizStarted";
		public static const QUIZ_NEXT_QUESTION:String = "quizNextQuestion";
		public static const QUIZ_FINISH:String = "quizFinish";
		
		public var areaArr:Array;
		public var areaName:String;
		
		
		public function Quiz(arr:Array) {
			areaArr = arr.slice();
		}
				
		public function nextQuestion():void {
			if (areaArr.length > 0) {
				var rnd:uint = Math.round(Math.random() * (areaArr.length - 1));
				areaName = areaArr.splice(rnd,1);
				
				dispatchEventWith(QUIZ_NEXT_QUESTION,false,{areaName: areaName});
			}
			else {
				dispatchEvent(new Event(QUIZ_FINISH));
			}
		}
		
		public function delArea(str:String):void {
			var lng:uint = areaArr.length;
			for (var i:uint = 0; i < lng; i++) {
				if (areaArr[i] == str) {
					areaArr.splice(i,1);
					break;
				}
			}
		}
		
	}
	
}
