package be.devine.cp3.view {
import be.devine.cp3.model.AppModel;
import be.devine.cp3.view.components.BtnOverview;

import starling.display.Sprite;

public class Navigation extends Sprite{
    private var _appModel;
    private var _btnOverview:BtnOverview;

    public function Navigation(appModel:AppModel) {
        this._appModel = appModel;

        _btnOverview = new BtnOverview();
        addChild(_btnOverview);
    }
}
}
