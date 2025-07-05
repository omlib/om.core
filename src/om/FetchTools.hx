package om;

#if js
import haxe.extern.EitherType;
import js.lib.Promise;
#if nodejs
// #
#else
import js.Browser.window;
import js.html.Blob;
import js.html.FormData;
import js.html.ImageBitmap;
import js.html.Request;
import js.html.RequestInit;
import js.html.Response;
import js.html.audio.AudioBuffer;
import js.html.audio.AudioContext;
#end
import js.lib.ArrayBuffer;

/**
	Interface for accessing and manipulating parts of the HTTP pipeline, such as requests and responses.

	@see https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API
**/
class FetchTools {
	#if nodejs
	public static function fetchString(input:String):Promise<String> {
		return new Promise((resolve, reject) -> {
			js.node.Http.get(input, res -> {
				switch res.statusCode {
					case 200:
						var str = '';
						res.on('data', c -> str += c);
						res.on('end', c -> {
							resolve(str);
							return null;
						});
					default:
						reject(new js.lib.Error('fetch failed ' + res.statusCode));
				}
			});
		});
	}

	public static inline function fetchJson<T>(input:String):Promise<T> {
		return fetchString(input).then(str -> {
			return cast Json.parse(str);
		});
	}
	#else
	public static inline function fetch(input:EitherType<Request, String>, ?init:RequestInit):Promise<Response> {
		return window.fetch(input, init);
	}

	public static inline function fetchArrayBuffer(input:EitherType<Request, String>, ?init:RequestInit):Promise<ArrayBuffer> {
		return fetch(input, init).then((r:Response) -> return r.arrayBuffer());
	}

	public static inline function fetchAudioBuffer(context:AudioContext, input:EitherType<Request, String>, ?init:RequestInit):Promise<AudioBuffer> {
		return fetchArrayBuffer(input, init).then(buf -> return context.decodeAudioData(buf).then((ab:AudioBuffer) -> return ab));
	}

	public static inline function fetchBlob(input:EitherType<Request, String>, ?init:RequestInit):Promise<Blob> {
		return fetch(input, init).then((r:Response) -> return r.blob());
	}

	public static inline function fetchFormData(input:EitherType<Request, String>, ?init:RequestInit):Promise<FormData> {
		return fetch(input, init).then((r:Response) -> return r.formData());
	}

	public static inline function fetchImageBitmap(input:EitherType<Request, String>, ?init:RequestInit):Promise<ImageBitmap> {
		return fetchBlob(input, init).then((b:Blob) -> return window.createImageBitmap(b));
	}

	public static inline function fetchJson<T>(input:EitherType<Request, String>, ?init:RequestInit):Promise<T> {
		return fetch(input, init).then((r:Response) -> return r.json());
	}

	public static inline function fetchText(input:EitherType<Request, String>, ?init:RequestInit):Promise<String> {
		return fetch(input, init).then((r:Response) -> return r.text());
	}

	public static function fetchXml(input:EitherType<Request, String>, ?init:RequestInit):Promise<Xml> {
		return fetch(input, init).then((r:Response) -> {
			return r.text().then(text -> {
				return Xml.parse(text);
			});
		});
	}
	#end
}
#end
