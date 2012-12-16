package be.devine.cp3.factory {
import starling.text.TextField;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class TextfieldFactory {
    [Embed(source="/assets/helveticaneue.ttf", embedAsCFF="false", fontFamily="HelveticaNeue")]
    private static const HelveticaNeue:Class;

    public static function createTitle(text:String):TextField{
        var titel:TextField = new TextField(450, 52, text, "HelveticaNeue",27,0x0a3465);
        titel.hAlign = HAlign.LEFT;
        titel.vAlign = VAlign.TOP;
        return titel;
    }

    public static function createTextfield(text:String):TextField{
        var paragraph:TextField = new TextField(475, 40, text, "HelveticaNeue",15,0x0a3465);
        paragraph.hAlign = HAlign.LEFT;
        paragraph.vAlign = VAlign.TOP;
        return paragraph;
    }
}
}
