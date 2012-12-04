package be.devine.cp3.view.components {
import flashx.textLayout.accessibility.TextAccImpl;

import starling.display.Button;
import starling.display.Sprite;
import starling.textures.Texture;

public class BtnOverview extends Sprite{
    [Embed(source="/assets/images/btn_overview.png")]
    public static const OverviewButtonImage:Class;

    public function BtnOverview()
    {
        var t:Texture = Texture.fromBitmap(new OverviewButtonImage());

        var overviewButton:Button = new Button(t);
        addChild(overviewButton);
    }
}
}
