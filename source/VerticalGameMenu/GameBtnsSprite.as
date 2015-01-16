package VerticalGameMenu 
{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class GameBtnsSprite extends Sprite {
		private var textObj:Object = {
			pressToStop: "Press to stop:",
			pressToStart: "Press to start:",

			study: "STUDY",
			challenge: "CHALLENGE",
			stop: "STOP"
		}
		
		public var startBtn:MenuButton;
		public var studyBtn:MenuButton;
		public var stopBtn:MenuButton;
		
		public function GameBtnsSprite(_textObj:Object = null) {
			_textObj ? textObj = _textObj : null;
			stage ? init() : addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init():void {
			removeEventListener(Event.ADDED_TO_STAGE,init);
			
			var tf:TextField = CustomTF.makeTF(150,26,16, "LEFT");
			this.addChild(tf);
			tf.name = "tf";
			tf.x = 0;
			tf.y = 0;
			tf.autoScale = true;
			
			tf.text = textObj.pressToStart; // "Press to start:";
			
			studyBtn = new MenuButton(textObj.study); // "STUDY"
			this.addChild(studyBtn);
			studyBtn.x = 0;
			studyBtn.y = 25;
			
			startBtn = new MenuButton(textObj.challenge); // "CHALLENGE"
			this.addChild(startBtn);
			startBtn.x = 0;
			startBtn.y = 65;
			
			stopBtn = new MenuButton(textObj.stop); // "STOP");
			stopBtn.x = 0;
			stopBtn.y = 25;
		}
		
		public function quizOn():void {
			(this.getChildByName("tf") as TextField).text = textObj.pressToStop; //"Press to stop:"
			this.removeChild(studyBtn);
			this.removeChild(startBtn);
			this.addChild(stopBtn);
		}
		
		public function quizOff():void {
			(this.getChildByName("tf") as TextField).text = textObj.pressToStart; //"Press to start:";
			
			this.removeChild(stopBtn);
			this.addChild(studyBtn);
			this.addChild(startBtn);
		}
	}
	
}
