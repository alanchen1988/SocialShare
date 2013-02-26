//
//  SSHActionSheet.m
//  SimpleShare
//
//  Created by Trinstan Chen on 02/20/2013.
//

#import "SSHActionSheet.h"
#import "SSH.h"
#import "SSHConfig.h"
#import "SSHWebViewController.h"
#import "SSHEmailViewController.h"
#import "NSString+URLEscape.h"

@implementation SSHActionSheet

+ (SSHActionSheet *)actionSheet {
    
    SSHActionSheet *actionSheet = [[SSHActionSheet alloc]
								  initWithTitle:nil
								  delegate:nil
								  cancelButtonTitle:@"Cancel"
								  destructiveButtonTitle:nil
                                   otherButtonTitles:@"Twitter", @"Facebook", @"LinkedIn", @"Google+", @"Email", @"新浪微薄", @"腾讯微薄", @"豆瓣分享", @"人人网", nil];
	
	actionSheet.title = @"Share";
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	actionSheet.opaque = YES;
    
    return [actionSheet autorelease];
}

-(void)showEmailView {
    
    SSHEmailViewController *emailController = [[SSHEmailViewController alloc] init];
    
	[[[SSH currentHelper] rootViewController] presentModalViewController:emailController animated:YES];

	[emailController release];
}

- (void)showWebView:(NSString *)aTitle withUrl:(NSURL *)aUrl {
    
    SSHWebViewController *webController = [[SSHWebViewController alloc] init];
    [webController setTitle:aTitle];
    [webController requestURL:aUrl];
    
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:webController];
	[[[SSH currentHelper] rootViewController] presentModalViewController:navController animated:YES];
	
	[navController release];
	[webController release];
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated {
    
    if (buttonIndex == 0) {

        NSString *urlString = [NSString stringWithFormat:@"http://twitter.com/share?text=%@", [TWITTER_TEXT urlEscape]];
        [self showWebView:@"Share on Twitter" withUrl:[NSURL URLWithString:urlString]];
    }
    else if (buttonIndex == 1) {
        
        NSString *urlString = [NSString stringWithFormat:@"http://www.facebook.com/dialog/feed?app_id=%@&redirect_uri=http://facebook.com/?sk=lf&message=%@&link=%@&display=touch", FACEBOOK_APP_ID, [FACEBOOK_MESSAGE urlEscape], [FACEBOOK_LINK urlEscape]];
        [self showWebView:@"Share on Facebook" withUrl:[NSURL URLWithString:urlString]];
    }
    else if (buttonIndex == 2)
    {
        NSString *urlString = [NSString stringWithFormat:@"http://www.linkedin.com/shareArticle?mini=true&url=%@&title=%@", [DOU_WEIBO_LINK urlEscape], [LINKEDIN_WEIBO_MESSAGE urlEscape]];
        [self showWebView:@"Share on LinkedIn" withUrl:[NSURL URLWithString:urlString]];
    }
    
    else if (buttonIndex == 3)
    {
        NSString *urlString = [NSString stringWithFormat:@"https://plus.google.com/share?url=%@", [DOU_WEIBO_LINK urlEscape]];
        [self showWebView:@"Share on Google+" withUrl:[NSURL URLWithString:urlString]];
    }
    else if (buttonIndex == 4) {
        
        [self showEmailView];
    }
    else if (buttonIndex == 5)
    {
        NSString *urlString = [NSString stringWithFormat:@"http://service.weibo.com/share/share.php?url=%@&title=%@&appkey=%@", [SINA_WEIBO_LINK urlEscape], [SINA_WEIBO_MESSAGE urlEscape], [SINA_WEIBO_APP_ID urlEscape]];
        [self showWebView:@"Share on 新浪微薄" withUrl:[NSURL URLWithString:urlString]];
    }
    else if (buttonIndex == 6)
    {
        NSString *urlString = [NSString stringWithFormat:@"http://share.v.t.qq.com/index.php?c=share&a=index&url=%@&title=%@&appkey=%@", [QQ_WEIBO_LINK urlEscape], [QQ_WEIBO_MESSAGE urlEscape], [QQ_WEIBO_APP_ID urlEscape]];
        [self showWebView:@"Share on 腾讯微薄" withUrl:[NSURL URLWithString:urlString]];
    }
    else if (buttonIndex == 7)
    {
        NSString *urlString = [NSString stringWithFormat:@"http://shuo.douban.com/!service/share?href=%@&name=%@", [DOU_WEIBO_LINK urlEscape], [DOU_WEIBO_MESSAGE urlEscape]];
        [self showWebView:@"Share on 豆瓣分享" withUrl:[NSURL URLWithString:urlString]];
    }
    else if (buttonIndex == 8)
    {
        NSString *urlString = [NSString stringWithFormat:@"http://widget.renren.com/dialog/share?resourceUrl=%@&srcUrl=%@&title=%@&description=", [DOU_WEIBO_LINK urlEscape], [DOU_WEIBO_LINK urlEscape], [DOU_WEIBO_MESSAGE urlEscape]];
        [self showWebView:@"Share on 人人网" withUrl:[NSURL URLWithString:urlString]];
    }
    
    else if(buttonIndex == [self cancelButtonIndex])
    {
        [[[SSH currentHelper] callbackDelegate] didFinishSharing];
    }
	
	[super dismissWithClickedButtonIndex:buttonIndex animated:animated];
}

@end
