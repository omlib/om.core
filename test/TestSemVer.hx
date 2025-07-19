import om.SemVer;
import utest.Assert.*;

class TestSemVer extends utest.Test {
	static function make(major, minor, patch, ?preview, ?previewNum):SemVer {
		return {
			major: major,
			minor: minor,
			patch: patch,
			preview: preview,
			previewNum: previewNum
		};
	}

	function test_compare() {
		var a:SemVer = '0.0.0';
		var b:SemVer = '1.0.0';

		equals(-1, SemVer.compare(a, b));
		equals(1, SemVer.compare(b, a));
	}

	function test_toString() {
		equals("0.1.2", make(0, 1, 2));

		// Release Tags
		equals("0.1.2-alpha", make(0, 1, 2, ALPHA));
		equals("0.1.2-beta", make(0, 1, 2, BETA));
		equals("0.1.2-rc", make(0, 1, 2, RC));

		// Release Tag Versions
		equals("0.1.2-alpha.0", make(0, 1, 2, ALPHA, 0));
		equals("0.1.2-beta.0", make(0, 1, 2, BETA, 0));
		equals("0.1.2-rc.0", make(0, 1, 2, RC, 0));

		// Weird input
		equals("0.1.2", make(0, 1, 2, null, 0));

		// Multiple characters
		equals("100.200.300-rc.400", make(100, 200, 300, RC, 400));
	}

	function test_ofString() {
		// Normal
		equals("0.1.2", (SemVer.ofString("0.1.2").data : SemVer));
		equals("100.50.200", (SemVer.ofString("100.50.200").data : SemVer));

		// Release tags
		equals("0.1.2-alpha", (SemVer.ofString("0.1.2-ALPHA").data : SemVer));
		equals("0.1.2-alpha", (SemVer.ofString("0.1.2-alpha").data : SemVer));
		equals("0.1.2-beta", (SemVer.ofString("0.1.2-beta").data : SemVer));
		equals("0.1.2-rc", (SemVer.ofString("0.1.2-rc").data : SemVer));
		equals("0.1.2-rc.1", (SemVer.ofString("0.1.2-rc.1").data : SemVer));
	}

	function test_ofStringInvalid() {
		equals("invalid", parseInvalid(null));
		equals("invalid", parseInvalid(""));
		equals("invalid", parseInvalid("1"));
		equals("invalid", parseInvalid("1.1"));
		equals("invalid", parseInvalid("1.2.a"));
		equals("invalid", parseInvalid("a.b.c"));
		equals("invalid", parseInvalid("1.2.3-"));
		equals("invalid", parseInvalid("1.2.3-rc."));
		equals("invalid", parseInvalid("1.2.3--rc.1"));
		equals("invalid", parseInvalid("1.2.3-othertag"));
		equals("invalid", parseInvalid("1.2.3-othertag.1"));
		equals("invalid", parseInvalid("10.050.02"));
		equals("invalid", parseInvalid("10.50.2-rc.01"));
	}

	function parseInvalid(str:String) {
		return try (SemVer.ofString(str) : String) catch (e:String) {
			"invalid";
		}
	}
}
