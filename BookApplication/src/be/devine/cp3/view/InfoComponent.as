package be.devine.cp3.view {
import be.devine.cp3.factory.TextfieldFactory;

import starling.display.Image;
import starling.display.Sprite;
import starling.text.TextField;
import starling.textures.Texture;

public class InfoComponent extends Sprite{
    [Embed(source="/assets/images/gradient.png")]
    public static const Gradient:Class;

    [Embed(source="/assets/helveticaneue.ttf", embedAsCFF="false", fontFamily="HelveticaNeue")]
    private static const HelveticaNeue:Class;

    private var text:Sprite;

    public function InfoComponent() {
        text = new Sprite();

        var gradient:Image = new Image(Texture.fromBitmap(new Gradient()));
        addChild(gradient);

        var titleString:String = "Info";
        var title:TextField = TextfieldFactory.createTitle(titleString);
        title.y = 15;
        text.addChild(title);

        var paragraphString:String = "Go to Overview to walk through all the miniatures."+
        "Click a miniature to get a close look of one of the pages.";
        var paragraph:TextField = TextfieldFactory.createTextfield(paragraphString);
        paragraph.y = title.y + title.height;
        text.addChild(paragraph);

        var paragraphString2:String = "Ik you’re at a page you can click the arrows to go to the previous or next page. You can also use your arrows to navigate through the miniature pages or the big pages.";
        var paragraph2:TextField = TextfieldFactory.createTextfield(paragraphString2);
        paragraph2.y = paragraph.y + paragraph.height + 10;
        text.addChild(paragraph2);

        addChild(text);
        text.x = 15;
    }
}
}
