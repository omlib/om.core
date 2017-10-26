package om.error;

/**
	Abstract methods are methods that needs to be implemented in a sub-class.
*/
class AbstractMethod extends om.Error {

	public function new( ?pos : haxe.PosInfos ) {
		super( 'abstract method ${pos.className}.${pos.methodName}()', pos );
	}

}
