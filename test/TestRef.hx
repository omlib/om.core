import utest.Assert.*;
import om.Ref;

class TestRef extends utest.Test {
	function test_ref() {
		var r:Ref<Int> = 4;
		equals("@[4]", r.toString());
		equals(4, r.value);
		var r:Ref<String> = "abc";
		equals("@[abc]", r.toString());
		equals("abc", r.value);
	}
}
