//
//  SSHEmailViewController.m
//  SimpleShare
//
//  Created by Trinstan Chen on 02/20/2013.
//

#import "SSHEmailViewController.h"
#import "SSHConfig.h"
#import "SSH.h"

@implementation SSHEmailViewController

- (id)init {
    
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (mailClass != nil) {
        
        if ([mailClass canSendMail]) {
            
            if((self = [super init])) {
                
                [self setMailComposeDelegate:self];
                [self setSubject:EMAIL_SUBJECT];
                [self setMessageBody:EMAIL_BODY isHTML:NO];
            }
        }
    }
    
    return self;
}

#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate methods

- (void)mailComposeController:(MFMailComposeViewController *)controller 
		  didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
	
	[self dismissModalViewControllerAnimated:YES];
    [[[SSH currentHelper] callbackDelegate] didFinishSharing];
}

@end