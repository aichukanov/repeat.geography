package  {
	/**
	 * ...
	 * @author aichukanov
	 */
	
	import flash.display.Sprite;
	
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import starling.core.Starling;
	import flash.geom.Rectangle;
	import flash.events.Event;
	import starling.events.ResizeEvent;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	
	public class Startup extends Sprite {
		private var mStarling:Starling;
		
		public function Startup() {	
			stage ? init() : addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init(evt:Event = null):void {
			try {
				Starling.handleLostContext = true;
				
				stage.align = StageAlign.TOP_LEFT;
				stage.scaleMode = StageScaleMode.NO_SCALE;
				
				mStarling = new Starling(Geography,stage);
				mStarling.antiAliasing = 1;
				//mStarling.simulateMultitouch = true;
				
				mStarling.start();
				
				stage.addEventListener(ResizeEvent.RESIZE, resizeStage);
			}
			catch (e:Error) {
				trace("Startup init()",e.message);
			}
		}
		
		private function resizeStage(evt:Event):void {
			var newViewPort:Rectangle = new Rectangle(0,0,stage.stageWidth, stage.stageHeight);
			mStarling.viewPort = RectangleUtil.fit(mStarling.viewPort, newViewPort, ScaleMode.SHOW_ALL);
		}
	}
	
}
