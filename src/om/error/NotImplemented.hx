package om.error;

class NotImplemented extends ErrorType {

    public function new( ?pos : haxe.PosInfos ) {
        super( '${pos.className}.${pos.methodName}() not implemented', pos );
    }

}
