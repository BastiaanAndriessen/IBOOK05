package be.devine.cp3 {

import be.devine.cp3.model.AppModel;
import be.devine.cp3.view.InfoComponent;
import be.devine.cp3.view.MiniaturesControl;
import be.devine.cp3.view.Navigation;
import be.devine.cp3.view.HomeComponent;
import be.devine.cp3.view.components.Pattern;

import com.greensock.TweenLite;
import flash.events.Event;
import starling.display.Sprite;
import starling.events.Event;

public class Application extends Sprite{

    private var _appModel:AppModel;
    private var _pattern:Pattern;
    private var _navigation:Navigation;

    private var _miniaturesControl:MiniaturesControl;
    private var _homeComponent:HomeComponent;
    private var _infoComponent:InfoComponent;

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

        _appModel.currentPage = 'home';
        showNewContent();

        stage.addEventListener(starling.events.Event.RESIZE, resizeHandler);
    }

    public function setBackgroundPattern(){
        if(background != null){
            background = null;
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

    private function resizeHandler(e:starling.events.Event):void{
        //setBackgroundPattern();
        //trace(stage.stageWidth);
        //trace(stage.stageHeight);
    }

    private function removeComponents(e:flash.events.Event):void{
        trace('remove all contents');
        if(_homeComponent != null){
            TweenLite.to(_homeComponent, 1, {alpha:0, onComplete:function():void{
                _homeComponent = null;
                showNewContent();
            }});
        }
        if(_miniaturesControl != null){
            TweenLite.to(_miniaturesControl, 1, {alpha:0, onComplete:function():void{
                _miniaturesControl = null;
                showNewContent();
            }});
        }
        if(_infoComponent != null){
            TweenLite.to(_infoComponent, 1, {alpha:0, onComplete:function():void{
                _infoComponent = null;
                showNewContent();
            }});
        }
    }

    private function showNewContent():void{
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
        }
    }

    private function showHomeComponents():void{
        _homeComponent = new HomeComponent();
        _homeComponent.x = 115;
        _homeComponent.y = stage.stageHeight/2 - _homeComponent.height/2;
        _homeComponent.alpha = 0;
        addChild(_homeComponent);
        trace('show home component');
        TweenLite.to(_homeComponent, 2, {alpha:1});
    }

    private function showAllMiniaturesHandler():void{
        var miniatureWidth:uint = 196;
        var miniaturesToLoad:uint = Math.round(((stage.stageWidth-(2*105))/miniatureWidth)*2);

        _miniaturesControl = new MiniaturesControl(miniaturesToLoad);
        addChild(_miniaturesControl);
        trace('show all miniatures');
    }

    private function showInfoComponents():void{
        _infoComponent = new InfoComponent();
        _infoComponent.x = 115;
        _infoComponent.y = stage.stageHeight/2 - _infoComponent.height/2;
        _infoComponent.alpha = 0;
        addChild(_infoComponent);
        trace('show info component');
        TweenLite.to(_infoComponent, 2, {alpha:1});
    }
}
}
