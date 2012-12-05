package be.devine.cp3.vo {
import flash.display.Loader;
import flash.events.Event;

public class MiniatureVO {
    [Embed(source="/assets/pattern.png")]
    public static const PatternImage:Class;

    public function MiniatureVO(page:XML) {

    }

    private function imageLoadedHandler(e:Event):void{

    }
}
}
