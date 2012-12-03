package {

import be.devine.cp3.Application;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageDisplayState;
import flash.display.StageScaleMode;
import flash.events.Event;

import starling.core.Starling;

[SWF(backgroundColor="0xFFFFFF")]
public class Main extends Sprite {
    private var _starling:Starling;

    public function Main() {
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;

        this.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;

        _starling = new Starling(Application, stage);
        _starling.start();
        stage.addEventListener(Event.RESIZE, resizeHandler);
    }

    private function resizeHandler(e:Event):void{
        trace('[Main] resizeHandler');
        trace('[Main] TEST');

    }
}
}
