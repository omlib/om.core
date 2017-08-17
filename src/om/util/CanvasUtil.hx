package om.util;

#if js

import js.html.CanvasElement;
import js.Browser.window;

class CanvasUtil {

    public static function scaleToScreenDensity( canvas : CanvasElement ) : Float {

        var ratio = window.devicePixelRatio;

        if( ratio > 1 ) {

            var oldWidth = canvas.width;
            var oldHeight = canvas.height;

            canvas.width = Std.int( oldWidth * ratio );
            canvas.height = Std.int( oldHeight * ratio );
            canvas.style.width = oldWidth + 'px';
            canvas.style.height = oldHeight + 'px';
            canvas.getContext2d().scale( ratio, ratio );
        }

        return ratio;
    }

}

#end
