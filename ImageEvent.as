package  {
	/**
	 * ...
	 * @author aichukanov
	 */
	
	import flash.events.Event;
	import flash.display.Bitmap;
	
	 public class ImageEvent extends Event {
		
		public static const IMAGE_LOAD_SUCCESS:String	= "imageLoadSuccess";
		public static const IMAGE_LOAD_ERROR:String		= "imageLoadError";
		
        private var _data:Bitmap;
         
       public function ImageEvent(type:String, data:Bitmap = null, bubbles:Boolean = false, cancelable:Boolean = false) {
 			super(type, bubbles, cancelable);
			_data = data;
        }
		
        public function get data():Bitmap {
            return _data;
        }
    }
}
