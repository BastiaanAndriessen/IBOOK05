package be.devine.cp3 {

import be.devine.cp3.model.AppModel;
import be.devine.cp3.view.InfoComponent;
import be.devine.cp3.view.MiniatureView;
import be.devine.cp3.view.MiniaturesControl;
import be.devine.cp3.view.Navigation;
import be.devine.cp3.view.HomeComponent;
import be.devine.cp3.view.Pages;
import be.devine.cp3.view.components.Pattern;

import com.greensock.TweenLite;
import flash.events.Event;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.KeyboardEvent;

public class Application extends Sprite{
    private var _appModel:AppModel;
    private var _pattern:Pattern;
    private var _navigation:Navigation;

    private var _miniaturesControl:MiniaturesControl;
    private var _homeComponent:HomeComponent;
    private var _infoComponent:InfoComponent;
    private var _pages:Pages;

    private var _xml:XML;

    private var _newContentShowing:Boolean = false;

    public function Application() {
        this.addEventListener(starling.events.Event.ADDED_TO_STAGE, atsHandler);
    }

    private function atsHandler(e:starling.events.Event):void{
        _appModel = AppModel.getInstance();
        _appModel.addEventListener(AppModel.CURRENT_PAGE_CHANGED, removeComponents);
        setBackgroundPattern();

        _navigation = new Navigation();
        _navigation.x = stage.stageWidth/9;
        _navigation.y = stage.stageHeight/10;
        addChild(_navigation);

        _homeComponent = new HomeComponent();
        _appModel.currentPage = 'home';
    }

    public function setBackgroundPattern(){
        if(background != null){
            removeChild(background);
        }
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

    private function removeComponents(e:flash.events.Event):void{
        _newContentShowing = false;
        trace('remove all contents');
        if(_homeComponent != null){
            TweenLite.to(_homeComponent,.2, {alpha:0, onComplete:function():void{
                removeChild(_homeComponent);
                _homeComponent = null;
                if(!_newContentShowing){
                    showNewContent();
                }
            }});
        } else if(_infoComponent != null){
            TweenLite.to(_infoComponent,.2, {alpha:0, onComplete:function():void{
                removeChild(_infoComponent);
                _infoComponent = null;
                if(!_newContentShowing){
                    showNewContent();
                }
            }});
        } else if(_pages != null){
            TweenLite.to(_pages,.3, {alpha:0, onComplete:function():void{
                removeChild(_pages);
                if(!_newContentShowing){
                    showNewContent();
                }
            }});
        } else if(_miniaturesControl != null && _appModel.currentPage != 'pageview'){
            TweenLite.to(_miniaturesControl,.2, {alpha:0, onComplete:function():void{
                //_miniaturesControl.removeEvents();
                removeChild(_miniaturesControl);
                _miniaturesControl = null;
                if(!_newContentShowing){
                    showNewContent();
                }
            }});
        } else if(_appModel.currentPage == 'pageview'){
            if(!_newContentShowing){
                showNewContent();
            }
        }
    }

    private function showNewContent():void{
        _newContentShowing = true;
        trace('show new content');
        switch(_appModel.currentPage){
            case 'home':
                TweenLite.to(_navigation.btnInfo, .3, {alpha: 1});
                TweenLite.to(_navigation.btnOverview, .3, {alpha: 1});
                TweenLite.to(_navigation.btnLogo, .3, {alpha: .9});
                showHomeComponents();
                break;
            case 'overview':
                TweenLite.to(_navigation.btnInfo, .3, {alpha: 1});
                TweenLite.to(_navigation.btnOverview, .3, {alpha:.9});
                TweenLite.to(_navigation.btnLogo, .3, {alpha: 1});
                showAllMiniaturesHandler();
                break;
            case 'info':
                TweenLite.to(_navigation.btnInfo, .3, {alpha:.9});
                TweenLite.to(_navigation.btnOverview, .3, {alpha: 1});
                TweenLite.to(_navigation.btnLogo, .3, {alpha: 1});
                showInfoComponents();
                break;
            case 'pageview':
                TweenLite.to(_navigation.btnInfo, .3, {alpha:1});
                TweenLite.to(_navigation.btnOverview, .3, {alpha: 1});
                TweenLite.to(_navigation.btnLogo, .3, {alpha: 1});
                showPageHandler();
        }
    }

    private function showHomeComponents():void{
        _homeComponent = new HomeComponent();
        _homeComponent.x = 115;
        _homeComponent.y = stage.stageHeight/2 - _homeComponent.height/2;
        _homeComponent.alpha = 0;
        addChild(_homeComponent);
        TweenLite.to(_homeComponent,.5, {alpha:1});
    }

    private function showAllMiniaturesHandler():void{
        var miniatureWidth:uint = 196;
        var miniaturesToLoad:uint = Math.round(((stage.stageWidth-(2*105))/miniatureWidth)*2);

        _miniaturesControl = new MiniaturesControl(miniaturesToLoad);
        addChild(_miniaturesControl);
    }

    private function showPageHandler():void{
        trace('[Application] show pages');
        _xml = _miniaturesControl.miniatures.loadedXML;
        for each(var miniature:MiniatureView in _miniaturesControl.miniatures.miniatures){
            if(miniature.current){
                _pages = new Pages(_xml, uint(miniature.pageData.@id));
                _pages.addEventListener(Pages.SHOW_NEXT_OR_PREV, showNextOrPrev);
                addChild(_pages);

                miniature.current = false;
            }
        }

        TweenLite.to(_miniaturesControl,1, {alpha:0, onComplete:function():void{
            removeChild(_miniaturesControl);
            _miniaturesControl = null;
        }});
    }

    private function showNextOrPrev(e:starling.events.Event):void{
        var isNext:Boolean = _pages.isNext;
        var nextPageId:uint
        if(isNext){
            if(_pages.pageId == 35){
                nextPageId = _pages.pageId+1;
            } else {
                nextPageId = _pages.pageId+2;
            }
        } else {
            if(_pages.pageId == 2){
                nextPageId = _pages.pageId-1;
            } else {
                nextPageId = _pages.pageId-2;
            }
        }
        for each(var page:XML in _xml.page){
            if(uint(page.@id) == nextPageId){
                TweenLite.to(_pages,.3,{alpha:0, onComplete:function():void{
                    removeChild(_pages);
                    _pages = new Pages(_xml, nextPageId);
                    _pages.addEventListener(Pages.SHOW_NEXT_OR_PREV, showNextOrPrev);
                    addChild(_pages);
                }})
            }
        }
    }

    private function showInfoComponents():void{
        _infoComponent = new InfoComponent();
        _infoComponent.x = 115;
        _infoComponent.y = stage.stageHeight/2 - _infoComponent.height/2;
        _infoComponent.alpha = 0;
        addChild(_infoComponent);
        TweenLite.to(_infoComponent, .5, {alpha:1});
    }
}
}
