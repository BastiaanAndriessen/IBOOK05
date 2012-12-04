package be.devine.cp3.view {
import be.devine.cp3.model.AppModel;
import be.devine.cp3.view.components.BtnFullscreen;
import be.devine.cp3.view.components.BtnInfo;
import be.devine.cp3.view.components.BtnOverview;
import be.devine.cp3.view.components.Logo;

import flash.events.MouseEvent;

import starling.display.Sprite;
import starling.events.Event;

public class Navigation extends Sprite{
    private var _appModel;
    private var _btnLogo:Logo;
    private var _btnOverview:BtnOverview;
    private var _btnInfo:BtnInfo;
    private var _btnFullscreen:BtnFullscreen;
    private var _controlsContainer:Sprite;

    public function Navigation(appModel:AppModel) {
        this._appModel = appModel;

        _btnLogo = new Logo();
        addChild(_btnLogo);

        _controlsContainer = new Sprite();

        _btnOverview = new BtnOverview();
        _controlsContainer.addChild(_btnOverview);

        _btnInfo = new BtnInfo();
        _btnInfo.x = _btnOverview.width;
        _controlsContainer.addChild(_btnInfo);

        _btnFullscreen = new BtnFullscreen();
        _btnFullscreen.x = _btnInfo.x + _btnInfo.width;
        _btnFullscreen.addEventListener(Event.TRIGGERED, toggleFullscreen);
        _controlsContainer.addChild(_btnFullscreen);

        addChild(_controlsContainer);
    }

    private function toggleFullscreen(e:Event):void{
        trace('test toggle fullscreen');
        //this._appModel.isFullscreen = false;
    }

    public function get controlsContainer():Sprite {
        return _controlsContainer;
    }
}
}
