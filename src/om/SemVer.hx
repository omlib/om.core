package om;

// Fork of haxelib implementation

import haxe.ds.Option;
import om.macro.Validator;
import om.macro.Validator.Validatable;

using Std;

enum Preview {
	ALPHA;
	BETA;
	RC;
}

typedef SemVerData =  {
	major : Int,
	minor : Int,
	patch : Int,
	preview : Null<Preview>,
	previewNum : Null<Int>,
}

/**
	Semantic Versioning – https://semver.org/

	Given a version number MAJOR.MINOR.PATCH, increment the:
	- MAJOR version when you make incompatible API changes,
	- MINOR version when you add functionality in a backwards-compatible manner, and
	- PATCH version when you make backwards-compatible bug fixes.
	Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.
**/
abstract SemVer(String) to String {

	public static var DEFAULT(default,null) = new SemVer('0.0.0');
	public static var FORMAT = ~/^(\d|[1-9]\d*)\.(\d|[1-9]\d*)\.(\d|[1-9]\d*)(-(alpha|beta|rc)(\.(\d|[1-9]\d*))?)?$/;

	static var cache = new Map();

	public static function isValid( s : String ) : Bool {
		return Std.is( s, String ) && FORMAT.match( s.toLowerCase() );
	}

	public static function ofString( s : String ) : SemVer {
		var v = new SemVer(s);
		v.getData();
		return v;
	}

	public static function compare( a : SemVer, b : SemVer ) {
		function toArray(data:SemVerData)
			return [
				data.major,
				data.minor,
				data.patch,
				if (data.preview == null) 100 else data.preview.getIndex(),
				if (data.previewNum == null) -1 else data.previewNum
			];
		var a = toArray(a.data),
			b = toArray(b.data);
		for (i in 0...a.length)
			switch Reflect.compare(a[i], b[i]) {
				case 0:
				case v: return v;
			}
		return 0;
	}

	@:from static inline function fromString( s : String ) : SemVer {
		return SemVer.ofString( s );
	}

	@:from static function fromData( data : SemVerData ) {
		return new SemVer(
			data.major + '.' + data.minor + '.' + data.patch +
				if (data.preview == null) ''
				else '-' + data.preview.getName().toLowerCase() +
					if (data.previewNum == null) '';
					else '.' + data.previewNum
		);
	}

	@:op(a > b) static inline function gt(a:SemVer, b:SemVer)
		return compare(a, b) == 1;

	@:op(a >= b) static inline function gteq(a:SemVer, b:SemVer)
		return compare(a, b) != -1;

	@:op(a < b) static inline function lt(a:SemVer, b:SemVer)
		return compare(a, b) == -1;

	@:op(a <= b) static inline function lteq(a:SemVer, b:SemVer)
		return compare(a, b) != 1;

	@:op(a == b) static inline function eq(a:SemVer, b:SemVer)
		return compare(a, b) == 0;

	@:op(a != b) static inline function neq(a:SemVer, b:SemVer)
		return compare(a, b) != 0;

	public var major(get,never):Int;
	public var minor(get,never):Int;
	public var patch(get,never):Int;
	public var preview(get,never):Null<Preview>;
	public var previewNum(get,never):Null<Int>;
	public var data(get,never):SemVerData;
	public var valid(get,never):Bool;

	inline function new( s ) this = s;

	@:to public function toValidatable() : Validatable {
		return {
			validate:
				function() : Option<String> {
					return
						try {
							get_data();
							None;
						} catch (e:Dynamic) {
							Some(Std.string(e));
						}
				}
			}
	}

	inline function get_major()
		return data.major;

	inline function get_minor()
		return data.minor;

	inline function get_patch()
		return data.patch;

	inline function get_preview()
		return data.preview;

	inline function get_previewNum()
		return data.previewNum;

	inline function get_valid()
		return isValid( this );

	@:to function get_data() : SemVerData {
		if( !cache.exists( this ) ) cache[this] = getData();
		return cache[this];
	}

	function getData() : SemVerData {
		return if( valid ) { //RAPTORS: This query will already cause the matching.
			major: FORMAT.matched(1).parseInt(),
			minor: FORMAT.matched(2).parseInt(),
			patch: FORMAT.matched(3).parseInt(),
			preview:
				switch FORMAT.matched(5) {
					case 'alpha': ALPHA;
					case 'beta': BETA;
					case 'rc': RC;
					case v if (v == null): null;
					case v: throw 'unrecognized preview tag $v';
				},
			previewNum:
				switch FORMAT.matched(7) {
					case null: null;
					case v: v.parseInt();
				}
		} else
			throw '$this is not a valid version string';//TODO: include some URL for reference
	}

}
