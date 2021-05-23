package om;

#if nodejs
@:forward
abstract Performance(js.html.Performance) from js.html.Performance to js.html.Performance {
    @:noDoc public inline function new() this = js.Lib.require('perf_hooks').performance;
}
#elseif js
typedef Performance = js.html.Performance;
#else
#error // TODO
#end
