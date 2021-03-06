package be.devine.cp3.view.components {
import be.devine.cp3.model.AppModel;

import com.greensock.TweenLite;

import flash.ui.Mouse;
import flash.ui.MouseCursor;

import flashx.textLayout.accessibility.TextAccImpl;

import starling.display.Button;
import starling.display.Image;
import starling.display.Sprite;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.textures.Texture;

public class BtnOverview extends Sprite{
    [Embed(source="/assets/images/btn_overview.png")]
    public static const OverviewButtonImage:Class;
    private var _appModel;

    public function BtnOverview()
    {
        _appModel = AppModel.getInstance();

        var overviewButton:Image = new Image(Texture.fromBitmap(new OverviewButtonImage()));
        addChild(overviewButton);

        this.addEventListener(TouchEvent.TOUCH, onTouchHandler);
    }

    private function onTouchHandler(e:TouchEvent):void{
        if(e.getTouch(this, TouchPhase.HOVER)){
            Mouse.cursor = MouseCursor.BUTTON;
            TweenLite.to(this,.3, {alpha:.9});
        } else {
            Mouse.cursor = MouseCursor.ARROW;
            if(_appModel.currentPage != "overview"){
                TweenLite.to(this,.3, {alpha:1});
            }
        }
    }
}
}
