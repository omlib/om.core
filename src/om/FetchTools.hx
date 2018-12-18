package om;

#if js

import haxe.extern.EitherType;
import js.Browser.window;
import js.Promise;
import js.html.ArrayBuffer;
import js.html.Blob;
import js.html.FormData;
import js.html.ImageBitmap;
import js.html.Request;
import js.html.RequestInit;
import js.html.Response;
import js.html.audio.AudioBuffer;
import js.html.audio.AudioContext;

/**
    https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API
**/
class FetchTools {

    public static inline function fetchArrayBuffer( input : EitherType<Request,String>, ?init : RequestInit ) : Promise<ArrayBuffer> {
        return window.fetch( input, init ).then( (r:Response) ->
            return r.arrayBuffer()
        );
    }

    public static inline function fetchAudioBuffer( context : AudioContext, input : EitherType<Request,String>, ?init : RequestInit ) : Promise<AudioBuffer> {
        return fetchArrayBuffer( input, init ).then( buf ->
            return context.decodeAudioData( buf ).then( (ab:AudioBuffer) ->
                return ab
            )
        );
    }

    public static inline function fetchBlob( input : EitherType<Request,String>, ?init : RequestInit ) : Promise<Blob> {
        return window.fetch( input, init ).then( (r:Response) ->
            return r.blob()
        );
    }

    public static inline function fetchFormData( input : EitherType<Request,String>, ?init : RequestInit ) : Promise<FormData> {
        return window.fetch( input, init ).then( (r:Response) ->
            return r.formData()
        );
    }

    public static inline function fetchImageBitmap( input : EitherType<Request,String>, ?init : RequestInit ) : Promise<ImageBitmap> {
        return fetchBlob( input, init ).then( (b:Blob) ->
            return window.createImageBitmap( b )
        );
    }

    public static inline function fetchJson( input : EitherType<Request,String>, ?init : RequestInit ) : Promise<Dynamic> {
        return window.fetch( input, init ).then( (r:Response) ->
            return r.json()
        );
    }

    public static inline function fetchText( input : EitherType<Request,String>, ?init : RequestInit ) : Promise<String> {
        return window.fetch( input, init ).then( (r:Response) ->
            return r.text()
        );
    }

}

#end
