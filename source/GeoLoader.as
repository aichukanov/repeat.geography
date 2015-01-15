package 
{	
	/**
	 * ...
	 * @author aichukanov
	 */
	
    import flash.display.Sprite;
    import flash.display.Loader;
	
    import flash.events.Event;
    import flash.events.IOErrorEvent;
	
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.display.Bitmap;	
	
	public class GeoLoader extends Sprite {
		
		//private var path:String = "http://repeat.cc/apps/geography/";
		//private var path:String = "apps/geography/";
		//private var path:String = "geography/";
		private var path:String = "";
		
		function GeoLoader() {
			//
		}
		
		// Load XML for Texture Atlas
		public function loadAtlas(str:String):void {
			try {
				var loader:URLLoader 	= new URLLoader();
				var req:URLRequest 	= new URLRequest((path + "atlasxml/" + str + ".xml").toLowerCase());
				
				loader.addEventListener(Event.COMPLETE,loadAtlasHandler);
				loader.addEventListener(IOErrorEvent.IO_ERROR, loadAtlasIOErrorHandler);
				loader.load(req);
			}
			catch (e:Error) {
				trace("GeoLoader loadAtlas()",e.message);
			}
			
			function loadAtlasHandler(evt:Event):void {
				try {
					loader.removeEventListener(Event.COMPLETE,loadAtlasHandler);
					loader.removeEventListener(IOErrorEvent.IO_ERROR, loadAtlasIOErrorHandler);
				
					dispatchEvent(new XMLEvent(XMLEvent.XML_LOAD_SUCCESS,XML(loader.data)));
				}
				catch (e:Error) {
					trace("GeoLoader loadAtlasHandler()",e.message);
				}
			}
			
			function loadAtlasIOErrorHandler(evt:IOErrorEvent):void {
				try {
					loader.removeEventListener(Event.COMPLETE,loadAtlasHandler);
					loader.removeEventListener(IOErrorEvent.IO_ERROR, loadAtlasIOErrorHandler);
					
					trace("GeoLoader loadAtlasIOErrorHandler()",evt.text);
					dispatchEvent(new XMLEvent(XMLEvent.XML_LOAD_ERROR));
				}
				catch (e:Error) {
					trace("GeoLoader loadAtlasIOErrorHandler()",e.message, evt.text);
				}
			}
		}
		
		// Load PNG to Map background
		public function loadMapBg(str:String):void {
			try {
				var loader:Loader	= new Loader();			
				var req:URLRequest	= new URLRequest((path + "maps/" + str + "_bg.png").toLowerCase());
				loader.load(req);
				
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadMapBgHandler);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadMapBgIOErrorHandler);
			}
			catch (e:Error) {
				trace("GeoLoader loadMapBg()",e.message);
			}
			
			function loadMapBgHandler(evt:Event):void {
				try {
					loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadMapBgHandler);
					loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loadMapBgIOErrorHandler);
					
					dispatchEvent(new ImageEvent(ImageEvent.IMAGE_LOAD_SUCCESS,loader.content as Bitmap));
				}
				catch (e:Error) {
					trace("GeoLoader loadMapBgHandler()",e.message);
				}
			}
			
			function loadMapBgIOErrorHandler(evt:IOErrorEvent):void {
				try {
					loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadMapBgHandler);
					loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loadMapBgIOErrorHandler);	
					
					trace("GeoLoader loadMapBgIOErrorHandler()",evt.text);	
					dispatchEvent(new ImageEvent(ImageEvent.IMAGE_LOAD_ERROR));
				}
				catch (e:Error) {
					trace("GeoLoader loadMapBgIOErrorHandler()",e.message,evt.text);
				}
			}
		}
		
		// Load PNG to Map
		public function loadMapPNG(str:String):void {
			try {
				var loader:Loader	= new Loader();			
				var req:URLRequest	= new URLRequest((path + "maps/" + str + ".png").toLowerCase());
				loader.load(req);
				
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadMapPNGHandler);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadMapPNGIOErrorHandler);
			}
			catch (e:Error) {
				trace("GeoLoader loadMapPNG()",e.message);
			}
			
			function loadMapPNGHandler(evt:Event):void {
				try {
					loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadMapPNGHandler);
					loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loadMapPNGIOErrorHandler);
					
					dispatchEvent(new ImageEvent(ImageEvent.IMAGE_LOAD_SUCCESS,loader.content as Bitmap));
				}
				catch (e:Error) {
					trace("GeoLoader loadMapPNGHandler()",e.message);
				}
			}
			
			function loadMapPNGIOErrorHandler(evt:IOErrorEvent):void {
				try {
					loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadMapPNGHandler);
					loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loadMapPNGIOErrorHandler);	
					
					trace("GeoLoader loadMapPNGIOErrorHandler()",evt.text);	
					dispatchEvent(new ImageEvent(ImageEvent.IMAGE_LOAD_ERROR));
				}
				catch (e:Error) {
					trace("GeoLoader loadMapPNGIOErrorHandler()",e.message,evt.text);
				}
			}
		}
		
		// Load XML to Map
		public function loadMapXML(str:String):void {
			try {
				var loader:URLLoader	= new URLLoader();	
				var req:URLRequest	= new URLRequest((path + "maps/" + str + ".xml").toLowerCase());
				loader.load(req);
				loader.addEventListener(Event.COMPLETE,loadMapXMLHandler);
				loader.addEventListener(IOErrorEvent.IO_ERROR, loadMapXMLIOErrorHandler);
			}
			catch (e:Error) {
				trace("GeoLoader loadMapXML()",e.message);
			}
			
			function loadMapXMLHandler(evt:Event):void {
				try {
					loader.removeEventListener(Event.COMPLETE,loadMapXMLHandler);
					loader.removeEventListener(IOErrorEvent.IO_ERROR, loadMapXMLIOErrorHandler);
					
					dispatchEvent(new XMLEvent(XMLEvent.XML_LOAD_SUCCESS, XML(loader.data)));
				}
				catch (e:Error) {
					trace("GeoLoader loadMapXMLHandler()",e.message);
				}
			}
			
			function loadMapXMLIOErrorHandler(evt:IOErrorEvent):void {
				try {
					loader.removeEventListener(Event.COMPLETE,loadMapXMLHandler);
					loader.removeEventListener(IOErrorEvent.IO_ERROR, loadMapXMLIOErrorHandler);	
					
					trace("GeoLoader loadMapXMLIOErrorHandler()",evt.text);		
					dispatchEvent(new XMLEvent(XMLEvent.XML_LOAD_ERROR));
				}
				catch (e:Error) {
					trace("GeoLoader loadMapXMLIOErrorHandler()",e.message,evt.text);
				}
			}
		}
		/*
		// Load XML for localization
		public function loadLangXML(str:String,lang:String):void {
			try {
				var loader:URLLoader	= new URLLoader();	
				var req:URLRequest		= new URLRequest(("language/" + lang + "/" + str + ".xml").toLowerCase());
				loader.load(req);
				loader.addEventListener(Event.COMPLETE,loadLangXMLHandler);
				loader.addEventListener(IOErrorEvent.IO_ERROR, loadLangXMLIOErrorHandler);
			}
			catch (e:Error) {
				trace("GeoLoader loadLangXML()",e.message);
			}
			
			function loadLangXMLHandler(evt:Event):void {
				try {
					loader.removeEventListener(Event.COMPLETE,loadLangXMLHandler);
					loader.removeEventListener(IOErrorEvent.IO_ERROR, loadLangXMLIOErrorHandler);
					
					dispatchEvent(new XMLEvent(XMLEvent.XML_LOAD_SUCCESS, XML(loader.data)));
				}
				catch (e:Error) {
					trace("GeoLoader loadLanguageXMLHandler()",e.message);
				}
			}
			
			function loadLangXMLIOErrorHandler(evt:IOErrorEvent):void {
				try {
					loader.removeEventListener(Event.COMPLETE,loadLangXMLHandler);
					loader.removeEventListener(IOErrorEvent.IO_ERROR, loadLangXMLIOErrorHandler);	
					
					trace("GeoLoader loadLanguageXMLIOErrorHandler()",evt.text);		
					dispatchEvent(new XMLEvent(XMLEvent.XML_LOAD_ERROR));
				}
				catch (e:Error) {
					trace("GeoLoader loadLanguageXMLIOErrorHandler()",e.message,evt.text);
				}
			}
		}
		*/
	}
	
}