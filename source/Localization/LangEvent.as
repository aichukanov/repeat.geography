package  Localization
{
	/**
	 * ...
	 * @author aichukanov
	 */
	
	import flash.events.Event;
	
	 public class LangEvent extends Event {
		public static const SWITCH_LANGUAGE:String = "switchLanguage";
		
		public static const AREA_NAMES_LOAD_SUCCESS:String = "areaNamesLoadSuccess";
		public static const AREA_NAMES_LOAD_ERROR:String = "areaNamesLoadError";
		
		private var _langObj:Object;
		
		public function LangEvent(type:String, langObj:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) {
 			super(type, bubbles, cancelable);
			_langObj 	= langObj;
        }
		
        public function get langObj():Object {
            return _langObj;
        }		
    }
}
