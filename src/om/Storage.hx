package om;

#if js

private enum abstract StorageType(Bool) to Bool {
	var local = true;
	var session = false;
}

private class TStorage {

	public var prefix(default,set) : String;
	inline function set_prefix(v:String) return prefix = (v == null) ? '' : v;

	public var length(get,null) : Int;
    inline function get_length() return s.length;

	var s : js.html.Storage;

	public function new( type = StorageType.local, prefix = '' ) {
		this.prefix = prefix;
		s = type ? Browser.window.localStorage : Browser.window.sessionStorage;
	}

	public inline function key( i : Int ) : String
		return s.key( i ).substr( prefix.length );

	public inline function get( key : String ) : String
		return s.getItem( prefix + key );

	public inline function set( key : String, value : String )
		s.setItem( prefix + key, value );

	public inline function remove( key : String )
		s.removeItem( prefix + key );

	public inline function clear()
		s.clear();
}

/**
	@see https://developer.mozilla.org/en-US/docs/Web/API/Storage
**/
@:forward
abstract Storage(TStorage) {

	public inline function new( type = StorageType.local, prefix = '' )
		this = new TStorage( type, prefix );

	@:arrayAccess public inline function key( i : Int ) : String
		return this.key( i );

	@:arrayAccess public inline function get( key : String ) : String
		return this.get( key );

	@:arrayAccess public inline function set( key : String, value : String )
		return this.set( key, value );

	public inline function exists( key : String ) : Bool
		return this.get( key ) != null;

	public inline function keys() : Array<String>
		return [for(i in 0...this.length) key(i)];

	public inline function values() : Array<String>
		return [for(i in 0...this.length) get( key(i) )];

	public function keyValueIterator() : KeyValueIterator<String,String> {
		return [for(i in 0...this.length) {
			var k = key(i);
			k => get( k );
		}].keyValueIterator();
	}
}

#end
