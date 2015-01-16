package VerticalGameMenu 
{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.display.Quad;
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class UserSprite extends Sprite {
		private static const aHeight:Number	= 150;
		private static const aWidth:Number	= 150;
		
		public var userName:String;
		public var avatar:Image;
		
		public function UserSprite(_userName:String = "",_tAvatar:Texture = null) {
			userName = _userName;
			makeAvatar(_tAvatar);
			
			stage ? init() : addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init():void {
			removeEventListener(Event.ADDED_TO_STAGE,init);
			this.dispose(); 
			
			addAvatar();
			addTF();
		}
		
		// resize and add avatar to middle of default position on sprite
		private function addAvatar():void {
			resizeAvatar();
			this.addChild(avatar);
			avatar.x = (aWidth - avatar.width) >> 1;
			avatar.y = (aHeight - avatar.height) >> 1;
		}
		
		// make a new Image with texture
		private function makeAvatar(_tAvatar:Texture = null):void {
			avatar ? avatar.dispose() : null;
			
			// если есть текстура аватара, то берем ее. Если нет, то создаем заливку серую fromColor(ARGB)
			var tAvatar:Texture = _tAvatar ? _tAvatar : Texture.fromColor(aWidth,aHeight,0xff666666);
			avatar = new Image(tAvatar);
		}
		
		// resize Avatar to aWidth and aHeight
		private function resizeAvatar():void {
			var sc:Number = 1;
			
			if (avatar.width > aWidth || avatar.height > aHeight) {
				if (avatar.width > avatar.height) {
					sc = aWidth / avatar.width;
				}
				else {
					sc = aHeight / avatar.height;
				}
			}
			
			avatar.scaleX = sc;
			avatar.scaleY = sc;
		}
		
		// add TextField with userName
		private function addTF():void {
			var tf:TextField = getChildByName("userTF") as TextField; 
			if (!tf) {
				tf = CustomTF.makeTF(150,46.2,16);
				this.addChild(tf);
			
				tf.name = "userTF";
				tf.x = 0;
				tf.y = 155;
				tf.autoScale = true;
			}
			
			tf.text = userName;
		}
	}
	
}
