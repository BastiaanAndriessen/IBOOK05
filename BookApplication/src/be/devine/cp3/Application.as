package be.devine.cp3 {

import be.devine.cp3.model.AppModel;
import be.devine.cp3.view.Navigation;
import be.devine.cp3.view.components.Pattern;

import flash.display.StageDisplayState;

import starling.core.Starling;

import starling.display.Sprite;
import starling.events.Event;

public class Application extends Sprite{

    private var _appModel:AppModel;
    private var _pattern:Pattern;
    private var _navigation:Navigation;

    public function Application() {
        this.addEventListener(Event.ADDED_TO_STAGE, atsHandler);
    }

    private function atsHandler(e:Event):void{
        trace('[APPLICATION] atsHandler');
        _appModel = AppModel.getInstance();
        _appModel.addEventListener(AppModel.TOGGLE_FULLSCREEN, fullscreenHandler);

        setBackgroundPattern();

        _navigation = new Navigation(_appModel);
        _navigation.y = stage.stageHeight/10;
        _navigation.controlsContainer.x = stage.stageWidth/3;
        addChild(_navigation);

        stage.addEventListener(Event.RESIZE, resizeHandler);
    }

    public function setBackgroundPattern(){
        var background:Sprite = new Sprite();
        _pattern = new Pattern();

        var row:uint = Math.ceil(stage.stageHeight/_pattern.width);
        var column:uint = Math.ceil(stage.stageWidth/_pattern.height);

        var xPos:uint = 0;
        var yPos:uint = 0;

        for (var i:uint=0;i<row;i++){
            for (var j:uint=0; j<column; j++){
                _pattern = new Pattern();
                background.addChild(_pattern);
                _pattern.x = xPos;
                _pattern.y = yPos;
                xPos += _pattern.width;
            }
            yPos += _pattern.height;
            xPos=0;
        }

        addChild(background);
    }

    private function resizeHandler(e:Event):void{
        //setBackgroundPattern();
        //trace(stage.stageWidth);
        //trace(stage.stageHeight);
    }

    private function fullscreenHandler(e:Event):void{
        trace('[Application] fullscreenHandler');
        /*if(_appModel.isFullScreen){
            Starling.current.nativeStage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
        } else {
            //starling.current.
            Starling.current.nativeStage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
        }*/
    }
}
}
