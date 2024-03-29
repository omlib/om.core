package om;

import om.error.NotImplemented;
#if neko
import neko.Web;
#elseif php
import php.Web;
#end

using om.StringTools;

class System {

	public static var mobileUserAgents = ['Android','webOS','iPhone','iPad','iPod','BlackBerry','IEMobile','Opera Mini'];

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
		return throw NotImplemented();

		#end
	}

	public static inline function is( name : String ) : Bool {
		return System.name() == name;
	}

	public static inline function getUserAgent() : String {

		#if (neko||php)
		return Sys.getEnv( 'HTTP_USER_AGENT' );

		#elseif js
			#if electron
			return js.Browser.navigator.userAgent;
			#elseif nodejs
			//TODO
			return null;
			#else
			return js.Browser.navigator.userAgent;
			#end

		#elseif doc_gen
		return null;

		#else
		return null;

		#else #error

		#end
	}

	public static inline function isMobile( ?userAgent : String, ?mobileUserAgents : Array<String> ) : Bool {
		#if (electron||nodejs)
		return false;
		#else
		if( userAgent == null ) userAgent = getUserAgent();
		if( mobileUserAgents == null ) mobileUserAgents = System.mobileUserAgents;
		return new EReg( mobileUserAgents.join( '|' ), 'i' ).match( userAgent );
		#end
	}

	#if (sys||nodejs)

	public static function isRaspberryPi() : Bool {
		var modelFile = '/sys/firmware/devicetree/base/model';
		if( !sys.FileSystem.exists( modelFile ) )
			return false;
		return try {
			~/Raspberry/.match( sys.io.File.getContent( modelFile ) );
		} catch(e:Dynamic) {
			false;
		}
	}

	#end

	/*
	public static inline function supportsWindows() : Bool {
		#if electron
		return true;
		#elseif nodejs
		return false;
		#elseif js
		return untyped __js__( "typeof window!='undefined'" );
		#else
		return false;
		#end
	}
	*/

	#if (neko||php) #elseif js

	/*
	public static inline function supportsWindows() : Bool {
		return untyped __js__( "typeof window!='undefined'" );
	}
	*/

	public static inline function getLanguage() : String {
		return untyped window.navigator.language;
	}

	public static inline function supportsCustomElements() : Bool {
	    return js.Syntax.code( '"registerElement" in document' );
	}

    public static inline function supportsFile() : Bool {
		return js.Syntax.code( '!! window.File && !! window.FileReader && !! window.FileList && !! window.Blob' );
	}

	public static inline function supportsFileSystem() : Bool {
		return js.Syntax.code('!! window.File && !! window.FileReader && !! window.FileList && !! window.Blob');
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
		return js.Syntax.code( '"performance" in window' );
	}

	public static function supportsPassive() : Bool  {
		var supports = false;
		try {
			untyped var opts = Object.defineProperty( {}, 'passive', {
				get: function() { supports = true; }
  			});
  			js.Browser.window.addEventListener( "test", null, opts );
		} catch(e:Dynamic) {}
		return supports;
	}

	public static function supportsPointerlock() : Bool {
		try {
			return js.Syntax.code('"pointerLockElement" in document||"mozPointerLockElement" in document||"webkitPointerLockElement" in document');
		} catch(e:Dynamic) {
			return false;
		}
		return true;
	}

	public static inline function supportsRequestAnimationFrame() : Bool {
		return js.Syntax.code('!!window.requestAnimationFrame||!!window.mozRequestAnimationFrame||!!window.webkitRequestAnimationFrame||!!window.oRequestAnimationFrame||!!window.msRequestAnimationFrame');
	}

	public static inline function supportsRequestIdleCallback() : Bool {
		return js.Syntax.code('!!window.requestIdleCallback||!!window.mozRequestIdleCallback||!!window.webkitRequestIdleCallback||!!window.oRequestIdleCallback||!!window.msRequestIdleCallback');
	}

	public static inline function supportsSessionStorage() : Bool {
		try {
			return js.Browser.window.sessionStorage.getItem != null;
		} catch(e:Dynamic) {
			return false;
		}
	}

	public static inline function supportsTemplate() : Bool {
		return js.Syntax.code( '"content" in document.createElement("template")' );
	}

	public static function supportsTouchInput() : Bool {
		try js.Browser.document.createEvent( 'TouchEvent' ) catch(e:Dynamic) {
			return false;
		}
		return true;
	}

	public static inline function supportsUserMedia() : Bool {
		return js.Syntax.code('!!window.navigator.getUserMedia||!!window.navigator.webkitGetUserMedia||!!window.navigator.mozGetUserMedia||!!window.navigator.msGetUserMedia');
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

	public static inline function supportsWebComponents() : Bool {
		return js.Syntax.code("'registerElement' in document");
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
		//return untyped navigator.getVRDisplays != null;
		return js.Syntax.code( '!!navigator.getVRDisplays' );
	}

	public static inline function supportsWorker() : Bool {
		return js.Syntax.code( '!!window.Worker' );
	}

	#end

}
