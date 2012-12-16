package be.devine.cp3.view {
import be.devine.cp3.factory.TextfieldFactory;

import starling.display.Image;
import starling.display.Sprite;
import starling.text.TextField;
import starling.textures.Texture;

public class HomeComponent extends Sprite{
    [Embed(source="/assets/images/gradient.png")]
    public static const Gradient:Class;

    [Embed(source="/assets/helveticaneue.ttf", embedAsCFF="false", fontFamily="HelveticaNeue")]
    private static const HelveticaNeue:Class;

    private var text:Sprite;

    public function HomeComponent() {
        text = new Sprite();

        var gradient:Image = new Image(Texture.fromBitmap(new Gradient()));
        addChild(gradient);

        var titleString:String = "Welcome to the Designers Pub™";
        var title:TextField = TextfieldFactory.createTitle(titleString);
        title.y = 15;
        text.addChild(title);

        var paragraphString:String = "The Designers Pub is the place to be for all designers trying to find some inspiration for their next extraordinary design.";
        var paragraph:TextField = TextfieldFactory.createTextfield(paragraphString);
        paragraph.y = title.y + title.height;
        text.addChild(paragraph);

        var paragraphString2:String = "The Designers Pub is an  application where you can read and gather some inspiration from the Veer Visual Elements Catalog.";
        var paragraph2:TextField = TextfieldFactory.createTextfield(paragraphString2);
        paragraph2.y = paragraph.y + paragraph.height + 10;
        text.addChild(paragraph2);

        var paragraphString3:String = "Find out how the application works under info and enjoy your visit.";
        var paragraph3:TextField = TextfieldFactory.createTextfield(paragraphString3);
        paragraph3.y = paragraph2.y + paragraph2.height + 10;
        text.addChild(paragraph3);

        addChild(text);
        text.x = 15;
    }
}
}
