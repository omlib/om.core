package om.error;

class NotImplemented extends om.Error {

    public function new( ?pos : haxe.PosInfos ) {
        super( '${pos.className}.${pos.methodName}() not implemented', pos );
    }

}
