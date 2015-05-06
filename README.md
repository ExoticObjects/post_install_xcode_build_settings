# post_install_xcode_build_settings

This script (see the `Podfile`) is one way to deal with [this problem](https://github.com/Bertrand/handlebars-objc/issues/15)

See the excellent answer on that page, posted by guillaume-algis:

>This is because Cocoapods apply the -fno-objc-arc flag (and others) on a file by file basis in Xcode
instead of setting a global compiler flag for the whole target.

>As some objc files are generated while compiling (by yacc and lex) these cannot have the flags applied
in Xcode beforehand.

>A solution is to add the flags added by Cocoapods: 
`-fno-objc-arc -w -Xanalyzer -analyzer-disable-checker -Xanalyzer deadcode`) in "Other C Flags" for the whole handlebars-objc target.

>Please note however that these will be removed after each pod install.

While I was happy to have a potential workaround, that last sentence made me sad. Then I learned about
Cocoapods post_install hooks. I learned the most from [this page](http://www.egeek.me/2013/05/25/podfiles-post-install-hook-example/) (thanks!)

If you've ever looked in a pbxproj file, you might have seen scary things like this:

	B8683CEEE9EC210C6E06DCD9 /* Release */ = {
	    isa = XCBuildConfiguration;
		baseConfigurationReference = 44E4C324FCEB158C69227FD9 /* Pods-handlebars-objc-Private.xcconfig */;
		buildSettings = {
			ARCHS = "$(ARCHS_STANDARD_INCLUDING_64_BIT)";
			ENABLE_STRICT_OBJC_MSGSEND = YES;
			GCC_PREFIX_HEADER = "Target Support Files/Pods-handlebars-objc/Pods-handlebars-objc-prefix.pch";
			IPHONEOS_DEPLOYMENT_TARGET = 7.0;
			MTL_ENABLE_DEBUG_INFO = NO;
			OTHER_CFLAGS = (
				"-fno-objc-arc",
				"-w",
				"-Xanalyzer",
				"-analyzer-disable-checker",
				"-Xanalyzer",
				deadcode,
			);
			OTHER_LDFLAGS = "";
			OTHER_LIBTOOLFLAGS = "";
			PRODUCT_NAME = "$(TARGET_NAME)";
			SDKROOT = iphoneos;
			SKIP_INSTALL = YES;
		};
		name = Release;
	};
	

This object is what this script is concerned with. It will set buildSettings['OTHER_CFLAGS'] to the values you see above, in the various places where this is required.
	
To sum up:

* To make Handlebars-objc and Cocoapods play well together, you need to add `-fno-objc-arc -w -Xanalyzer -analyzer-disable-checker -Xanalyzer deadcode` to `Pods-handlebars-objc` in your XCode build settings.
* However, each time you run `pod update`, those settings will be cleared.
* This script writes the settings to the appropriate places in the pbxproj files. So there's no need to add them in XCode in the first place.
* The script is pretty re-usable. You can use it to set any build setting to whatever you want. 
* I've tested it in two projects and it works for me. But that's not thorough testing :-)
* I'm not much of a Ruby guy. Feel free to fork and improve...
	
