package be.devine.cp3.model {
import starling.events.EventDispatcher;

public class AppModel extends EventDispatcher{
    public static var instance:AppModel;

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
}
}
internal class Enforcer{};
