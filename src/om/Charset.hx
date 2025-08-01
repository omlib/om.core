package om;

class Charset {
	/**
		Contains the whole ASCII charset.
	**/
	public static final ASCII = " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~";

	/**
		The Latin1 (ISO 8859-1) charset (only the extra chars, no the ASCII part) + euro symbol
	**/
	public static final LATIN1 = "¡¢£¤¥¦§¨©ª«¬-®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ€";

	/**
		Russian support
	**/
	public static final CYRILLIC = "АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмнопрстуфхцчшщъыьэюя—";

	/**
		Polish support
	**/
	public static final POLISH = "ĄĆĘŁŃÓŚŹŻąćęłńóśźż";

	/**
		Turkish support
	**/
	public static final TURKISH = "ÂÇĞIİÎÖŞÜÛâçğıİîöşüû";

	/**
		Contains Hiragana, Katanaga, japanese punctuaction and full width space (0x3000) full width numbers (0-9) and some full width ascii punctuation (!:?%&()-).
		Does not include full width A-Za-z.
	**/
	public static final JP_KANA = "　あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわゐゑをんがぎぐげござじずぜぞだぢづでどばびぶべぼぱぴぷぺぽゃゅょアイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヰヱヲンガギグゲゴザジズゼゾダヂヅデドバビブベボパピプペポヴャぇっッュョァィゥェォ・ー「」、。『』“”！：？％＆（）－０１２３４５６７８９";

	/**
		Special unicode chars (fallback chars)
	**/
	public static final UNICODE_SPECIALS = "�□";

	public static inline function isSpace(code:Int):Bool
		return code == ' '.code || code == 0x3000;

	// public static inline function isBreakChar(code) {
	//	return isSpace(code) || isCJK(code);
	// }
}
