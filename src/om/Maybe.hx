package om;

/**
	Null safety.

	@see: https://code.haxe.org/category/principles/null-safety.html
**/
abstract Maybe<T>(Null<T>) from Null<T> {
	/**
	**/
	public inline function exists():Bool
		return this != null;

	/**
		Get value or raise exception
	**/
	public inline function sure():T
		return exists() ? this : throw "No value";

	/**
	**/
	public inline function or(def:T):T
		return exists() ? this : def;

	/**
	**/
	public inline function may(fn:T->Void):Void
		return if (exists()) fn(this);

	/**
	**/
	public inline function map<S>(fn:T->S):Maybe<S>
		return exists() ? fn(this) : null;

	/**
	**/
	public inline function mapDefault<S>(fn:T->S, def:S):S
		return exists() ? fn(this) : def;
}
