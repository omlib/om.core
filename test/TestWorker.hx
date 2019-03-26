
import om.Worker;
import utest.Assert.*;

class TestWorker extends utest.Test {

	#if (js&&!nodejs)

	function test_fromScript() {
		var done = Assert.createAsync();
		var worker = Worker.fromScript( 'onmessage=function(e){postMessage(e.data);}' );
		worker.onmessage = function(e) {
			equals( 666, e.data );
			done();
		}
		worker.post( 666 );
	}

	#end

}
