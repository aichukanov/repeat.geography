package VerticalGameMenu 
{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class MapBtnsSprite extends Sprite {
		private var textObj:Object = {
			regionUp: "REGION UP",
			toChangeRegion: "To change the region select one on the map or press:"
		}
		
		public var upBtn:MenuButton;
		
		public function MapBtnsSprite(_textObj:Object = null) {
			_textObj ? textObj = _textObj : null;
			stage ? init() : addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init():void {
			removeEventListener(Event.ADDED_TO_STAGE,init);
			
			var tf:TextField = CustomTF.makeTF(150,70,16, "LEFT");
			this.addChild(tf);
			tf.x = 0;
			tf.y = 0;
			tf.autoScale = true;
			tf.text = textObj.toChangeRegion; // "To change the region select one on the map or press:";
			
			upBtn = new MenuButton(textObj.regionUp); // "REGION UP"
			this.addChild(upBtn);
			upBtn.x = 0;
			upBtn.y = 70;
		}
	}
	
}
