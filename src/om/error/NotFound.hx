package om.error;

class NotFound extends ErrorType {

	public var location(default,null) : String;

	public function new( location : String, ?pos : haxe.PosInfos ) {
        super( '$location not found', pos );
		this.location = location;
	}
}
