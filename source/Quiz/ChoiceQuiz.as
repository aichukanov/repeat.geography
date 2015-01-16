package Quiz
{
	import starling.display.Sprite;
	import starling.events.Event;

	/**
	 * ...
	 * @author aichukanov
	 */
	
	public class ChoiceQuiz extends Sprite {
		
		public var answer:String;	// текущий ответ
		private var arr:Array;  	// массив ответов
		
		public function ChoiceQuiz(_arr:Array) {
			arr = _arr.slice();
		}
				
		public function nextQuestion():void {
			if (arr.length > 0) {
				var rnd:uint = Math.round(Math.random() * (arr.length - 1));
				answer = arr.splice(rnd,1);
				dispatchEvent(new Event(QuizEvent.QUIZ_NEXT_QUESTION));
				//dispatchEventWith(QuizEvent.QUIZ_NEXT_QUESTION,false,{answer: answer});
			}
			else {
				dispatchEvent(new Event(QuizEvent.QUIZ_FINISH));
			}
		}
		
		public function delArea(str:String):void {
			var lng:uint = arr.length;
			for (var i:uint = 0; i < lng; i++) {
				if (arr[i] == str) {
					arr.splice(i,1);
					break;
				}
			}
		}
		
	}
	
}
