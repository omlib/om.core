
import om.Path;
import utest.Assert.*;

class TestPath extends utest.Test {

	function test_construct() {

		var path = new Path( '/home/user' );

		equals( '/home', path.dir );
		equals( 'user', path.file );
		equals( null, path.ext );


		//var path : Path = '/home/user';

		//TODO
        //assertEquals( 'home', path[0] );
        //assertEquals( 'user', path[1] );
	}

	function test_toString() {
		var path = new Path( '/home/user' );
		equals( '/home/user', path.toString() );
		equals( '/home/user', (path:String) );
	}
	
	//TODO
	@Ignored
	function test_fromArray() {
		equals( 'home/user', Path.fromArray( ['home','user'] ) );
		equals( '/home/user', Path.fromArray( ['/home','user'] ) );
		equals( '/home/user', Path.fromArray( ['/home','/user'] ) );
		equals( '/home/user', Path.fromArray( ['/home','/user/'] ) );
		equals( '/home/user', Path.fromArray( ['/home','/user////'] ) );
	}

	//TODO
	@Ignored
	function test_fromList() {
		var l = new List<String>();
		l.add('home');
		l.add('user');
		equals( 'home/user', Path.fromList( l ) );

		l = new List<String>();
		l.add('home');
		l.add('/user///');
		equals( 'home/user', Path.fromList( l ) );
	}

	function test_toArray() {

		//TODO remove empty parts ?

		var a = new Path('/home/user').toArray();
		equals( 3, a.length );
		equals( '', a[0] );
		equals( 'home', a[1] );
		equals( 'user', a[2] );

		var a = new Path('/home/user/').toArray();
		equals( 4, a.length );
		equals( '', a[0] );
		equals( 'home', a[1] );
		equals( 'user', a[2] );
		equals( '', a[3] );
	}

	function test_addTrailingSlash() {

		equals( '/home/user/', Path.addTrailingSlash('/home/user') );
		equals( '/home/user/', Path.addTrailingSlash('/home/user/') );

		equals( '/', Path.addTrailingSlash('') );
		equals( 'a/', Path.addTrailingSlash('a') );
	}

	function test_directory() {
		equals( '/home', Path.directory('/home/user') );
	}

	function test_extension() {
		equals( '', Path.extension('file') );
		equals( 'ext', Path.extension('file.ext') );
	}

	// --- Extra methods

	function test_hasExtension() {
		isTrue( Path.hasExtension( 'file.abc' ) );
		isTrue( Path.hasExtension( 'file.abc', 'abc' ) );
		isFalse( Path.hasExtension( 'file' ) );
		isFalse( Path.hasExtension( 'file.abc', 'xyz' ) );
	}

	function test_replaceExtension() {
		equals( 'file.xyz', Path.replaceExtension( 'file.abc', 'xyz' ) );
		equals( 'file', Path.replaceExtension( 'file.abc', null ) );
		raises( () -> Path.replaceExtension( 'file.abc', '' ), 'should throw: invalid extension' );
	}

	//....

	/*
	function test_rel_abs() {
		var rel : Path = "a/b",
        abs : Path = "/a/b";
    	isTrue( ('/a/a':Path).isRelative() );
    	//isFalse(rel.isAbsolute());
    	//isTrue(abs.isAbsolute());
    	//isFalse(abs.isRelative());
	}
	*/

}
