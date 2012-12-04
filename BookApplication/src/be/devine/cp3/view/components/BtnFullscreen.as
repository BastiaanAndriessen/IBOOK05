package be.devine.cp3.view.components {
import starling.display.Button;
import starling.display.Sprite;
import starling.textures.Texture;

public class BtnFullscreen extends Sprite{
    [Embed(source="/assets/images/btn_fullscreen.png")]
    public static const FullscreenButtonImage:Class;

    public function BtnFullscreen()
    {
        var t:Texture = Texture.fromBitmap(new FullscreenButtonImage());

        var overviewButton:Button = new Button(t);
        addChild(overviewButton);
    }
}
}
