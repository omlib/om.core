package om.error;

class AbstractMethod extends om.Error {

	public inline function new( ?pos : haxe.PosInfos ) {
		super( 'abstract method', pos );
	}
}
