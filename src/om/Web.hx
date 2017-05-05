package om;

class Web {

	/**
	*/
	public static inline function flush() {

		#if neko
		neko.Web.flush();

		#elseif php
		php.Web.flush();

		#else throw 'not implemented';
		#end
	}

	/**
	*/
	public static inline function getClientIP() : String {

		#if neko
		return neko.Web.getClientIP();

		#elseif php
		return php.Web.getClientIP();
		/*
		var ip = php.Web.getClientIP();
		return switch ip {
			case: '::1': 'localhost';
			default: ip;
		}
		*/

		#else throw 'not implemented';
		#end
	}

	public static inline function getHostName() : String {

		#if neko
		return neko.Web.getHostName();

		#elseif php
		return php.Web.getHostName();

		#elseif python
		//TODO this is by no means safe
		return python.lib.Os.environ.get( 'HOST' );
		//return python.lib.Os.uname()[1];
		//return new python.lib.net.Socket().getsockname()._1;

		#elseif nodejs
		return js.node.Os.hostname();

		#elseif js
		return js.Browser.location.host;

		#else throw 'not implemented';
		#end
	}

	/**
	*/
	public static inline function getParams() : Map<String,String> {

		#if neko
		return neko.Web.getParams();

		#elseif php
		return php.Web.getParams();

		#elseif js
		var str : String = js.Browser.location.search.substr(1);
		var params = new haxe.ds.StringMap();
		for( p in ~/[&;]/g.split( str ) ) {
			var pl = p.split( "=" );
			if( pl.length < 2 )
				continue;
			var name = pl.shift();
			params.set( StringTools.urlDecode( name ), StringTools.urlDecode( pl.join( "=" ) ) );
		}
		return params;

		#else throw 'not implemented';
		#end
	}

	public static inline function getParamValues( param : String ) : Array<String> {

		#if neko
		return neko.Web.getParamValues( param );

		#elseif php
		return php.Web.getParamValues( param );

		#else throw 'not implemented';
		#end
	}

	/**
	*/
	public static inline function getURI() : String {

		#if neko
		return neko.Web.getURI();

		#elseif php
		return php.Web.getURI();

		#elseif js
		return js.Browser.location.pathname;

		#else throw 'not implemented';
		#end
	}

	/**
	*/
	public static inline function getUserAgent() : String {

		#if neko
		return neko.Web.getClientHeader( 'USER_AGENT' );

		#elseif php
		return php.Web.getClientHeader( 'USER_AGENT' );

		#else throw 'not implemented';
		#end
	}

	//public static function isMobile( ?userAgent : String, ?extraUserAgents : Array<String> ) : Bool {

	/**
	*/
	public static function isMobile( ?userAgent : String ) : Bool {

		if( userAgent == null ) userAgent = getUserAgent();

		if( ~/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i.match( userAgent ) )
			return true;

		if( ~/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.match( userAgent.substr(0,4) ) )
			return true;

		return false;
	}

	#if sys

	public static inline function getClientHeader( k : String ) : String {

		#if neko
		return neko.Web.getClientHeader( k );

		#elseif php
		return php.Web.getClientHeader( k );

		#else throw 'not implemented';
		#end
	}

	public static inline function redirect( url : String ) {

		#if neko
		neko.Web.redirect( url );

		#elseif php
		php.Web.redirect( url );

		#else throw 'not implemented';
		#end
	}

	public static inline function setHeader( h : String, v : String ) {

		#if neko
		neko.Web.setHeader( h, v );

		#elseif php
		php.Web.setHeader( h, v );

		#else throw 'not implemented';
		#end
	}

	public static inline function setReturnCode( r : Int ) {

		#if neko
		neko.Web.setReturnCode( r );

		#elseif php
		php.Web.setReturnCode( r );

		#else throw 'not implemented';
		#end
	}

	#end

}