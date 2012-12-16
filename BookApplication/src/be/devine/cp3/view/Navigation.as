package be.devine.cp3.view {
import be.devine.cp3.model.AppModel;
import be.devine.cp3.view.components.BtnInfo;
import be.devine.cp3.view.components.BtnOverview;
import be.devine.cp3.view.components.Logo;

import starling.display.Sprite;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class Navigation extends Sprite{
    private var _appModel;

    private var _btnLogo:Logo;
    private var _btnOverview:BtnOverview;
    private var _btnInfo:BtnInfo;

    public function Navigation() {
        _appModel = AppModel.getInstance();

        _btnLogo = new Logo();
        _btnLogo.addEventListener(TouchEvent.TOUCH, logoOnTouchHandler);
        addChild(_btnLogo);

        _btnOverview = new BtnOverview();
        _btnOverview.addEventListener(TouchEvent.TOUCH, overviewOnTouchHandler);
        _btnOverview.x = 480;
        addChild(_btnOverview);

        _btnInfo = new BtnInfo();
        _btnInfo.x = _btnOverview.x + _btnOverview.width;
        _btnInfo.addEventListener(TouchEvent.TOUCH, infoOnTouchHandler);
        addChild(_btnInfo);
    }

    private function logoOnTouchHandler(e:TouchEvent):void{
        if (e.getTouch(this, TouchPhase.ENDED))
        {
            trace('clicked on logo');
            _appModel.currentPage = 'home';
        }
    }

    private function overviewOnTouchHandler(e:TouchEvent):void{
        if (e.getTouch(this, TouchPhase.ENDED))
        {
            trace('clicked on overviewbutton');
            _appModel.currentPage = 'overview';
        }
    }

    private function infoOnTouchHandler(e:TouchEvent):void{
        if (e.getTouch(this, TouchPhase.ENDED))
        {
            trace('clicked on infobutton');
            _appModel.currentPage = 'info';
        }
    }

    public function get btnOverview():BtnOverview {
        return _btnOverview;
    }

    public function get btnInfo():BtnInfo {
        return _btnInfo;
    }

    public function get btnLogo():Logo {
        return _btnLogo;
    }
}
}
