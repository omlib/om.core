package om;

#if (js&&!nodejs)
import js.Browser.document;
import js.Browser.navigator;
import js.Browser.window;
#end

using om.util.StringUtil;

class System {

	/**
		Returns the name of the operating system (crossplatform).
	*/
	public static
	#if (!js||nodejs) inline #end
	function name() : String {

		#if sys
		return Sys.systemName().toLowerCase();

		//#elseif nodejs
		//return js.Node.process.platform;

		#elseif flash
		return flash.system.Capabilities.os;

		#elseif js
		var str = js.Browser.window.navigator.appVersion;
		str = str.substr( str.indexOf("(")+1, str.indexOf(")")-3 );

		return
			if( str.contains( 'Linux' ) ) 'linux';
			else if( str.contains( 'BSD' ) ) 'bsd';
			else if( str.contains( 'Macintosh' ) ) 'macintosh';
			else if( str.contains( 'Windows' ) ) 'windows';
			else null;

		#end
	}

	#if (js&&!nodejs)

	public static function isMobile() : Bool {
        return ~/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.match( navigator.userAgent );
    }

    public static inline function detectFile() : Bool {
		return untyped __js__( '!! window.File && !! window.FileReader && !! window.FileList && !! window.Blob' );
	}

	public static inline function detectFileSystem() : Bool {
		return untyped __js__('!! window.File && !! window.FileReader && !! window.FileList && !! window.Blob');
	}

	public static inline function detectGamepad() : Bool {
		return untyped !!navigator.webkitGetGamepads || !!navigator.webkitGamepads || !!navigator.getGamepads;
	}

	public static function detectPointerlock() : Bool {
		try {
			return untyped __js__('"pointerLockElement" in document||"mozPointerLockElement" in document||"webkitPointerLockElement" in document');
		} catch(e:Dynamic) {
			return false;
		}
		return true;
	}

	public static inline function detectRequestAnimationFrame() : Bool {
		return untyped __js__('!! window.mozRequestAnimationFrame || !! window.webkitRequestAnimationFrame || !! window.oRequestAnimationFrame || !! window.msRequestAnimationFrame');
	}

	public static inline function detectSessionStorage() : Bool {
		try {
			return window.sessionStorage.getItem != null;
		} catch(e:Dynamic) {
			return false;
		}
	}

	public static inline function detectUserMedia() : Bool {
		return untyped __js__('!! window.navigator.getUserMedia || !! window.navigator.webkitGetUserMedia || !! window.navigator.mozGetUserMedia || !! window.navigator.msGetUserMedia');
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

	public static inline function detectWorker() : Bool {
		return untyped __js__( '!! window.Worker' );
	}

	#end

}
