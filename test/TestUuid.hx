import om.UUID;
import utest.Assert.*;

class TestUuid extends utest.Test {
	function test_create() {
		var uuid = UUID.create();
		isTrue(UUID.isValid(uuid));
	}

	function test_rstring() {
		var s = UUID.rstring(128);
		equals(128, s.length);
		notEquals(UUID.rstring(128), UUID.rstring(128));
	}
}
