package 
{
  import flash.display.BitmapData;
  import flash.display3D.Context3D;
  import flash.geom.Point;
  import starling.core.RenderSupport;
  import starling.core.Starling;
  import starling.display.Image;
  import starling.display.DisplayObject;
  import starling.textures.Texture;
 
  public class ImageAlpha extends Image
  {
    public function ImageAlpha(t:Texture)
    {
      super(t);
    }
 
    private static var _temp_p:Point = new Point();
    private static var _hit_test_bd:BitmapData = new BitmapData(1, 1, true, 0x0);
    private static var _hit_test_rs:RenderSupport;
    override public function hitTest(localPoint:Point, forTouch:Boolean=false):DisplayObject
    {
      // Basic bounds test first
      if (!getBounds(this).containsPoint(localPoint)) return null;
 
      if (_hit_test_rs==null) _hit_test_rs = new RenderSupport();
      _hit_test_rs.nextFrame();
 
      // The second parameter here, alpha, doesn't seem to do anything...
      // it draws a fully opaque background either way...
      _hit_test_rs.clear(0xf203b4,1);
      var context:Context3D = Starling.current.context;
 
      // The below seems to draw "this" in the parent's coordinate space,
      // so transform localPoint to parent space
      this.localToGlobal(localPoint, _temp_p);
      parent.globalToLocal(_temp_p, _temp_p);
      _hit_test_rs.setOrthographicProjection(_temp_p.x, _temp_p.y,
                                             1,
                                             1);
 
      _hit_test_rs.transformMatrix(this);
      _hit_test_rs.pushMatrix();
      _hit_test_bd.setPixel32(0,0,0);
      this.render(_hit_test_rs, 1.0);
      _hit_test_rs.popMatrix();
      _hit_test_rs.finishQuadBatch();
      context.drawToBitmapData(_hit_test_bd);
 
      // We'd prefer this test, but the above always renders solid backgrounds...
      //if (((_hit_test_bd.getPixel32(0,0) >> 24) & 0xff) > 0x20) {
      if (_hit_test_bd.getPixel32(0,0) != 0xfff203b4) {
        return this;
      } else {
        return null;
      }
    }
  }
}