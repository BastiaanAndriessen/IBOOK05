package be.devine.cp3.model {
import starling.events.Event;
import starling.events.EventDispatcher;

public class AppModel extends EventDispatcher{
    public static var instance:AppModel;
    public static const TOGGLE_FULLSCREEN:String = "toggle the fullscreen option";
    private var _isFullScreen:Boolean = false;

    public static function getInstance():AppModel{
        if(instance == null){
            instance = new AppModel(new Enforcer());
        }
        return instance;
    }

    public function AppModel(e:Enforcer) {
        if(e == null){
            throw new Error("AppModel is a Singleton.");
        }

    }

    public function get isFullScreen():Boolean {
        return _isFullScreen;
    }

    public function set isFullScreen(value:Boolean):void {
        if(_isFullScreen != value){
            _isFullScreen = value;
            dispatchEvent(new Event(TOGGLE_FULLSCREEN, true));
        }
    }
}
}
internal class Enforcer{};
