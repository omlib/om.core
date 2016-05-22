package om.error;

class FileNotFound extends om.Error {

	public var location(default,null) : String;

	public function new( location : String, ?pos : haxe.PosInfos ) {
        super( 'not found', pos );
		this.location = location;
	}
}
