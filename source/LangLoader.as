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
	
	public class LangLoader extends Sprite {
		
		private var path:String = "";
		private var langObj:Object;
		private var lang:String 	= "en";
		
		function LangLoader() {
			//
		}
				
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
				trace("LangLoader loadLangXML()",e.message);
			}
			
			function loadLangXMLHandler(evt:Event):void {
				try {
					loader.removeEventListener(Event.COMPLETE,loadLangXMLHandler);
					loader.removeEventListener(IOErrorEvent.IO_ERROR, loadLangXMLIOErrorHandler);
					
					//dispatchEvent(new XMLEvent(XMLEvent.XML_LOAD_SUCCESS, XML(loader.data)));
					
					/* */
					langObj = {};

					//var langXML:XML = evt.data;
					var langXML:XML = XML(loader.data);
					var lng:uint = langXML.children().length();
					
					for (var i:uint = 0; i < lng; i++) {
						langObj[langXML.children()[i].attribute("name")] = {
							areaName:	langXML.children()[i].attribute("name"),
							transName:	langXML.children()[i].attribute("title")  // translated name
						}
					}
					
					dispatchEvent(new LangEvent(LangEvent.AREA_NAMES_LOAD_SUCCESS,langObj));
				}
				catch (e:Error) {
					trace("LangLoader loadLanguageXMLHandler()",e.message);
				}
			}
			
			function loadLangXMLIOErrorHandler(evt:IOErrorEvent):void {
				try {
					loader.removeEventListener(Event.COMPLETE,loadLangXMLHandler);
					loader.removeEventListener(IOErrorEvent.IO_ERROR, loadLangXMLIOErrorHandler);	
					
					trace("LangLoader loadLanguageXMLIOErrorHandler()",evt.text);		
					//dispatchEvent(new XMLEvent(XMLEvent.XML_LOAD_ERROR));
					dispatchEvent(new LangEvent(LangEvent.AREA_NAMES_LOAD_ERROR));
				}
				catch (e:Error) {
					trace("LangLoader loadLanguageXMLIOErrorHandler()",e.message,evt.text);
				}
			}
		}
	}
	
}