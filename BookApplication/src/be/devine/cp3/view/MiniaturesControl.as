package be.devine.cp3.view {
import be.devine.cp3.factory.TextfieldFactory;
import be.devine.cp3.model.AppModel;
import be.devine.cp3.view.components.BtnNext;
import be.devine.cp3.view.components.BtnPrev;

import com.greensock.TweenLite;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.KeyboardEvent;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;

public class MiniaturesControl extends Sprite{
    private var _appModel:AppModel;

    private var _miniatures:Miniatures;
    private var _pageCountTextField:TextField;
    private var _btnPrev:BtnPrev;
    private var _btnNext:BtnNext;

    private var _miniaturesToLoad:uint;
    private var _miniaturesPage:uint = 1;

    private var _goToPrev:Boolean = false;

    public function MiniaturesControl(miniaturesToLoad:uint) {
        _appModel = AppModel.getInstance();

        this._miniaturesToLoad = miniaturesToLoad;
        trace('constructor miniaturescontrol');
        this.addEventListener(starling.events.Event.ADDED_TO_STAGE, atsHandler);
    }

    private function atsHandler(e:Event):void{
        showMiniaturesAndButtons();

        this.alpha = 0;
        TweenLite.to(this, 2, {alpha:1});
        stage.addEventListener(KeyboardEvent.KEY_UP, keyBoardEventHandler);
    }

    private function showMiniaturesAndButtons():void{
        _miniatures = new Miniatures(_miniaturesToLoad, _miniaturesPage);
        _miniatures.addEventListener(Miniatures.XML_LOADED, xmlLoadedHandler);
        _miniatures.alpha = 0;
        if(!_goToPrev){
            _miniatures.x += 200;
        } else {
            _miniatures.x -= 200;
        }
        TweenLite.to(_miniatures, 1, {alpha:1, x:0});
        _goToPrev = false;
        addChild(_miniatures);

        if(_miniaturesPage > 1){
            _btnPrev = new BtnPrev();
            _btnPrev.x = 35;
            _btnPrev.y = 350;
            _btnPrev.addEventListener(TouchEvent.TOUCH, previousClickHandler);
            addChild(_btnPrev);
        }
    }

    public function removeEvents():void{
        trace('[MiniaturesControl] remove all events');
        _miniatures.removeEventListener(Miniatures.XML_LOADED, xmlLoadedHandler);
        this.addEventListener(starling.events.Event.ADDED_TO_STAGE, atsHandler);
    }

    private function xmlLoadedHandler(e:Event):void{
        if(_miniaturesPage < Math.round(_miniatures.totalPages/_miniaturesToLoad)){
            _btnNext = new BtnNext();
            _btnNext.x = 935;
            _btnNext.y = 350;
            _btnNext.addEventListener(TouchEvent.TOUCH, nextClickHandler);
            addChild(_btnNext);
        }

        trace('[MiniaturesControl] xml loaded handler');
        var pageCountTextFieldContent:String = _miniaturesPage+" / "+(Math.round(_miniatures.totalPages/_miniaturesToLoad));
        _pageCountTextField = TextfieldFactory.createPageCountTextfield(pageCountTextFieldContent);
        addChild(_pageCountTextField);
        _pageCountTextField.x = 512 - _pageCountTextField.width/2;
        _pageCountTextField.y = 600;
    }

    private function keyBoardEventHandler(e:KeyboardEvent):void{
        if(_appModel.currentPage == 'overview'){
            switch(e.keyCode){
                //N - Next
                case 78:
                    if(_miniaturesPage < Math.round(_miniatures.totalPages/_miniaturesToLoad)){
                        showNextMiniatures();
                    }
                    break;
                //P - Previous
                case 80:
                    if(_miniaturesPage > 1){
                        showPreviousMiniatures();
                    }
                    break;
            }
        }
    }

    private function nextClickHandler(e:TouchEvent):void{
        if (e.getTouch(_btnNext, TouchPhase.ENDED))
        {
            showNextMiniatures();
        }
    }

    private function showNextMiniatures():void{
        trace('show next miniatures');
        removeHandlers();
        TweenLite.to(_miniatures,.3, {alpha:0, x:-200, onComplete:function():void{
            _miniaturesPage++;
            reboot();
        }});
    }

    private function previousClickHandler(e:TouchEvent):void{
        if (e.getTouch(_btnPrev, TouchPhase.ENDED))
        {
            showPreviousMiniatures();
        }
    }

    private function showPreviousMiniatures():void{
        trace('show previous miniatures');
        removeHandlers();
        TweenLite.to(_miniatures,.2, {alpha:0, x:+200, onComplete:function():void{
            _goToPrev = true;
            _miniaturesPage--;
            reboot();
        }});
    }

    public function removeHandlers():void{
        if(_btnPrev != null){
            _btnPrev.removeEventListener(TouchEvent.TOUCH, previousClickHandler);
        }
        if(_btnNext != null){
            _btnNext.removeEventListener(TouchEvent.TOUCH, nextClickHandler);
        }
    }

    public function reboot():void {
        removeChild(_miniatures);
        removeChild(_pageCountTextField);
        if(_btnNext != null){
            removeChild(_btnNext);
        }
        if(_btnPrev != null){
            removeChild(_btnPrev);
        }
        showMiniaturesAndButtons();
    }

    public function get miniatures():Miniatures {
        return _miniatures;
    }
}
}
