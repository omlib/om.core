package om;

#if js
@:forward
abstract Performance(js.html.Performance) from js.html.Performance to js.html.Performance {
    @:noDoc public inline function new()
        this =
            #if nodejs
            js.Lib.require('perf_hooks').performance;
            #else
            js.Browser.window.performance;
            #end
}
#else
#error // TODO
#end
