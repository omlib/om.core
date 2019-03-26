
import om.Json;
import utest.Assert.*;

class TestJson extends utest.Test {

	function test_parse() {
		var o = Json.parse( '{"test":23}' );
		equals( 23, o.test );
	}
}
