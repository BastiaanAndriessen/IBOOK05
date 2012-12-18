package be.devine.cp3.view {
import be.devine.cp3.factory.TextfieldFactory;

import com.greensock.TweenLite;

import flash.display.Bitmap;
import flash.display.Loader;
import flash.events.Event;
import flash.net.URLRequest;

import starling.display.Image;

import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
import starling.textures.Texture;

public class PageView extends Sprite{
    public static const IMAGE_LOADED:String = "Image has successfully been loaded";
    private var _loader:Loader;
    private var _xml:XML;
    private var _imageWidth:uint;

    public function PageView(xml:XML) {
        this._xml = xml;
        this.addEventListener(starling.events.Event.ADDED_TO_STAGE, atsHandler);
    }

    private function atsHandler(e:starling.events.Event):void{
        trace(_xml.backgroundpath);
        _loader = new Loader();
        _loader.load (new URLRequest(_xml.backgroundpath));
        _loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, imageLoadedHandler);
    }

    private function imageLoadedHandler(e:flash.events.Event):void{
        var loadedBitmap:Bitmap = e.currentTarget.content as Bitmap;

        var image:Image = new Image(Texture.fromBitmap(loadedBitmap));
        image.alpha = 0;
        _imageWidth = image.width;
        image.width = 512;

        var scale:Number = image.width/_imageWidth;
        image.height = scale*image.height;

        TweenLite.to(image,.5,{alpha:1});
        addChild(image);

        if(_xml.title.length() > 0){
            var title:TextField = TextfieldFactory.createTitleFromXML(_xml);
            title.x = _xml.title.@x;
            title.y = _xml.title.@y;
            addChild(title);
        }

        if(_xml.subtitle.length() > 0){
            var subtitle:TextField = TextfieldFactory.createSubTitleFromXML(_xml);
            subtitle.x = _xml.subtitle.@x;
            subtitle.y = _xml.subtitle.@y;
            addChild(subtitle);
        }

        if(_xml.h1.length() > 0){
            var h1:TextField = TextfieldFactory.createH1FromXML(_xml);
            h1.x = _xml.h1.@x;
            h1.y = _xml.h1.@y;
            addChild(h1);
        }

        if(_xml.h2.length() > 0){
            var h2:TextField = TextfieldFactory.createH2FromXML(_xml);
            h2.x = _xml.h2.@x;
            h2.y = _xml.h2.@y;
            addChild(h2);
        }

        if(_xml.h3.length() > 0){
            var h3:TextField = TextfieldFactory.createH3FromXML(_xml);
            h3.x = _xml.h3.@x;
            h3.y = _xml.h3.@y;
            addChild(h3);
        }

        if(_xml.paragraph.length() > 0){
            var paragraph:TextField = TextfieldFactory.createParagraphFromXML(_xml);
            paragraph.x = _xml.paragraph.@x;
            paragraph.y = _xml.paragraph.@y;
            addChild(paragraph);
        }

        if(_xml.paragraph2.length() > 0){
            var paragraph2:TextField = TextfieldFactory.createParagraph2FromXML(_xml);
            paragraph2.x = _xml.paragraph2.@x;
            paragraph2.y = _xml.paragraph2.@y;
            addChild(paragraph2);
        }

        if(_xml.paragraph3.length() > 0){
            var paragraph3:TextField = TextfieldFactory.createParagraph3FromXML(_xml);
            paragraph3.x = _xml.paragraph3.@x;
            paragraph3.y = _xml.paragraph3.@y;
            addChild(paragraph3);
        }

        dispatchEvent(new starling.events.Event(IMAGE_LOADED));
    }
}
}
