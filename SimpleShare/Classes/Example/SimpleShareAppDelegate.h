//
//  SimpleShareAppDelegate.h
//  SimpleShare
//
//  Created by Trinstan Chen on 02/20/2013.
//

#import <UIKit/UIKit.h>

@interface SimpleShareAppDelegate : NSObject <UIApplicationDelegate> {

    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end
