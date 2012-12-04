package be.devine.cp3.view.components {
import starling.display.Image;
import starling.display.Sprite;
import starling.textures.Texture;

public class Pattern extends Sprite{
    [Embed(source="/assets/pattern.png")]
    public static const PatternImage:Class;

    public function Pattern()
    {
        var t:Texture = Texture.fromBitmap(new PatternImage());

        var pattern:Image = new Image(t);
        addChild(pattern);
    }
}
}
