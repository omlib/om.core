package om.error;

class InvalidFormat extends ErrorType {

	public function new( format : String, ?info : String, ?pos : haxe.PosInfos ) {
		var msg = 'invalid $format';
		if( info != null ) msg += ': $info';
		super( msg, pos );
	}

}
