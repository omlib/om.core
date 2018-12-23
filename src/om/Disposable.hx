package om;

/**
	A handle to a resource that can be disposed.
**/
interface Disposable {

	/**
		Perform the disposal action, indicating that the resource associated with this disposable is no longer needed.
	**/
    function dispose() : Void;
}
