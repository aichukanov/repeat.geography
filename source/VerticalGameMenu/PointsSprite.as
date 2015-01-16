package VerticalGameMenu 
{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.display.Quad;
	import starling.utils.HAlign;
	
	public class PointsSprite extends Sprite {
		private var textObj:Object = {
			points: "Points",
			total: "Total: 0",
			best: "Best: 0",
			area: "Area: 0"
		}
		
		public function PointsSprite(_textObj:Object = null) {
			_textObj ? textObj = _textObj : null;
			stage ? init() : addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init():void {
			removeEventListener(Event.ADDED_TO_STAGE,init);
			
			addTF(0,0,textObj.points,"CENTER");
			addTF(0,35,textObj.total);
			addTF(0,60,textObj.best);
			addTF(0,100,textObj.area);
			
			addLine(0,30);
			addLine(35,95,80);
			addLine(0,130);
		}
		
		private function addTF(_x:Number,_y:Number,_txt:String,_pos:String = "LEFT"):void {
			try {
				var tf:TextField = CustomTF.makeTF(150,27.75,18);
				this.addChild(tf);
				
				tf.x = _x;
				tf.y = _y;
				tf.autoScale = true;
				tf.hAlign = HAlign[_pos];
				tf.text = _txt; // "Points";
			}
			catch (e:Error) { trace("VerticalGameMenu PointsSprite addTF()",e.message); }
		}
		
		private function addLine(_x:Number, _y:Number, _w:Number = 150):void {
			try {
				var q:Quad = new Quad(_w,2,0xFFFFFF);
				this.addChild(q);
				
				q.x = 0;
				q.y = 30;
			}
			catch (e:Error) { trace("VerticalGameMenu PointsSprite addLine()",e.message); }
		}
	}
	
}
