package be.devine.cp3.view {

import be.devine.cp3.model.AppModel;

import com.greensock.TweenLite;

import flash.display.Bitmap;
import flash.display.Loader;
import flash.events.Event;
import flash.net.URLRequest;
import flash.ui.Mouse;
import flash.ui.MouseCursor;

import starling.display.Image;

import starling.display.Quad;
import starling.display.Sprite;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.textures.Texture;

public class MiniatureView extends Sprite{
    private var _loader:Loader;
    private var _appModel:AppModel;

    private var _posX:uint;
    private var _posY:uint;
    private var _pageData:XML;
    private var _current:Boolean = false;

    private var _overlay:Quad;

    public function MiniatureView(page:XML, posX:uint,  posY:uint) {
        _appModel = AppModel.getInstance();

        _loader = new Loader();
        _loader.load (new URLRequest(page.miniaturepath));
        _loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, imageLoadedHandler);

        this._posX = posX;
        this._posY = posY;
        this._pageData = page;
    }

    private function imageLoadedHandler(event:flash.events.Event):void
    {
        var loadedBitmap:Bitmap = event.currentTarget.content as Bitmap;

        var image:Image = new Image(Texture.fromBitmap(loadedBitmap));
        addChild(image);

        this.x = _posX;
        this.y = _posY;

        _overlay = new Quad(this.width,  this.height, 0x1f4671);
        _overlay.alpha = .5;
        addChild(_overlay);

        this.addEventListener(TouchEvent.TOUCH, onTouchHandler);
    }

    private function onTouchHandler(e:TouchEvent):void{
        if(e.getTouch(this, TouchPhase.HOVER)){
            Mouse.cursor = MouseCursor.BUTTON;
            TweenLite.to(_overlay,.5, {alpha:0});
        } else {
            Mouse.cursor = MouseCursor.ARROW;
            TweenLite.to(_overlay,.5, {alpha:.5});
        }

        if (e.getTouch(this, TouchPhase.ENDED))
        {
            _current = true;
            _appModel.currentPage = 'pageview';
        }
    }

    public function get current():Boolean {
        return _current;
    }

    public function set current(value:Boolean):void {
        _current = value;
    }

    public function get pageData():XML {
        return _pageData;
    }
}
}
