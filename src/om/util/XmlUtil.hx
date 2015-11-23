package om.util;

class XmlUtil {

	public static function createElement( name : String, ?content : String ) : Xml {
		var x = Xml.createElement( name );
		if( content != null ) x.addChild( Xml.createPCData( content ) );
		return x;
	}

	public static function hasChild( xml : Xml, name : String ) : Bool {
		for( e in xml.elements() )
			if( e.nodeName == name )
				return true;
		return false;
	}

	public static function first( xml : Xml, ?name : String ) : Xml {
		if( name == null )
			return xml.elements().next();
		else {
			for( e in xml.elements() )
				if( e.nodeName == name )
					return e;
		}
		return null;
	}

}
