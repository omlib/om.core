package om;

/**
    Share the same reference (and therefore changes to it) among different places.
**/
abstract Ref<T>(haxe.ds.Vector<T>) {

    public var value(get,set) : T;
    @:to inline function get_value() : T return this[0];
    inline function set_value(v: T) return this[0] = v;

    inline function new() this = new haxe.ds.Vector(1);

    public inline function toString() : String
        return '@['+Std.string(value)+']';

    @:noUsing @:from public static inline function to<A>(v : A) : Ref<A> {
        var r = new Ref();
        r.value = v;
        return r;
    }

}
