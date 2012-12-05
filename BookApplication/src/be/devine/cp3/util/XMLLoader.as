package be.devine.cp3.util {
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLLoader;
import flash.net.URLRequest;

public class XMLLoader extends EventDispatcher{
    public static const XML_LOADED:String = "XML successfully loaded";
    private var _loader:URLLoader;
    private var _xml:XML;

    public function XMLLoader(){
    }

    public function loadXML(xmlPath:String):void{
        _loader = new URLLoader();
        _loader.addEventListener(Event.COMPLETE, loadCompleteHandler);
        _loader.load(new URLRequest(xmlPath));
    }

    private function loadCompleteHandler(e:Event):void{
        _xml = new XML(e.target.data);
        dispatchEvent(new Event(XML_LOADED));
    }

    public function get xml():XML {
        return _xml;
    }
}
}
