package 
{
	/**
	 * ...
	 * @author aichukanov
	 */
	 
	import starling.display.Sprite;
	import starling.events.Event;
	
	import starling.textures.TextureAtlas;
	import starling.textures.Texture;
	import flash.utils.setTimeout;
	 
	public class Map extends Sprite {
		public static const RESPONSE_END:String = "responseEnd";
		
		public var toQuestions:uint = 0; // timeout between questions
		
		private var mapLoader:MapLoader = new MapLoader();
		private var atlas:Object = {};
		
		private var langObj:Object = {};
		
		function Map() {
			super();
			stage ? init() : addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(evt:Event = null) : void {
			try {
				removeEventListener(Event.ADDED_TO_STAGE, init);
			}
			catch (e:Error) {
				trace("Map init()", e.message);
			}
		}
		
		public function setAreaDef():void {
			var area:Area;
			
			for (var i:String in atlas) {
				try {
					area = getChildByName(i) as Area;
					if (area) {
						area.setAreaColor(area.colorObj.colorDefault);
						area.isDefined	= false;
						area.isWrong 	= false;
					}
				}
				catch (e:Error) {
					trace("Map setAreaDef()",e.message);
				}
			}
		}
		
		public function clearMap():void {
			setAreaDef();
			this.dispose();
		}
		
		public function loadMap(curLvl:Array, curArea:String, lang:String = "en"):void {
			try {
				var fullNameArea:String = getAddress(curLvl,curArea);
					
				mapLoader.loadMap(fullNameArea,lang);
				
				mapLoader.addEventListener(MapEvent.MAP_LOAD_SUCCESS,onMapLoaded);
				mapLoader.addEventListener(MapEvent.MAP_LOAD_ERROR,onMapLoadError);
			}
			catch (e:Error) {
				trace("Map loadMap()",e.message);
			}
			
			function onMapLoaded(evt:MapEvent):void {
				try {
					atlas = evt.atlas;
					langObj = evt.langObj;
					addAtlas(atlas, evt.bmp, evt.bmpXML);	
					//startQuiz(evt.atlas);
					//dispatchEvent(new Event(MapEvent.MAP_LOAD_SUCCESS));
					dispatchEventWith(MapEvent.MAP_LOAD_SUCCESS,false,{atlas: evt.atlas, langObj: evt.langObj});
				}
				catch (e:Error) {
					trace("Map loadMap onMapLoaded()",e.message);
				}
			}
			
			function onMapLoadError(evt:MapEvent):void {
				try {
					trace("Map onMapLoadError");
					dispatchEvent(new Event(MapEvent.MAP_LOAD_ERROR));
				}
				catch (e:Error) {
					trace("Map loadMap onMapLoadError()",e.message);
				}
			}
		}
		
		private function addAtlas(atlasObj:Object,png,xml):void {
			try {
				var tAtlas:TextureAtlas = makeAtlas(png, XML(xml));
				//euAtlas = makeAtlas(png, XML(xml));
				var area:Area;
				
				if (tAtlas) {
					for (var i:String in atlasObj) {
						try {
							//countryImage = new Image(euAtlas.getTexture(EUROPE_COUNTRIES[i].name_en));
							area = new Area(tAtlas.getTexture(i));
							area.name = i;
							area.x = atlasObj[i].x;
							area.y = atlasObj[i].y;
							
							// сюда локализации прикрутить
							// atlasObj заменить на langObj
							//var cName:String = atlasObj[i]["name_" + lang]; 
							//var cName:String = i;
							var cName:String = langObj[i].transName; 
							area.areaName = cName ? cName : i;
							//area.areaName = cName ? cName : atlasObj[i].name_en;
							
							//countryImage.color = Math.random() * 0xFFFFFF;
							
							this.addChild(area);
							//atlasImage.addEventListener(TouchEvent.TOUCH, onTouchArea);
						}
						catch (e:Error) {
							trace("Map addAtlas()", e.message);
						}
					}
				}
				else {
					trace("Пустой tAtlas");
				}
			}catch (e:Error) { trace("Map addAtlas()",e.message); }
		}
		
		private function makeAtlas(bmp, xml):TextureAtlas {
			try {
				var texture:Texture = Texture.fromBitmap(bmp);
				var tAtlas:TextureAtlas = new TextureAtlas(texture, xml);
			}
			catch (e:Error) {
				trace("Map makeAtlas()", e.message);
				return null;
			}
			finally {
				return tAtlas;
			}
		}
		
		private function getAddress(arr:Array,area:String):String {
			var str:String = "";
			try {
				for (var i:uint = 0; i < arr.length; i++) {
					str += arr[i] + "/";
				}
				str.slice(0,str.length-1);
				str += area + "/" + area;
			}catch (e:Error) { trace("Map getAddress()",e.message); }
			return str;
		}
		
		public function onResponse(area:Area, areaRight:Area):Boolean {
			var isWrong:Boolean = false;
			
			try {
				if (area && areaRight) {
					isWrong = area.name != areaRight.name;
					if (isWrong) {
						area.isDefined = true;
						area.isWrong = true;
						area.setAreaColor(area.colorObj.colorWrong);
					}
					
					areaRight.isDefined = true;
					areaRight.isWrong = false;
					areaRight.setAreaColor(area.colorObj.colorCorrect);
					areaRight.addHint();
					
					setTimeout(function () { 
						try {
							areaRight.removeHint();
							
							if (isWrong) {
								area.isDefined = false;
								area.isWrong = false;
								area.setAreaColor(area.colorObj.colorDefault);
							}
							
							dispatchEvent(new Event(RESPONSE_END));
							
						} catch (e:Error) {
							trace("Map onResponse() timeout",e.message);
						}
					},toQuestions,area,areaRight,isWrong);
				}				
			}
			catch (e:Error) { trace("Map onResponse()",e.message); }
			
			return isWrong;
		}
		
		/*		
		// по нажатию - открыть глубже (страны - области - районы)
		public function setListenersExpand(obj:Object):void {
			try {
				var a:Area;
				for (var i:String in obj) {
					a = this.getChildByName(i) as Area;
					//a.addEventListener(TouchEvent.TOUCH, onTouchArea);
					//a.addEventListener(AreaEvent.AREA_SELECTED, onExpandArea);
					a.addEventListener(Area.AREA_SELECTED, onExpandArea);
				}
			}catch (e:Error) { trace("Geography setListenersExpand()",e.message); }
		}
		
		//private function onExpandArea(evt:AreaEvent):void {
		private function onExpandArea(evt:Event):void {
			var area:Area = evt.currentTarget as Area;
			trace("expand",area.name);
		}
		*/
	}
	
}