
import utest.Runner;
import utest.ui.Report;

class Unit {

	static function main() {

		var runner = new Runner();

		runner.addCase( new TestAbstractEnumTools() );
		runner.addCase( new TestArrayBufferTools() );
		runner.addCase( new TestArrayTools() );
		runner.addCase( new TestClock() );
		runner.addCase( new TestEmitter() );
		runner.addCase( new TestErrors() );
		runner.addCase( new TestFloatTools() );
		runner.addCase( new TestIntTools() );
		runner.addCase( new TestJson() );
		runner.addCase( new TestMath() );
		runner.addCase( new TestMaybe() );
		runner.addCase( new TestNil() );
		runner.addCase( new TestPath() );
		//runner.addCase( new TestPromise() );
		//runner.addCase( new TestRandom() );
		//runner.addCase( new TestResource() );
		runner.addCase( new TestSemVer() );
		runner.addCase( new TestStringTools() );
		runner.addCase( new TestSystem() );
		runner.addCase( new TestTime() );
		runner.addCase( new TestWorker() );

		#if js
		//runner.addCase( new TestWorker() );
		#end

		var report = Report.create( runner );

		/*
		var report =
			#if js
			if( om.System.hasWindow() ) {
				new utest.ui.text.HtmlReport( runner, true );
			} else {
				Report.create( runner );
			}
			#else
			Report.create( runner );
			#end
			*/

		/*
		report.setHandler(function(e){
			trace(e);
		});
		*/

    	runner.run();
	}

}
