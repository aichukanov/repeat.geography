package  {
	/**
	 * ...
	 * @author aichukanov
	 */
	
	import flash.events.Event;
	
	 public class XMLEvent extends flash.events.Event {
		
		public static const XML_LOAD_SUCCESS:String	= "xmlLoadSuccess";
		public static const XML_LOAD_ERROR:String	= "xmlLoadError";
		
        private var _data:XML;
         
		public function XMLEvent(type:String, data:XML = null, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_data = data;
		}
		
		public function get data():XML {
			return _data;
		}
	}
}
