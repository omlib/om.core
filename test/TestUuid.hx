import om.Uuid;
import utest.Assert.*;

class TestUuid extends utest.Test {
	function test_create() {
		var uuid = Uuid.create();
		isTrue(Uuid.isValid(uuid));
	}

	function test_rstring() {
		var s = Uuid.rstring(128);
		equals(128, s.length);
		notEquals(Uuid.rstring(128), Uuid.rstring(128));
	}
}
