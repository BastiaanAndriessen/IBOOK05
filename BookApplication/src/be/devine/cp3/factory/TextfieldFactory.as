package be.devine.cp3.factory {
import starling.text.TextField;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class TextfieldFactory {
    [Embed(source="/assets/helveticaneue.ttf", embedAsCFF="false", fontFamily="HelveticaNeue")]
    private static const HelveticaNeue:Class;

    [Embed(source="/assets/avenirblack.ttf", embedAsCFF="false", fontFamily="AvenirBlack")]
    private static const AvenirBlack:Class;

    public static function createTitle(text:String):TextField{
        var titel:TextField = new TextField(450, 52, text, "HelveticaNeue",27,0x0a3465);
        titel.hAlign = HAlign.LEFT;
        titel.vAlign = VAlign.TOP;
        return titel;
    }

    public static function createTextfield(text:String, height:uint):TextField{
        var paragraph:TextField = new TextField(475, height, text, "HelveticaNeue",15,0x0a3465);
        paragraph.hAlign = HAlign.LEFT;
        paragraph.vAlign = VAlign.TOP;
        return paragraph;
    }

    public static function createPageCountTextfield(text:String):TextField{
        var pageCountTextfield:TextField = new TextField(200, 40, text, "HelveticaNeue",25,0x0a3465);
        pageCountTextfield.hAlign = HAlign.CENTER;
        pageCountTextfield.vAlign = VAlign.CENTER;
        return pageCountTextfield;
    }

    public static function createTitleFromXML(data:XML):TextField{
        var title:TextField = new TextField(data.title.@width, data.title.@height, data.title, "AvenirBlack", 64);
        title.bold = true;
        title.autoScale = true;
        if(data.alignment == "left"){
            title.hAlign = HAlign.LEFT;
        } else if(data.alignment == "right"){
            title.hAlign = HAlign.RIGHT;
        }
        title.vAlign = VAlign.TOP;
        return title;
    }

    public static function createH1FromXML(data:XML):TextField{
        var h1:TextField = new TextField(data.h1.@width, data.h1.@height, data.h1, "AvenirBlack", 20);
        h1.bold = true;
        h1.autoScale = true;
        if(data.alignment == "left"){
            h1.hAlign = HAlign.LEFT;
        } else if(data.alignment == "right"){
            h1.hAlign = HAlign.RIGHT;
        }
        h1.vAlign = VAlign.TOP;
        return h1;
    }

    public static function createH2FromXML(data:XML):TextField{
        var h2:TextField = new TextField(data.h2.@width, data.h2.@height, data.h2, "AvenirBlack", 16);
        h2.bold = true;
        h2.autoScale = true;
        if(data.alignment == "left"){
            h2.hAlign = HAlign.LEFT;
        } else if(data.alignment == "right"){
            h2.hAlign = HAlign.RIGHT;
        }
        h2.vAlign = VAlign.TOP;
        return h2;
    }

    public static function createH3FromXML(data:XML):TextField{
        var h3:TextField = new TextField(data.h3.@width, data.h3.@height, data.h3, "AvenirBlack", 10);
        h3.bold = true;
        h3.autoScale = true;
        if(data.alignment == "left"){
            h3.hAlign = HAlign.LEFT;
        } else if(data.alignment == "right"){
            h3.hAlign = HAlign.RIGHT;
        }
        h3.vAlign = VAlign.TOP;
        return h3;
    }

    public static function createSubTitleFromXML(data:XML):TextField{
        var subtitle:TextField = new TextField(data.subtitle.@width, data.subtitle.@height, data.subtitle, "HelveticaNeue", 13);
        subtitle.bold = false;
        subtitle.autoScale = true;
        if(data.alignment == "left"){
            subtitle.hAlign = HAlign.LEFT;
        } else if(data.alignment == "right"){
            subtitle.hAlign = HAlign.RIGHT;
        }
        subtitle.vAlign = VAlign.TOP;
        return subtitle;
    }

    public static function createParagraphFromXML(data:XML):TextField{
        var paragraph:TextField = new TextField(data.paragraph.@width, data.paragraph.@height, data.paragraph, "HelveticaNeue", 9);
        paragraph.bold = false;
        paragraph.autoScale = true;
        if(data.alignment == "left"){
            paragraph.hAlign = HAlign.LEFT;
        } else if(data.alignment == "right"){
            paragraph.hAlign = HAlign.RIGHT;
        }
        paragraph.vAlign = VAlign.TOP;
        return paragraph;
    }

    public static function createParagraph2FromXML(data:XML):TextField{
        var paragraph:TextField = new TextField(data.paragraph2.@width, data.paragraph2.@height, data.paragraph2, "HelveticaNeue", 9);
        paragraph.bold = false;
        paragraph.autoScale = true;
        if(data.alignment == "left"){
            paragraph.hAlign = HAlign.LEFT;
        } else if(data.alignment == "right"){
            paragraph.hAlign = HAlign.RIGHT;
        }
        paragraph.vAlign = VAlign.TOP;
        return paragraph;
    }

    public static function createParagraph3FromXML(data:XML):TextField{
        var paragraph:TextField = new TextField(data.paragraph3.@width, data.paragraph3.@height, data.paragraph3, "HelveticaNeue", 9);
        paragraph.bold = false;
        paragraph.autoScale = true;
        if(data.alignment == "left"){
            paragraph.hAlign = HAlign.LEFT;
        } else if(data.alignment == "right"){
            paragraph.hAlign = HAlign.RIGHT;
        }
        paragraph.vAlign = VAlign.TOP;
        return paragraph;
    }
}
}
