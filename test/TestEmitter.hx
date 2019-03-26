
import om.Emitter;
import utest.Assert.*;

class TestEmitter extends utest.Test {

	function test() {

        var e = new Emitter<Dynamic>();
        equals( 0, e.numHandlers );

        //e.on( 'test', h );

        var arr = ['a','b','c'];
        var i = 0;
        e.on( 'test', function(v){
            equals( arr[i], v );
            i++;
        } );
        equals( 1, e.numHandlers );
        for( v in arr ) e.emit( 'test', v );

        //for( h in e ) trace(h);
	}

}
