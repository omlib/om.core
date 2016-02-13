package om;

import js.Browser.navigator;

class System {

    public static inline function getLanguage() : String {
		return untyped window.navigator.language;
	}

    public static function getOS() : String {
        var expr = ~/(Android|CrOS|iP[ao]d|iPhone|Linux|Mac OS|windows)/i;
        return expr.match( navigator.userAgent ) ? expr.matched(1) : "unknown";
    }

    public static function isMobile() : Bool {
        return ~/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.match( navigator.userAgent );
    }

    public static function detectWebAudio() : Bool {
		try {
			if( untyped window.AudioContext == null ) //|| window.webkitAudioContext || window.mozAudioContext )
				return false;
		} catch(e:Dynamic) {
			return false;
		}
		return true;
	}

    public static function detectWebGL() : Bool {
		try {
			if( untyped window.WebGLRenderingContext == null )
                return false;
			if( document.createCanvasElement().getContextWebGL() == null )
                return false;
		} catch(e:Dynamic) {
			return false;
		}
		return true;
	}

	public static function detectPointerlock() : Bool {
		try {
			return untyped __js__('"pointerLockElement" in document||"mozPointerLockElement" in document||"webkitPointerLockElement" in document');
		} catch(e:Dynamic) {
			return false;
		}
		return true;
	}

    public static inline function detectSessionStorage() : Bool {
		try {
			return window.sessionStorage.getItem != null;
		} catch(e:Dynamic) {
			return false;
		}
	}

    public static inline function detectGamepad() : Bool {
		return untyped !!navigator.webkitGetGamepads || !!navigator.webkitGamepads || !!navigator.getGamepads;
	}

    public static inline function detectFile() : Bool {
		return untyped __js__('!! window.File && !! window.FileReader && !! window.FileList && !! window.Blob');
	}

	public static inline function detectFileSystem() : Bool {
		return untyped __js__('!! window.File && !! window.FileReader && !! window.FileList && !! window.Blob');
	}

	public static inline function detectUserMedia() : Bool {
		return untyped __js__('!! window.navigator.getUserMedia || !! window.navigator.webkitGetUserMedia || !! window.navigator.mozGetUserMedia || !! window.navigator.msGetUserMedia');
	}

	public static inline function detectRequestAnimationFrame() : Bool {
		return untyped __js__('!! window.mozRequestAnimationFrame || !! window.webkitRequestAnimationFrame || !! window.oRequestAnimationFrame || !! window.msRequestAnimationFrame');
	}

	public static inline function detectWorker() : Bool {
		return untyped __js__( '!! window.Worker' );
	}
}
