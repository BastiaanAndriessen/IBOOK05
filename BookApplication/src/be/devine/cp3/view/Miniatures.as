package be.devine.cp3.view {
import be.devine.cp3.util.XMLLoader;

import flash.events.Event;

import starling.display.Sprite;
import starling.events.Event;

public class Miniatures extends Sprite{
    public static const XML_LOADED:String = "XML has successfully been loaded";

    private var _xmlLoader:XMLLoader;
    private var _loadedXML:XML;
    private var _totalPages:uint;

    private var _miniatures:Array;

    private var _miniaturesToLoad:uint;
    private var _miniaturesPage:uint;

    public function Miniatures(miniaturesToLoad:uint, miniaturesPage:uint){
        this._miniaturesToLoad = miniaturesToLoad;
        this._miniaturesPage = miniaturesPage;

        _xmlLoader = new XMLLoader();
        _xmlLoader.loadXML("assets/magazines.xml");
        _xmlLoader.addEventListener(XMLLoader.XML_LOADED, xmlLoadedHandler);
    }

    private function xmlLoadedHandler(e:flash.events.Event):void{
        _loadedXML = new XML(_xmlLoader.xml);
        _totalPages = _loadedXML.@totalPages;
        dispatchEvent(new starling.events.Event(XML_LOADED));

        _miniatures = new Array();

        // grid positie logica:
        var numCols:uint = 4;
        for(var i:uint = 0; i< 8; i++) {
            var page:XML = _loadedXML['page'][i+((_miniaturesPage-1)*8)];
            /*var item:DisplayObject = items[i];
            item.x = (i % numCols) * colWidth;
            item.y = Math.floor(i / numCols) * rowHeight;*/

            if(page != null){
                var posX:uint = (i % numCols) * page.miniaturepath.@width + 115;
                var posY:uint = Math.floor(i / numCols) * page.miniaturepath.@height + 180;
                var mini:MiniatureView = new MiniatureView(page, posX,  posY);
                addChild(mini);

                _miniatures.push(mini);
            }
        }

        /*var posX:uint = 115;
        var posY:uint = 180;
        for each(var page:XML in _loadedXML.page){
            if(page.@id>=((_miniaturesToLoad*_miniaturesPage)-_miniaturesToLoad) && page.@id<(_miniaturesToLoad*_miniaturesPage)){
                if(page.@id>=((_miniaturesToLoad*_miniaturesPage)-_miniaturesToLoad/2)){
                    if(_miniatures.length == _miniaturesToLoad/2){
                        posX = 115;
                    } else {
                        posX += 196;
                    }
                    posY = 377;
                } else {
                    if(_miniatures.length != 0){
                        posX += 196;
                    }
                }

                var mini:MiniatureVO = new MiniatureVO(page, posX,  posY);
                addChild(mini);

                _miniatures.push(mini);
            }
        }*/
    }

    public function get totalPages():uint {
        return _totalPages;
    }

    public function get miniatures():Array {
        return _miniatures;
    }

    public function get loadedXML():XML {
        return _loadedXML;
    }
}
}
