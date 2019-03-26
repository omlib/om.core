
import om.Error;
import om.error.*;
import utest.Assert.*;

class TestErrors extends utest.Test {

	function test_AbstractMethod() {
		var e = new AbstractMethod();
		equals( 'AbstractMethod', e.name );
		equals( 'test/TestErrors.hx', e.fileName );
		equals( 9, e.lineNumber );
		equals( 'abstract method TestErrors.test_AbstractMethod()', e.message );
	}

	function test_FileNotFound() {
		var e = new FileNotFound( '/some/path' );
		equals( 'FileNotFound', e.name );
		equals( 'test/TestErrors.hx', e.fileName );
		equals( 17, e.lineNumber );
		equals( '/some/path not found', e.message );
	}

	function test_InvalidFormat() {
		var e = new InvalidFormat( 'markdown', 'additional info' );
		equals( 'InvalidFormat', e.name );
		equals( 'test/TestErrors.hx', e.fileName );
		equals( 25, e.lineNumber );
		equals( "invalid markdown: additional info", e.message );
	}

	function test_NotImplemented() {
		var e = new NotImplemented();
		equals( 'NotImplemented', e.name );
		equals( 'test/TestErrors.hx', e.fileName );
		equals( 33, e.lineNumber );
		//equals( "'test' not implemented", e.message );
	}

	function test_NullArgument() {
		var e = new NullArgument();
		equals( 'NullArgument', e.name );
		equals( 'test/TestErrors.hx', e.fileName );
		equals( 41, e.lineNumber );
		equals( null, e.message );
	}

	function test_SyntaxError() {
		var e = new SyntaxError( 'mymessage' );
		equals( 'SyntaxError', e.name );
		equals( 'test/TestErrors.hx', e.fileName );
		equals( 49, e.lineNumber );
		equals( 'mymessage', e.message );
	}

}
