package om.error;

class FileNotFound extends om.Error {

	public var path(default,null) : String;

	public function new( path : String, ?pos : haxe.PosInfos ) {
        super( 'file not found: $path', pos );
		this.path = path;
	}
}
