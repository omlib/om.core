package om;

using om.util.StringUtil;

class System {

	public static var mobileUserAgents = ['Android','webOS','iPhone','iPad','iPod','BlackBerry','IEMobile','Opera Mini'];

	/**
		Returns the name of the operating system (crossplatform).
	*/
	public static #if (!js||nodejs) inline #end function name() : String {

		#if sys
		return Sys.systemName().toLowerCase();

		#elseif nodejs
		return js.Node.process.platform;

		#elseif js
		var str = js.Browser.window.navigator.appVersion;
		str = str.substr( str.indexOf("(")+1, str.indexOf(")")-3 );
		return
			if( str.contains( 'Linux' ) ) 'linux';
			else if( str.contains( 'BSD' ) ) 'bsd';
			else if( str.contains( 'Macintosh' ) ) 'macintosh';
			else if( str.contains( 'Windows' ) ) 'windows';
			else null;

		#elseif flash
		return flash.system.Capabilities.os;

		#else
		return throw new om.error.NotImplemented();

		#end
	}

	#if js

	public static inline function hasWindow() : Bool {
		return untyped __js__( "typeof window!='undefined'" );
	}

	#if (electron||nodejs)

	public static inline function isMobile() : Bool {
		return false;
	}

	#else

	public static function isMobile( ?userAgent : String, ?mobileUserAgents : Array<String> ) : Bool {
		if( userAgent == null ) userAgent = js.Browser.navigator.userAgent;
		if( mobileUserAgents == null ) mobileUserAgents = System.mobileUserAgents;
		return new EReg( mobileUserAgents.join( '|' ), 'i' ).match( userAgent );
	}

	#end

	public static inline function getLanguage() : String {
		return untyped window.navigator.language;
	}

	public static inline function supportsCustomElements() : Bool {
	    return untyped __js__( '"registerElement" in document' );
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

	public static inline function supportsGeolocation() : Bool {
		return js.Browser.navigator.geolocation != null;
	}

	public static inline function supportsMIDI() : Bool {
		return untyped navigator.requestMIDIAccess != null;
	}

	public static inline function supportsPerformance() : Bool {
		return untyped __js__( '"performance" in window' );
	}

	public static function supportsPassive() : Bool  {
		var supported = false;
		try {
			untyped var opts = Object.defineProperty( {}, 'passive', {
				get: function() { supported = true; }
  			});
  			js.Browser.window.addEventListener( "test", null, opts );
		} catch(e:Dynamic) {}
		return supported;
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
			return js.Browser.window.sessionStorage.getItem != null;
		} catch(e:Dynamic) {
			return false;
		}
	}

	public static inline function supportsTemplate() : Bool {
		return untyped __js__( '"content" in document.createElement("template")' );
	}

	public static function supportsTouchInput() : Bool {
		try js.Browser.document.createEvent( 'TouchEvent' ) catch(e:Dynamic) {
			return false;
		}
		return true;
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
			if( js.Browser.document.createCanvasElement().getContextWebGL() == null )
				return false;
		} catch(e:Dynamic) {
			return false;
		}
		return true;
	}

	public static inline function supportsWebVR() : Bool {
		return untyped navigator.getVRDisplays != null;
	}

	public static inline function supportsWorker() : Bool {
		return untyped __js__( '!!window.Worker' );
	}

	#end

}
