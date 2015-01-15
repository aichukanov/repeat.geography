package 
{
	/**
	 * ...
	 * @author aichukanov
	 */
	
	import starling.display.Sprite;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.textures.Texture;
	import starling.text.TextField;
	import starling.events.Event;
	
	import flash.filters.GlowFilter;
	
	public class Flag extends Sprite {	 
				
		function Flag(texture:Texture, desc:String = "") {
			super();
			stage ? init() : addEventListener(Event.ADDED_TO_STAGE, init);
			
			function init(evt:Event = null) : void {
				try {
					removeEventListener(Event.ADDED_TO_STAGE, init);
					addFlag(texture,desc);
				}
				catch (e:Error) {
					trace("Flag init()", e.message);
				}
			}
		}
		
		public function addFlag(texture:Texture,desc:String):void {
			var flagSprite:Sprite	= new Sprite();
			var flagImg:Image		= new Image(texture);
			var tf:TextField		= CustomTF.makeTF(50,41,28);
			
			addChild(flagSprite);
			
			flagSprite.addChild(flagImg);
			flagImg.x = 0;
			flagImg.y = 0;
			//flagImg.alpha = 0.8;
			
			var q:Quad = new Quad(flagImg.width, flagImg.height, 0xFFFFFF);
			flagSprite.addChild(q);
			q.alpha = 0.1;
			
			flagSprite.addChild(tf);
			tf.x = 0;
			tf.y = 0;
			tf.autoScale = true;
			tf.text = desc.toUpperCase();
			
			tf.width = flagImg.width;
			
			var glowFilter:GlowFilter = new GlowFilter(0x111111,1,3,3,5,1);
			tf.nativeFilters = [glowFilter,glowFilter];
		}
	}
	
}