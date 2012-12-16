package be.devine.cp3.vo {
import com.greensock.TweenLite;

import flash.display.Bitmap;
import flash.display.Loader;
import flash.events.Event;
import flash.net.URLRequest;

import starling.display.Image;
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

import starling.textures.Texture;

import flash.ui.Mouse;
import flash.ui.MouseCursor;

public class MiniatureVO extends Sprite{
    public static const IMAGE_LOADED:String = "Image has successfully been loaded.";
    private var _loader:Loader;

    private var _posX:uint;
    private var _posY:uint;
    private var _overlay:Quad;

    public function MiniatureVO(page:XML, posX:uint,  posY:uint) {
        _loader = new Loader();
        _loader.load (new URLRequest(page.miniaturepath));
        _loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, imageLoadedHandler);

        _posX = posX;
        _posY = posY;
    }

    private function imageLoadedHandler(event:flash.events.Event):void
    {
        var loadedBitmap:Bitmap = event.currentTarget.content as Bitmap;

        var image:Image = new Image(Texture.fromBitmap(loadedBitmap));
        addChild(image);

        this.x = _posX;
        this.y = _posY;
        dispatchEvent(new starling.events.Event(IMAGE_LOADED));

        _overlay = new Quad(this.width,  this.height, 0x1f4671);
        _overlay.alpha = .5;
        addChild(_overlay);

        this.addEventListener(TouchEvent.TOUCH, onTouchHandler);
    }

    private function onTouchHandler(e:TouchEvent):void{
        if(e.getTouch(this, TouchPhase.HOVER)){
            Mouse.cursor = MouseCursor.BUTTON;
            TweenLite.to(_overlay, 1, {alpha:0});
        } else {
            Mouse.cursor = MouseCursor.ARROW;
            TweenLite.to(_overlay, 1, {alpha:.5});
        }
    }
}
}
