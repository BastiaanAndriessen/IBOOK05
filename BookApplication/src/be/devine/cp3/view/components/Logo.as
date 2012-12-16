package be.devine.cp3.view.components {
import be.devine.cp3.model.AppModel;

import com.greensock.TweenLite;

import flash.ui.Mouse;
import flash.ui.MouseCursor;

import starling.display.Button;
import starling.display.Image;
import starling.display.Sprite;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.textures.Texture;

public class Logo extends Sprite{
    [Embed(source="/assets/images/logo_image.png")]
    public static const LogoButtonImage:Class;

    [Embed(source="/assets/images/text/logo_text.png")]
    public static const TextButtonImage:Class;
    private var _appModel;

    public function Logo()
    {
        _appModel = AppModel.getInstance();

        var t:Texture = Texture.fromBitmap(new LogoButtonImage());
        var logoButton:Button = new Button(t);
        addChild(logoButton);

        var t2:Texture = Texture.fromBitmap(new TextButtonImage());
        var text:Image = new Image(t2);
        addChild(text);
        text.x = 50;
        text.y = 15;

        this.addEventListener(TouchEvent.TOUCH, onTouchHandler);
    }

    private function onTouchHandler(e:TouchEvent):void{
        if(e.getTouch(this, TouchPhase.HOVER)){
            Mouse.cursor = MouseCursor.BUTTON;
            TweenLite.to(this,.3, {alpha:.9});
        } else {
            Mouse.cursor = MouseCursor.ARROW;
            if(_appModel.currentPage != "home"){
                TweenLite.to(this,.3, {alpha:1});
            }
        }
    }
}
}
