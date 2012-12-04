package be.devine.cp3.view {
import be.devine.cp3.model.AppModel;
import be.devine.cp3.util.ImageLoader;
import be.devine.cp3.view.components.Overview;

import starling.display.Sprite;
import starling.events.Event;

public class Navigation extends Sprite{
    private var _appModel;
    private var _btnOverview:Overview;

    public function Navigation(appModel:AppModel) {
        this._appModel = appModel;

        _btnOverview = new Overview();
        addChild(_btnOverview);
    }
}
}
