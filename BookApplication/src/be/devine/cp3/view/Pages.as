package be.devine.cp3.view {
import be.devine.cp3.factory.TextfieldFactory;
import be.devine.cp3.view.components.BtnNext;
import be.devine.cp3.view.components.BtnPrev;

import com.greensock.TweenLite;

import flash.events.TimerEvent;

import flash.utils.Timer;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.KeyboardEvent;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;

public class Pages extends Sprite{
    public static const SHOW_NEXT_OR_PREV:String = "Show next or previous 2 pages";
    private var _isNext:Boolean = false;

    private var _loadedXML:XML;
    private var _pageXMLData:XML;
    private var _pageXMLData2:XML;

    private var _pageId:uint;
    private var _pageView:PageView;
    private var _pageView2:PageView;

    private var _btnPrev:BtnPrev;
    private var _btnNext:BtnNext;
    private var _btnContainer:Sprite;

    private var _timer:Timer;

    public function Pages(loadedXML:XML, pageId:uint) {
        this._loadedXML = loadedXML;
        this._pageId = pageId;
        this.addEventListener(Event.ADDED_TO_STAGE, atsHandler);
    }

    private function atsHandler(e:Event):void{
        showPages();
    }

    private function showPages():void{
        var odd:Boolean = false;
        for each(var pageData:XML in _loadedXML.page){
            if(uint(pageData.@id) == _pageId){
                _pageXMLData = pageData;
                _pageView = new PageView(pageData);
                addChild(_pageView);
            }

            if(uint(pageData.@id) % 2 == 0){
                if(uint(pageData.@id) == (_pageId-1)){
                    _pageXMLData2 = pageData;
                }
            }else{
                if(uint(pageData.@id) == (_pageId+1)){
                    odd = true;
                    _pageXMLData2 = pageData;
                }
            }
        }
        if(_pageXMLData.@id == '1' || _pageXMLData.@id == '36'){
            _pageView.addEventListener(PageView.IMAGE_LOADED, centerPage);
        } else {
            _pageView2 = new PageView(_pageXMLData2);
            addChild(_pageView2);
            if(odd){
                _pageView2.x = stage.stageWidth/2;
            } else {
                _pageView.x = stage.stageWidth/2;
            }
        }

        this.y = stage.stageHeight/2 - this.height/2 - 220;
        _btnContainer = new Sprite();

        if(_pageXMLData.@id != '1'){
            _btnPrev = new BtnPrev();
            _btnPrev.x = 35;
            _btnPrev.y = 197;
            _btnPrev.addEventListener(TouchEvent.TOUCH, prevClickHandler);
            _btnContainer.addChild(_btnPrev);
        }

        if(_pageXMLData.@id != '36'){
            _btnNext = new BtnNext();
            _btnNext.x = 935;
            _btnNext.y = 197;
            _btnNext.addEventListener(TouchEvent.TOUCH, nextClickHandler);
            _btnContainer.addChild(_btnNext);
        }
        stage.addEventListener(KeyboardEvent.KEY_UP, keyBoardEventHandler);

        _btnContainer.alpha = .1;
        addChild(_btnContainer);

        var currentPages:String;
        if(_pageId % 2 == 0){
            if(_pageId == 36){
                currentPages = _pageId.toString();
            } else {
                currentPages = _pageId.toString()+' - '+(_pageId+1).toString();
            }
        } else {
            if(_pageId == 1){
                currentPages = _pageId.toString();
            } else {
                currentPages = (_pageId-1).toString()+' - '+_pageId.toString();
            }
        }

        var pageCountTextFieldContent:String = currentPages+" / "+_loadedXML.@totalPages;
        trace(pageCountTextFieldContent);
        var _pageCountTextField:TextField = TextfieldFactory.createPageCountTextfield(pageCountTextFieldContent);
        _pageCountTextField.x = stage.stageWidth/2 - _pageCountTextField.width/2;
        _pageCountTextField.y = (stage.stageHeight/4)*2 + 145;
        _pageCountTextField.alpha = 0;
        TweenLite.to(_pageCountTextField,.3,{alpha:1});
        addChild(_pageCountTextField);

        stage.addEventListener(TouchEvent.TOUCH, touchHandler);
    }

    private function keyBoardEventHandler(e:KeyboardEvent):void{
        switch(e.keyCode){
            //Right
            case 39:
                if(_pageId != 36){
                    showNextPage();
                }
                break;
            //Left
            case 37:
                if(_pageId != 1){
                    showPreviousPage();
                }
                break;
        }
    }

    private function nextClickHandler(e:TouchEvent):void{
        if (e.getTouch(_btnNext, TouchPhase.ENDED))
        {
            showNextPage();
        }
    }

    private function showNextPage():void{
        removeHandlers();
        TweenLite.to(_pageView,.3,{alpha:0, onComplete:function():void{
            removeChild(_pageView);
            _isNext = true;
            dispatchEvent(new Event(SHOW_NEXT_OR_PREV));
        }});
        if(_pageView2 != null){
            TweenLite.to(_pageView2,.3,{alpha:0, onComplete:function():void{
                removeChild(_pageView2);
            }});
        }
    }

    private function prevClickHandler(e:TouchEvent):void{
        if (e.getTouch(_btnPrev, TouchPhase.ENDED))
        {
            showPreviousPage();
        }
    }

    private function showPreviousPage():void{
        removeHandlers();
        TweenLite.to(_pageView,.3,{alpha:0, onComplete:function():void{
            removeChild(_pageView);
            dispatchEvent(new Event(SHOW_NEXT_OR_PREV));
        }});
        if(_pageView2 != null){
            TweenLite.to(_pageView2,.3,{alpha:0, onComplete:function():void{
                removeChild(_pageView2);
            }});
        }
    }

    public function removeHandlers():void{
        if(_btnPrev != null){
            _btnPrev.removeEventListener(TouchEvent.TOUCH, prevClickHandler);
        }
        if(_btnNext != null){
            _btnNext.removeEventListener(TouchEvent.TOUCH, nextClickHandler);
        }
        if(stage != null){
            stage.addEventListener(KeyboardEvent.KEY_UP, keyBoardEventHandler);
        }
    }

    private function touchHandler(e:TouchEvent):void{
        TweenLite.to(_btnContainer, 2, {alpha:1});
        _timer = new Timer(2000,1);
        _timer.addEventListener(TimerEvent.TIMER, tickHandler);
        _timer.start();
    }

    private function tickHandler(e:TimerEvent):void{
        TweenLite.to(_btnContainer, 1, {alpha:.1});
    }

    private function centerPage(e:Event):void{
        _pageView.x = stage.stageWidth/2-_pageView.width/2;
    }

    public function get pageId():uint {
        return _pageId;
    }

    public function get isNext():Boolean {
        return _isNext;
    }
}
}
