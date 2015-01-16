package Quiz
{
	/**
	 * ...
	 * @author aichukanov
	 */
	
	import flash.events.Event;
	
	 public class QuizEvent extends Event {
		
		public static const QUIZ_STARTED:String = "quizStarted";
		public static const QUIZ_NEXT_QUESTION:String = "quizNextQuestion";
		public static const QUIZ_FINISH:String = "quizFinish";
				
		public function QuizEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
 			super(type, bubbles, cancelable);
        }
		
    }
}
