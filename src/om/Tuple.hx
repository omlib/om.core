package om;

/**
	A finite ordered list.

	Tuples are sequences, just like lists, but unlike lists tuples cannot be changed.
*/
typedef Tuple<T0,T1> = Tuple2<T0,T1>;

abstract Tuple1<T0>(T0) from T0 to T0 {

	//public var size(get,never) : Int;
	//inline function get_size() : Int return 1;

	public var _0(get,never) : T0;
	inline function get__0() return this;

	public inline function new( _0 : T0 )
		this = _0;

	@:op(a+b) public inline function with<T1>( v : T1 ) : Tuple2<T0,T1>
		return new Tuple2( _0, v );

	@:from public static inline function fromArray<T>( v : Array<T> ) : Tuple1<T>
		return new Tuple1( v[0] );
}

@:forward(_0,_1)
abstract Tuple2<T0,T1>({_0:T0,_1:T1}) from {_0:T0,_1:T1} to {_0:T0,_1:T1} {

	public var left(get,never) : T0;
	inline function get_left() : T0 return this._0;

	public var right(get,never) : T1;
	inline function get_right() : T1 return this._1;

	public inline function new( _0 : T0, _1 : T1 )
		this = { _0:_0, _1:_1 };

	public inline function dropLeft() : Tuple1<T1>
		return new Tuple1( this._1 );

	public inline function dropRight() : Tuple1<T0>
		return new Tuple1( this._0 );

	public inline function flip() : Tuple2<T1,T0>
		return { _0:this._1, _1:this._0 };

	@:op(a+b) public inline function with<T2>( v : T2 ) : Tuple3<T0,T1,T2>
		return new Tuple3( this._0, this._1, v );

	@:arrayAccess public function get<T>( i : Int ) : T
		return Reflect.field( this, '_'+i );

	@:to public function toArray<T>() : Array<T>
		return [cast(this._0),cast(this._1)];

	@:from public static inline function fromArray<T>( v : Array<T> ) : Tuple2<T,T>
		return new Tuple2( v[0], v[1] );
}

@:forward(_0,_1,_2)
abstract Tuple3<T0,T1,T2>({_0:T0,_1:T1,_2:T2}) from {_0:T0,_1:T1,_2:T2} to {_0:T0,_1:T1,_2:T2} {

	public inline function new( _0 : T0, _1 : T1, _2 : T2 )
		this = { _0:_0, _1:_1, _2:_2 };

	public inline function dropLeft() : Tuple2<T1,T2>
		return new Tuple2( this._1, this._2 );

	public inline function dropRight() : Tuple2<T0,T1>
		return new Tuple2( this._0, this._1 );

	public inline function flip() : Tuple3<T2,T1,T0>
		return { _0:this._2, _1:this._1, _2:this._0 };

	@:op(a+b) public inline function with<T3>( v : T3 ) : Tuple4<T0,T1,T2,T3>
		return new Tuple4( this._0, this._1, this._2, v );

	@:arrayAccess public function get<T>( i : Int ) : T
		return Reflect.field( this, '_'+i );

	@:to public function toArray<T>() : Array<T>
		return [cast(this._0),cast(this._1),cast(this._2)];

	@:from public static inline function fromArray<T>( v : Array<T> ) : Tuple3<T,T,T>
		return new Tuple3( v[0], v[1], v[2] );
}

@:forward(_0,_1,_2,_3)
abstract Tuple4<T0,T1,T2,T3>({_0:T0,_1:T1,_2:T2,_3:T3}) from {_0:T0,_1:T1,_2:T2,_3:T3} to {_0:T0,_1:T1,_2:T2,_3:T3} {

	public inline function new( _0 : T0, _1 : T1, _2 : T2, _3 : T3 )
		this = { _0:_0, _1:_1, _2:_2, _3:_3 };

	public inline function dropLeft() : Tuple3<T1,T2,T3>
		return new Tuple3( this._1, this._2, this._3 );

	public inline function dropRight() : Tuple3<T0,T1,T2>
		return new Tuple3( this._0, this._1, this._2 );

	public inline function flip() : Tuple4<T3,T2,T1,T0>
		return { _0:this._3, _1:this._2, _2:this._1, _3:this._0 };

	@:op(a+b) public inline function with<T4>( v : T4 ) : Tuple5<T0,T1,T2,T3,T4>
		return new Tuple5( this._0, this._1, this._2, this._3, v );

	@:arrayAccess public function get<T>( i : Int ) : T
		return Reflect.field( this, '_'+i );

	@:to public function toArray<T>() : Array<T>
		return [cast(this._0),cast(this._1),cast(this._2),cast(this._3)];

	@:from public static inline function fromArray<T>( v : Array<T> ) : Tuple4<T,T,T,T>
		return new Tuple4( v[0], v[1], v[2], v[3] );
}

@:forward(_0,_1,_2,_3,_4)
abstract Tuple5<T0,T1,T2,T3,T4>({_0:T0,_1:T1,_2:T2,_3:T3,_4:T4}) from {_0:T0,_1:T1,_2:T2,_3:T3,_4:T4} to {_0:T0,_1:T1,_2:T2,_3:T3,_4:T4} {

	public inline function new( _0 : T0, _1 : T1, _2 : T2, _3 : T3, _4 : T4 )
		this = { _0:_0, _1:_1, _2:_2, _3:_3, _4:_4 };

	public inline function dropLeft() : Tuple4<T1,T2,T3,T4>
		return new Tuple4( this._1, this._2, this._3, this._4 );

	public inline function dropRight() : Tuple4<T0,T1,T2,T3>
		return new Tuple4( this._0, this._1, this._2, this._3 );

	public inline function flip() : Tuple5<T4,T3,T2,T1,T0>
		return { _0:this._4, _1:this._3, _2:this._2, _3:this._1, _4:this._0 };

	@:arrayAccess public function get<T>( i : Int ) : T
		return Reflect.field( this, '_'+i );

	@:to public function toArray<T>() : Array<T>
		return [cast(this._0),cast(this._1),cast(this._2),cast(this._3),cast(this._4)];

	@:from public static inline function fromArray<T>( v : Array<T> ) : Tuple5<T,T,T,T,T>
		return new Tuple5( v[0], v[1], v[2], v[3], v[4] );
}
