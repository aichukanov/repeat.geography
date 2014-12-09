package  {
	
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	
	
	public class GeographyPreloader extends MovieClip {
		
		private var path:String = "";
		private var gameName:String = "Geography";
		
		private var pl:PL = new PL();
		
		public function GeographyPreloader() {
			addPL();
			loadGame(gameName);
		}
		
		private function addPL():void {
			pl.x = 340;
			pl.y = 250;
			addChild(pl);
		}
		
		private function loadGame(gName:String):void {
			var str:String = path + gName + ".swf";
			var loader:Loader = new Loader();
			var req:URLRequest = new URLRequest(str);
			trace(str);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			
			loader.load(req);
		
			function loadComplete(evt:Event):void {
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadComplete);
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
				loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);
				trace("load complete");
				
				removeChild(pl);
				addChild(loader.content);
			}
			
			function onProgress(evt:ProgressEvent):void {
				var percent:Number = Math.round(evt.bytesLoaded * 100 / evt.bytesTotal);
				
				pl.progressBar.mask.scaleX = evt.bytesLoaded / evt.bytesTotal;
				pl.progressTF.text = percent.toString() + "%";
			}
			
			function ioError(evt:IOErrorEvent):void {
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadComplete);
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
				loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);
				trace("ioError");
				pl.progressTF.text = "IO Error";
			}
		}
	}
	
}
