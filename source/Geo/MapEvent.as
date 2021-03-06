﻿package Geo
{
	/**
	 * ...
	 * @author aichukanov
	 */
	
	import flash.events.Event;
	import flash.display.Bitmap;
	
	 public class MapEvent extends Event {
		
		public static const MAP_LOAD_SUCCESS:String	= "mapLoadSuccess";
		public static const MAP_LOAD_ERROR:String	= "mapLoadError";
		
        private var _atlas:Object;
       // private var _langObj:Object;
		private var _bmp:Bitmap;
		private var _bmpXML:XML;
		private var _bg:Bitmap;
         
		public function MapEvent(type:String, atlas:Object = null, bmp:Bitmap = null, bmpXML:XML = null, bg:Bitmap = null, bubbles:Boolean = false, cancelable:Boolean = false) {
 			super(type, bubbles, cancelable);
			_atlas	= atlas;
			_bmp	= bmp;
			_bg 	= bg;
			_bmpXML = bmpXML;
        }
		
        public function get atlas():Object {
            return _atlas;
        }
		/*
        public function get langObj():Object {
            return _langObj;
        }
		*/
		public function get bmp():Bitmap {
			return _bmp;
		}
		
		public function get bmpXML():XML {
			return _bmpXML;
		}
		
		public function get bg():Bitmap {
			return _bg;
		}
		
    }
}
