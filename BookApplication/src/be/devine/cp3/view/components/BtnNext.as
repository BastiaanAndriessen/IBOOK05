package be.devine.cp3.view.components {
import com.greensock.TweenLite;

import flash.ui.Mouse;
import flash.ui.MouseCursor;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.textures.Texture;

public class BtnNext extends Sprite{
    [Embed(source="/assets/images/btn_next.png")]
    public static const NextButtonImage:Class;

    public function BtnNext() {
        var nextButton:Image = new Image(Texture.fromBitmap(new NextButtonImage()));
        addChild(nextButton);

        this.addEventListener(TouchEvent.TOUCH, onTouchHandler);
    }

    private function onTouchHandler(e:TouchEvent):void{
        if(e.getTouch(this, TouchPhase.HOVER)){
            Mouse.cursor = MouseCursor.BUTTON;
            TweenLite.to(this,.3, {alpha:.9});
        } else {
            Mouse.cursor = MouseCursor.ARROW;
            TweenLite.to(this,.3, {alpha:1});
        }
    }
}
}
