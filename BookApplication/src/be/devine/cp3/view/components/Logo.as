package be.devine.cp3.view.components {
import starling.display.Button;
import starling.display.Sprite;
import starling.textures.Texture;

public class Logo extends Sprite{
    [Embed(source="/assets/images/logo_image.png")]
    public static const LogoButtonImage:Class;

    [Embed(source="/assets/images/logo_text.png")]
    public static const TextButtonImage:Class;

    public function Logo()
    {
        var t:Texture = Texture.fromBitmap(new LogoButtonImage());
        var logoButton:Button = new Button(t);
        addChild(logoButton);

        var t2:Texture = Texture.fromBitmap(new TextButtonImage());
        var textButton:Button = new Button(t2);
        addChild(textButton);
    }
}
}
