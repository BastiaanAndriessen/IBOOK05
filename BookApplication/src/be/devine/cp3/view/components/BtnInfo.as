package be.devine.cp3.view.components {
import be.devine.cp3.model.AppModel;

import com.greensock.TweenLite;

import flash.ui.Mouse;
import flash.ui.MouseCursor;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.textures.Texture;

public class BtnInfo extends Sprite{
    [Embed(source="/assets/images/btn_info.png")]
    public static const InfoButtonImage:Class;
    private var _appModel;

    public function BtnInfo()
    {
        _appModel = AppModel.getInstance();

        var infoButton:Image = new Image(Texture.fromBitmap(new InfoButtonImage()));
        addChild(infoButton);

        this.addEventListener(TouchEvent.TOUCH, onTouchHandler);
    }

    private function onTouchHandler(e:TouchEvent):void{
        if(e.getTouch(this, TouchPhase.HOVER)){
            Mouse.cursor = MouseCursor.BUTTON;
            TweenLite.to(this,.3, {alpha:.9});
        } else{
            Mouse.cursor = MouseCursor.ARROW;
            if(_appModel.currentPage != "info"){
                TweenLite.to(this,.3, {alpha:1});
            }
        }
    }
}
}
