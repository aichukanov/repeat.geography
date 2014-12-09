package  {
	/**
	 * ...
	 * @author aichukanov
	 */
	 
	import flash.display.Sprite;
	import flash.display.Bitmap;
	
	public class MapLoader extends Sprite {

		private var geoLoader:GeoLoader = new GeoLoader();
		
		private var nameArea:String = "";
		
		private var atlas:Object;
		private var bmp:Bitmap;
		private var bmpXML:XML;
		
		public function MapLoader() {
			// constructor code
		}
		
		public function loadMap(fullNameArea:String):void {
			try {
				nameArea = fullNameArea;
				
				geoLoader.loadAtlas(fullNameArea);
				geoLoader.addEventListener(XMLEvent.XML_LOAD_SUCCESS,onLoadAtlas);
				geoLoader.addEventListener(XMLEvent.XML_LOAD_ERROR,onLoadAtlasError);
			}
			catch (e:Error) {
				trace("MapLoader loadMap()",e.message);
			}
		}
		
		private function onLoadAtlas(evt:XMLEvent):void {
			try {
				geoLoader.removeEventListener(XMLEvent.XML_LOAD_SUCCESS,onLoadAtlas);
				geoLoader.removeEventListener(XMLEvent.XML_LOAD_ERROR,onLoadAtlasError);
				
				atlas = {};
				
				var atlasXML:XML = evt.data;
				var lng:uint = atlasXML.children().length();
				
				for (var i:uint = 0; i < lng; i++) {
					atlas[atlasXML.children()[i].attribute("name")] = {
						x: atlasXML.children()[i].attribute("x"),
						y: atlasXML.children()[i].attribute("y")};
				}
							
				geoLoader.loadMapXML(nameArea);
				geoLoader.addEventListener(XMLEvent.XML_LOAD_SUCCESS,onLoadMapXML);
				geoLoader.addEventListener(XMLEvent.XML_LOAD_ERROR,onLoadMapXMLError);
			}
			catch (e:Error) {
				trace("MapLoader onLoadAtlas()",e.message);
			}
		}
		
		private function onLoadMapXML(evt:XMLEvent):void {
			try {
				geoLoader.removeEventListener(XMLEvent.XML_LOAD_SUCCESS,onLoadMapXML);
				geoLoader.removeEventListener(XMLEvent.XML_LOAD_ERROR,onLoadMapXMLError);
				
				bmpXML = evt.data;
				
				geoLoader.loadMapPNG(nameArea);
				geoLoader.addEventListener(ImageEvent.IMAGE_LOAD_SUCCESS,onLoadMapPNG);
				geoLoader.addEventListener(ImageEvent.IMAGE_LOAD_ERROR,onLoadMapPNGError);
			}
			catch (e:Error) {
				trace("MapLoader onLoadMapXML()",e.message);
			}
		}
		
		private function onLoadMapPNG(evt:ImageEvent):void {
			try {
				geoLoader.removeEventListener(ImageEvent.IMAGE_LOAD_SUCCESS,onLoadMapPNG);
				geoLoader.removeEventListener(ImageEvent.IMAGE_LOAD_ERROR,onLoadMapPNGError);
				
				bmp = evt.data;
				
				dispatchEvent(new MapEvent(MapEvent.MAP_LOAD_SUCCESS, atlas, bmp, bmpXML));
			}
			catch (e:Error) {
				trace("MapLoader onLoadMapPNG()",e.message);
			}
		}
		
		private function onLoadAtlasError(evt:XMLEvent):void {
			try {
				geoLoader.removeEventListener(XMLEvent.XML_LOAD_SUCCESS,onLoadAtlas);
				geoLoader.removeEventListener(XMLEvent.XML_LOAD_ERROR,onLoadAtlasError);
				trace("MapLoader onLoadAtlasError()");
			}
			catch (e:Error) {
				trace("MapLoader onLoadAtlasError()",e.message);
			}
		}
		
		private function onLoadMapXMLError(evt:XMLEvent):void {
			try {
				geoLoader.removeEventListener(XMLEvent.XML_LOAD_SUCCESS,onLoadMapXML);
				geoLoader.removeEventListener(XMLEvent.XML_LOAD_ERROR,onLoadMapXMLError);
				trace("MapLoader onLoadMapXMLError()");
			}
			catch (e:Error) {
				trace("MapLoader onLoadMapXMLError()",e.message);
			}
		}
		
		private function onLoadMapPNGError(evt:ImageEvent):void {
			try {
				geoLoader.removeEventListener(ImageEvent.IMAGE_LOAD_SUCCESS,onLoadMapPNG);
				geoLoader.removeEventListener(ImageEvent.IMAGE_LOAD_ERROR,onLoadMapPNGError);
				trace("MapLoader onLoadMapPNGError()");
			}
			catch (e:Error) {
				trace("MapLoader onLoadMapPNGError()",e.message);
			}
		}		
	}
}
