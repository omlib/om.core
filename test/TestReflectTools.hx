import utest.Assert.*;
import om.ReflectTools;

class TestReflectTools extends utest.Test {
	function test_copyFieldsTo() {
		var a = {x: 0, y: 1, z: "abc"};
		var b = {x: 10, y: 11, z: "xyz"};
		var c = ReflectTools.copyFieldsTo(a, b);
		equals(a.x, c.x);
		equals(a.y, c.y);
		equals(a.z, c.z);
	}

	function test_copyFieldsFrom() {
		var a = {x: 0, y: 1, z: "abc"};
		var b = {x: 10, y: 11, z: "xyz"};
		var c = ReflectTools.copyFieldsFrom(a, b);
		equals(b.x, c.x);
		equals(b.y, c.y);
		equals(b.z, c.z);
	}

	function test_createCopy() {
		var a = {x: 0, y: 1, z: "abc"};
		var b = ReflectTools.createCopy(a);
		equals(a.x, b.x);
		equals(a.y, b.y);
		equals(a.z, b.z);
	}
}
