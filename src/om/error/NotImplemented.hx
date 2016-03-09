package om.error;

class NotImplemented extends om.Error {

    public inline function new( ?pos : haxe.PosInfos ) {
        super( "'"+pos.methodName+"' not implemented", pos );
    }
}
