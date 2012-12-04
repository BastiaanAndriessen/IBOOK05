package be.devine.cp3 {

import be.devine.cp3.model.AppModel;
import be.devine.cp3.view.Navigation;

import flash.display.BitmapData;
import flash.geom.Point;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;

public class Application extends Sprite{

    private var _appModel:AppModel;
    private var _navigation:Navigation;

    public function Application() {
        this.addEventListener(Event.ADDED_TO_STAGE, atsHandler);
    }

    private function atsHandler(e:Event):void{
        trace('[APPLICATION] atsHandler');

        /*var tile:Pattern2 = new Pattern2();
        var t:Texture = Texture.fromBitmapData(new BitmapData(tile.width, tile.height, false));
        t.repeat = true;
        var image:Image = new Image(t);

        var repe:uint = 50
        image.setTexCoords(1, new Point(repe, 0));
        image.setTexCoords(2, new Point(0, repe));
        image.setTexCoords(3, new Point(repe, repe));

        image.width *= repe;
        image.height *= repe;
        addChild(image);
        flatten();
         */
        _appModel = AppModel.getInstance();

        _navigation = new Navigation(_appModel);
        addChild(_navigation);
    }
}
}
