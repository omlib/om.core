
import om.AbstractEnumTools;
import utest.Assert.*;

private enum abstract MyEnum1(Int) {
	var A = 1;
	var B = 2;
	var C = 3;
}

private enum abstract MyEnum2(String) {
	var A;
	var B;
	var C;
}

private enum abstract MyEnum3(String) {
	var A = "a";
	var B = "b";
	var C = "c";
	var D = "d";
}

class TestAbstractEnumTools extends utest.Test {

	function test_getNames() {

	 	var names = AbstractEnumTools.getNames( MyEnum1 );
		equals( 3, names.length );
		equals( 'A', names[0] );
		equals( 'B', names[1] );
		equals( 'C', names[2] );

		var names = AbstractEnumTools.getNames( MyEnum2 );
		equals( 3, names.length );
		equals( 'A', names[0] );
		equals( 'B', names[1] );
		equals( 'C', names[2] );

		var names = AbstractEnumTools.getNames( MyEnum3 );
		equals( 4, names.length );
		equals( 'A', names[0] );
		equals( 'B', names[1] );
		equals( 'C', names[2] );
		equals( 'D', names[3] );
	}

	function test_getValues() {

	 	var values = AbstractEnumTools.getValues( MyEnum1 );
		equals( 3, values.length );
		equals( 1, values[0] );
		equals( 2, values[1] );
		equals( 3, values[2] );

		var values = AbstractEnumTools.getValues( MyEnum2 );
		equals( 3, values.length );
		equals( "A", values[0] );
		equals( "B", values[1] );
		equals( "C", values[2] );

		var values = AbstractEnumTools.getValues( MyEnum3 );
		equals( 4, values.length );
		equals( "a", values[0] );
		equals( "b", values[1] );
		equals( "c", values[2] );
		equals( "d", values[3] );
	}

	function test_count() {
		equals( 3, AbstractEnumTools.count( MyEnum1 ) );
		equals( 3, AbstractEnumTools.count( MyEnum2 ) );
		equals( 4, AbstractEnumTools.count( MyEnum3 ) );
	}

	function test_toMap() {

		var map = AbstractEnumTools.toMap( MyEnum1 );

		equals( 3, Lambda.count( map ) );
		equals( 1, map.get('A') );
		equals( 2, map.get('B') );
		equals( 3, map.get('C') );
	}

}
