package be.devine.cp3.view {
import be.devine.cp3.model.AppModel;
import be.devine.cp3.util.XMLLoader;
import be.devine.cp3.view.components.BtnFullscreen;
import be.devine.cp3.view.components.BtnInfo;
import be.devine.cp3.view.components.BtnOverview;
import be.devine.cp3.view.components.Logo;
import be.devine.cp3.vo.MiniatureVO;

import flash.events.Event;

import starling.display.Sprite;
import starling.events.Event;

public class Navigation extends Sprite{
    private var _appModel;

    private var _xmlLoader:XMLLoader;

    private var _btnLogo:Logo;
    private var _btnOverview:BtnOverview;
    private var _btnInfo:BtnInfo;
    private var _btnFullscreen:BtnFullscreen;
    private var _controlsContainer:Sprite;

    public function Navigation() {
        _appModel = AppModel.getInstance();

        _btnLogo = new Logo();
        addChild(_btnLogo);

        _controlsContainer = new Sprite();

        _btnOverview = new BtnOverview();
        _btnOverview.addEventListener(starling.events.Event.TRIGGERED, goToOverview);
        _controlsContainer.addChild(_btnOverview);

        _btnInfo = new BtnInfo();
        _btnInfo.x = _btnOverview.width;
        _controlsContainer.addChild(_btnInfo);

        _btnFullscreen = new BtnFullscreen();
        _btnFullscreen.x = _btnInfo.x + _btnInfo.width;
        _btnFullscreen.addEventListener(starling.events.Event.TRIGGERED, toggleFullscreen);
        _controlsContainer.addChild(_btnFullscreen);

        addChild(_controlsContainer);
    }

    private function goToOverview(e:starling.events.Event):void{
        _xmlLoader = new XMLLoader();
        _xmlLoader.loadXML("/assets/magazines.xml");
        _xmlLoader.addEventListener(XMLLoader.XML_LOADED, xmlLoadedHandler);
    }

    private function xmlLoadedHandler(e:flash.events.Event):void{
        var xml:XML = _xmlLoader.xml;
        for each(var page:XML in xml.page){
            var miniature:MiniatureVO = new MiniatureVO(page);
        }
    }

    private function toggleFullscreen(e:starling.events.Event):void{
        if(_appModel.isFullScreen){
            _appModel.isFullScreen = false;
        } else {
            _appModel.isFullScreen = true;
        }
    }

    public function get controlsContainer():Sprite {
        return _controlsContainer;
    }
}
}
