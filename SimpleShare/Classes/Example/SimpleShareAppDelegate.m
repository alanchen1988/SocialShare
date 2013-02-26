//
//  SimpleShareAppDelegate.m
//  SimpleShare
//
//  Created by Trinstan Chen on 02/20/2013.
//

#import "SimpleShareAppDelegate.h"

@implementation SimpleShareAppDelegate

@synthesize window;
@synthesize navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self.window addSubview:[navigationController view]];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)dealloc {
    
    [navigationController release];
    [window release];
    
    [super dealloc];
}

@end
