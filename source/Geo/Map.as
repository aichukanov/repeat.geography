package Geo
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
	import flash.display.Bitmap;
	import starling.display.Image;
	import starling.display.Quad;
	
	public class Map extends Sprite {
		public static const RESPONSE_END:String = "responseEnd";
		
		public var toQuestions:uint = 0; // timeout between questions
		
		private var mapLoader:MapLoader = new MapLoader();
		private var atlas:Object 	= {};
		
		public var areaSprite:Sprite = new Sprite();
		
		//private var langObj:Object 	= {};
		
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
					area = areaSprite.getChildByName(i) as Area;
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
		
		//public function loadMap(curLvl:Array, curArea:String):void {
		public function loadMap(fullNameArea:String):void {
			try {
				//var fullNameArea:String = getAddress(curLvl,curArea);
				
				mapLoader.addEventListener(MapEvent.MAP_LOAD_SUCCESS,onMapLoaded);
				mapLoader.addEventListener(MapEvent.MAP_LOAD_ERROR,onMapLoadError);
				//mapLoader.loadMap(fullNameArea,lang);
				mapLoader.loadMap(fullNameArea);
			}
			catch (e:Error) {
				trace("Map loadMap()",e.message);
			}
			
			function onMapLoaded(evt:MapEvent):void {
				try {
					addBG(evt.bg);
					
					atlas = evt.atlas;
					//langObj = evt.langObj;
					addAtlas(atlas, evt.bmp, evt.bmpXML);
					
					//dispatchEventWith(MapEvent.MAP_LOAD_SUCCESS,false,{atlas:evt.atlas, langObj:evt.langObj});
					dispatchEventWith(MapEvent.MAP_LOAD_SUCCESS,false,{atlas:evt.atlas});
				}
				catch (e:Error) {
					trace("Map loadMap onMapLoaded()", e.message);
				}
			}
			
			function onMapLoadError(evt:MapEvent):void {
				try {
					trace("Map onMapLoadError");
					dispatchEvent(new Event(MapEvent.MAP_LOAD_ERROR));
				}
				catch (e:Error) {
					trace("Map loadMap onMapLoadError()", e.message);
				}
			}
		}
		
		private function addAtlas(atlasObj:Object,png:Bitmap,xml):void {
			try {
				var tAtlas:TextureAtlas = makeAtlas(png, XML(xml));
				var area:Area;
				
				if (tAtlas) {
					for (var i:String in atlasObj) {
						try {
							area = new Area(tAtlas.getTexture(i));
							area.name = i;
							area.x = atlasObj[i].x;
							area.y = atlasObj[i].y;
							
							//var cName:String = langObj[i].transName; // локализованное название
							//area.areaName = cName ? cName : i;
							
							areaSprite.addChild(area);
						}
						catch (e:Error) {
							trace("Map addAtlas()", e.message);
						}
					}
					
					addChild(areaSprite);
					areaSprite.x = (this.width - areaSprite.width) / 2;
					areaSprite.y = (this.height - areaSprite.height) / 2;
				}
				else {
					trace("Пустой tAtlas");
				}
			}catch (e:Error) { trace("Map addAtlas()", e.message); }
		}
		
		private function addBG(bmp:Bitmap):void {
			var bg:Image = new Image(Texture.fromBitmap(bmp));
			addChild(bg);
			//var q:Quad = new Quad(1280,650,0x000033);
			//addChild(q);
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
		/*
		private function getAddress(arr:Array,area:String):String {
			var str:String = "";
			try {
				for (var i:uint = 0; i < arr.length; i++) {
					str += arr[i] + "/";
				}
				str.slice(0,str.length-1);
				str += area + "/" + area;
			}catch (e:Error) { trace("Map getAddress()", e.message); }
			return str;
		}
		*/
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
					
					setTimeout(function ():void { 
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
	}
}