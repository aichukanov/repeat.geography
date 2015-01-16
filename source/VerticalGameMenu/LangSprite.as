package VerticalGameMenu 
{
	/**
	 * ...
	 * @author aichukanov
	 */
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.display.Image;
	import starling.textures.Texture;
	
	import Localization.*;
	
	public class LangSprite extends Sprite {	
		
	 	[Embed(source = "../../media/flags/lang.png")]
		private static const LangPNG:Class;
		
		public var curLang:String;
		public var langPanel:LangPanel;
		
		private var curFlag:Flag;
		
		function LangSprite(_lang:String = "en") {
			super();
			curLang = _lang;
			stage ? init() : addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(evt:Event = null) : void {
			try {
				removeEventListener(Event.ADDED_TO_STAGE, init);
				var tf:TextField;
			
				langPanel = new LangPanel();
				langPanel.addEventListener(LangEvent.SWITCH_LANGUAGE,switchLanguage);
				
				this.addChild(langPanel);
				langPanel.x = 130;
				langPanel.y = 0;
				
				var img:Image = new Image(Texture.fromBitmap(new LangPNG()));
				this.addChild(img);
				img.x = 5;
				img.y = 10;
				
				setCurFlag();
			}
			catch (e:Error) {
				trace("LangSprite init()", e.message);
			}
		}
		
		private function setCurFlag():void {
			if (curFlag) {
				this.removeChild(curFlag);
				curFlag.dispose();
				curFlag = null;
			}
			
			curFlag = new Flag(langPanel.flagAtlas.getTexture(curLang),curLang);
			curFlag.x = 55;
			curFlag.y = 10;
			this.addChild(curFlag);
		}
		
		private function switchLanguage(evt:Event):void {
			curLang = evt.data.newLang;
			setCurFlag();
			dispatchEventWith(LangEvent.SWITCH_LANGUAGE,false,evt.data);
		}
	}
}