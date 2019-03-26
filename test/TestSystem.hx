
import om.System;
import utest.Assert.*;

class TestSystem extends utest.Test {

	function test_systemName() {

		var systemName = System.name();

		notNull( systemName );

		/*
		#if electron
		isTrue( System.supportsWindows() );

		#elseif nodejs
		isFalse( System.supportsWindows() );

		#elseif php
		isFalse( System.supportsWindows() );

		#end
		*/
	}
}
