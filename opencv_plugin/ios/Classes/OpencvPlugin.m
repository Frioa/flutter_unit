#import "OpencvPlugin.h"
#if __has_include(<opencv_plugin/opencv_plugin-Swift.h>)
#import <opencv_plugin/opencv_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "opencv_plugin-Swift.h"
#endif

@implementation OpencvPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftOpencvPlugin registerWithRegistrar:registrar];
}
@end
