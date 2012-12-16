package be.devine.cp3.view {
import be.devine.cp3.view.components.BtnNext;
import be.devine.cp3.view.components.BtnPrev;

import com.greensock.TweenLite;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.KeyboardEvent;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class MiniaturesControl extends Sprite{
    private var _miniatures:Miniatures;
    private var _btnPrev:BtnPrev;
    private var _btnNext:BtnNext;

    private var _miniaturesToLoad:uint;
    private var _miniaturesPage:uint = 1;

    public function MiniaturesControl(miniaturesToLoad:uint) {
        this._miniaturesToLoad = miniaturesToLoad;
        trace('constructor miniaturescontrol');

        showMiniaturesAndButtons();

        this.alpha = 0;
        TweenLite.to(this, 2, {alpha:1});
    }

    private function showMiniaturesAndButtons():void{
        _miniatures = new Miniatures(_miniaturesToLoad, _miniaturesPage);
        _miniatures.addEventListener(Miniatures.XML_LOADED, xmlLoadedHandler);
        addChild(_miniatures);

        if(_miniaturesPage > 1){
            _btnPrev = new BtnPrev();
            _btnPrev.x = 35;
            _btnPrev.y = 350;
            _btnPrev.addEventListener(TouchEvent.TOUCH, showPreviousMiniatures);
            addChild(_btnPrev);
        }

        this.addEventListener(KeyboardEvent.KEY_UP, keyBoardEventHandler);
    }

    private function xmlLoadedHandler(e:Event):void{
        trace('max page: '+Math.round(_miniatures.totalPages/_miniaturesToLoad));
        trace('current page: '+_miniaturesPage);
        if(_miniaturesPage < Math.round(_miniatures.totalPages/_miniaturesToLoad)){
            _btnNext = new BtnNext();
            _btnNext.x = 935;
            _btnNext.y = 350;
            _btnNext.addEventListener(TouchEvent.TOUCH, showNextMiniatures);
            addChild(_btnNext);
        }
    }

    private function keyBoardEventHandler(e:KeyboardEvent):void{
        trace('keycode: '+e.keyCode);
        switch(e.keyCode){
            //Right
            case 39:
                trace('Keyboard RIGHT');
                break;
            //Left
            case 37:
                trace('Keyboard LEFT');
                break;
        }
    }

    private function showNextMiniatures(e:TouchEvent):void{
        if (e.getTouch(_btnNext, TouchPhase.ENDED))
        {
            trace('show next miniatures');
            TweenLite.to(_miniatures, 2, {alpha:0, onComplete:function():void{
                _miniaturesPage++;
                reboot();
            }});
        }
    }

    private function showPreviousMiniatures(e:TouchEvent):void{
        if (e.getTouch(_btnPrev, TouchPhase.ENDED))
        {
            trace('show previous miniatures');
            TweenLite.to(_miniatures, 2, {alpha:0, onComplete:function():void{
                _miniaturesPage--;
                reboot();
            }});
        }
    }

    public function reboot():void {
        removeChild(_miniatures);
        if(_btnNext != null){
            removeChild(_btnNext);
        }
        if(_btnPrev != null){
            removeChild(_btnPrev);
        }
        showMiniaturesAndButtons();
    }
}
}
