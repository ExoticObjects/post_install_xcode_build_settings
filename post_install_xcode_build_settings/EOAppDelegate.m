//
//  EOAppDelegate.m
//

#import "EOAppDelegate.h"
#import "HBHandlebars.h"

@implementation EOAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    [self testHandlebars];
    return YES;
}


- (void)testHandlebars {

    NSError * error;
    NSString * result = [HBHandlebars renderTemplateString:@"Hello {{value}}!"
                                               withContext:@{@"value" : @"Jimbo"}
                                                     error:&error
    ];

    NSLog(@"result: %@", result);
    
}




@end
