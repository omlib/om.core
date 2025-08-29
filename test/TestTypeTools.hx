import om.TypeTools;
import utest.Assert.*;

private class MyClass {
	public function new() {}
}

private enum MyEnum {
	A;
	B;
}

private typedef MyTypedef = {
	var some:String;
}

class TestTypeTools extends utest.Test {
	function test_primitive() {
		isTrue(TypeTools.isPrimitive(true));
		isTrue(TypeTools.isPrimitive(23));
		isTrue(TypeTools.isPrimitive(1.23));
		isTrue(TypeTools.isPrimitive("disktree"));
		isTrue(TypeTools.isPrimitive(Date.now()));
		isFalse(TypeTools.isPrimitive(new MyClass()));
		isFalse(TypeTools.isPrimitive(MyClass));
		isFalse(TypeTools.isPrimitive(MyEnum));
		isFalse(TypeTools.isPrimitive(MyEnum.A));
	}

	function test_enum() {
		isTrue(TypeTools.isEnumValue(MyEnum.A));
		isFalse(TypeTools.isEnumValue(MyEnum));
		isFalse(TypeTools.isEnumValue(23));
		isFalse(TypeTools.isEnumValue(MyClass));
		isFalse(TypeTools.isEnumValue(new MyClass()));
	}

	function test_object() {
		isTrue(TypeTools.isObject({}));
		isFalse(TypeTools.isEnumValue(new MyClass()));
	}

	function test_anonymous_object() {
		isTrue(TypeTools.isAnonymousObject({}));
		var t:MyTypedef = {some: "test"};
		isTrue(TypeTools.isAnonymousObject(t));
		isFalse(TypeTools.isAnonymousObject(new MyClass()));
	}
}
