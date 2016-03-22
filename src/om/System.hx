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

		#elseif nodejs
		return js.Node.process.platform;

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

	public static var mobileUserAgents = ['Android','webOS','iPhone','iPad','iPod','BlackBerry','IEMobile','Opera Mini'];

	public static function isMobile( ?userAgent : String, ?mobileUserAgents : Array<String> ) : Bool {
		if( userAgent == null ) userAgent = navigator.userAgent;
		if( mobileUserAgents == null ) mobileUserAgents = System.mobileUserAgents;
		return new EReg( mobileUserAgents.join( '|' ), 'i' ).match( userAgent );
    }

    public static inline function supportsFile() : Bool {
		return untyped __js__( '!! window.File && !! window.FileReader && !! window.FileList && !! window.Blob' );
	}

	public static inline function supportsFileSystem() : Bool {
		return untyped __js__('!! window.File && !! window.FileReader && !! window.FileList && !! window.Blob');
	}

	public static inline function supportsGamepad() : Bool {
		return untyped !!navigator.webkitGetGamepads || !!navigator.webkitGamepads || !!navigator.getGamepads;
	}

	public static function supportsPointerlock() : Bool {
		try {
			return untyped __js__('"pointerLockElement" in document||"mozPointerLockElement" in document||"webkitPointerLockElement" in document');
		} catch(e:Dynamic) {
			return false;
		}
		return true;
	}

	public static inline function supportsRequestAnimationFrame() : Bool {
		return untyped __js__('!! window.mozRequestAnimationFrame || !! window.webkitRequestAnimationFrame || !! window.oRequestAnimationFrame || !! window.msRequestAnimationFrame');
	}

	public static inline function supportsSessionStorage() : Bool {
		try {
			return window.sessionStorage.getItem != null;
		} catch(e:Dynamic) {
			return false;
		}
	}

	public static inline function supportsTouchInput() : Bool {
		try {
			document.createEvent( 'TouchEvent' );
			return true;
		} catch(e:Dynamic) {
			return false;
		}
	}

	public static inline function supportsUserMedia() : Bool {
		return untyped __js__('!! window.navigator.getUserMedia || !! window.navigator.webkitGetUserMedia || !! window.navigator.mozGetUserMedia || !! window.navigator.msGetUserMedia');
	}

	public static function supportsWebAudio() : Bool {
		try {
			if( untyped window.AudioContext == null ) //|| window.webkitAudioContext || window.mozAudioContext )
				return false;
		} catch(e:Dynamic) {
			return false;
		}
		return true;
	}

	public static function supportsWebGL() : Bool {
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

	public static inline function supportsWorker() : Bool {
		return untyped __js__( '!! window.Worker' );
	}

	#end

}
