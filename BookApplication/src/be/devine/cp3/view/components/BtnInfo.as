package be.devine.cp3.view.components {
import starling.display.Button;
import starling.display.Sprite;
import starling.textures.Texture;

public class BtnInfo extends Sprite{
    [Embed(source="/assets/images/btn_info.png")]
    public static const InfoButtonImage:Class;

    public function BtnInfo()
    {
        var t:Texture = Texture.fromBitmap(new InfoButtonImage());

        var overviewButton:Button = new Button(t);
        addChild(overviewButton);
    }
}
}
