package be.devine.cp3.model {
import flash.events.Event;
import flash.events.EventDispatcher;

public class AppModel extends EventDispatcher{
    public static var instance:AppModel;
    public static const CURRENT_PAGE_CHANGED:String = "the current page has been changed";
    private var _currentPage:String;

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

    public function get currentPage():String {
        return _currentPage;
    }

    public function set currentPage(value:String):void {
        if(_currentPage != value){
            _currentPage = value;
            dispatchEvent(new Event(CURRENT_PAGE_CHANGED));
        }
    }
}
}
internal class Enforcer{};
