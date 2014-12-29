package 
{
	/**
	 * ...
	 * @author aichukanov
	 */
	
	import flash.display.DisplayObject;
	import starling.textures.Texture;
	
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import flash.geom.Point;
	import flash.geom.ColorTransform;
	import starling.filters.ColorMatrixFilter;
	
	public class Area extends ImageAlpha {
		public static const AREA_SELECTED:String	= "areaSelected";
		
		public static const SELECTED_CORRECT:String	= "selectedCorrect";
		public static const SELECTED_WRONG:String	= "selectedWrong";
		
		public const colorObj:Object = {
			colorWrong:0xFF0000,
			colorWrongHover:0xFF3333,
			colorCorrect:0x00FF00,
			colorCorrectHover:0x66FF66,
			colorDefault:0xFFFFFF,
			colorDefaultHover:0x33FFFF
		}
		
		public var areaName:String 	= "";	// локализованное название области Russia - Россия - Russland
		public var areaColor:uint 	= 0xFFFFFF;
		public var isDefined:Boolean 	= false;
		public var isWrong:Boolean 		= false;
		
		public var hint:Hint;
		public var minY:Number = 50;
		
		public function Area(t:Texture) {
			super(t);
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(evt:Event = null):void {
			//trace("init");
			hint = new Hint(areaName);
			this.addEventListener(TouchEvent.TOUCH, onTouchArea);
		}
		
		public function addHint():void {
			try {
				!stage.contains(hint) ? stage.addChild(hint) : null;
				var globalP:Point = this.localToGlobal( new Point(0,0));
				
				//hint.x = this.x + this.width / 2 - hint.width / 2;
				//hint.y = this.y - hint.height - 10;
				//hint.y < 5 ? hint.y = 5 : null;
				hint.x = globalP.x + this.width / 2 - hint.width / 2;
				hint.y = globalP.y - hint.height - 10;
				hint.y < minY ? hint.y = minY : null;
				
				//hint.setSizes();
			}
			catch (e:Error) {
				trace("Country addHint()",e.message);
			}
		}
		
		public function removeHint():void {
			try {
				stage.contains(hint) ? stage.removeChild(hint) : null;
			}
			catch (e:Error) {
				trace("Country removeHint()",e.message);
			}
		}
		
		private function onTouchArea(evt:TouchEvent):void {
			try {
				var touch:Touch; // = evt.getTouch(this)
				touch = evt.getTouch(evt.currentTarget as Area, TouchPhase.HOVER);
				
				var scN:Number;
				var cX:Number;
				var cY:Number;
								
				if (this.width / this.scaleX <= 20 || this.height / this.scaleX  <= 20) {
					scN = 2;
				}
				else {
					scN = 1.1;
				}
				
				if (this.isDefined) {
					setDefScale(this);
							
					// если уже определена область, то 
					if (touch) {
						// по наведению - подсказку и выделение
						//addHint();
						!isWrong ? setColor(colorObj.colorCorrectHover) : setColor(colorObj.colorWrongHover);
					}
					else {
						// убрал мышку - убрал подсказку, вернул цвет
						//removeHint();
						setColor();
					}
				}
				else {
					// если область неизвестна
					touch = evt.getTouch(evt.currentTarget as Area);
					if (touch) {
						// то по наведению - выделение
						if (touch.phase == TouchPhase.HOVER) {
							setColor(colorObj.colorDefaultHover);
							
							if (this.scaleX != scN) { 
								cX = (this.width * scN) - this.width;
								cY = (this.height * scN) - this.height;
								
								this.scaleX = scN;
								this.scaleY = scN;
								
								this.x -= cX / 2; 
								this.y -= cY / 2; 
								
								this.alpha = 0.4;
							}
						}
						// по CLICK - проверку, правильно ли. dispatchEvent в getAnswer
						touch.phase == TouchPhase.ENDED ? getAnswer() : null;
					}
					else {
						setColor();
						setDefScale(this);							
					}
				}		
			}
			catch (e:Error) {
				trace("Area onTouchCountry()",e.message);
			}
			
			function setDefScale(t):void {
				if (t.scaleX != 1) {
					cX = t.width - (t.width / scN);
					cY = t.height - (t.height / scN);
					
					t.scaleX = 1;
					t.scaleY = 1;
					
					t.x += cX / 2; 
					t.y += cY / 2; 
					
					t.alpha = 1;
				}
			}
		}
		
		public function setAreaColor(color:int = -1):void {
			if (color < 0) {
				color = colorObj.colorDefault;
			}
			
			areaColor = color;
			setColor();
		}
		
		public function setColor(color:int = -1):void {
			if (color < 0) {
				color = areaColor;
			}
			this.color = color;
			//var filterRed:ColorMatrixFilter = new ColorMatrixFilter();
			//filterRed.adjustHue(0.1);
			//this.filter = filterRed;
		}
		
		private function getAnswer():void {
			//dispatchEvent(new AreaEvent(AreaEvent.AREA_SELECTED));
			dispatchEvent(new Event(AREA_SELECTED));
		}
	}
	
}