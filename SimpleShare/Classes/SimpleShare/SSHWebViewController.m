//
//  SSHWebViewController.m
//  SimpleShare
//
//  Created by Trinstan Chen on 02/20/2013.
//

#import "SSHWebViewController.h"
#import "SSH.h"

@interface SSHWebViewController()

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;

@end

@implementation SSHWebViewController

@synthesize webView;
@synthesize activityIndicator;

- (id)init {
    
    if ((self = [super init])) {
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    }
    return self;
}

- (void)viewDidLoad {
    
    UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [aiv startAnimating];
    self.activityIndicator = aiv;
    [aiv release];
    
    CGSize contentSize = self.view.bounds.size;
    CGSize navbarSize = self.navigationController.navigationBar.bounds.size;
    UIWebView *wv = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, contentSize.width, contentSize.height-navbarSize.height)];
    self.webView = wv;
    [wv release];
    [self.webView setDelegate:self];
    [self.view addSubview:self.webView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:currentUrl];
    [self.webView loadRequest:request];
    
    [super viewDidLoad];
}

- (void)viewDidUnload {
    
    self.webView = nil;
    self.activityIndicator = nil;
    [super viewDidUnload];
}

- (void)dealloc {
    
    [webView release];
    [activityIndicator release];
    [currentUrl release];
    [super dealloc];
}

- (void)done {
    
    [self dismissModalViewControllerAnimated:YES];
    [[[SSH currentHelper] callbackDelegate] didFinishSharing];
}

- (void)requestURL:(NSURL *)aUrl {
    
    currentUrl = [aUrl retain];
}

#pragma mark -
#pragma mark UIWebViewDelegate methods

- (void)webViewDidStartLoad:(UIWebView*)webView {
    
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:self.activityIndicator];
    [[self navigationItem] setRightBarButtonItem:barButton];
    [barButton release];
}

- (void)webViewDidFinishLoad:(UIWebView*)webView {
    
    [[self navigationItem] setRightBarButtonItem:nil];
}

- (void)webView:(UIWebView*)webView didFailLoadWithError:(NSError*)error {
    
	[[self navigationItem] setRightBarButtonItem:nil];
    
    if ([error code] == -999) {
        return;
    }
        
    UIAlertView *alert = [[UIAlertView alloc] 
						  initWithTitle:[error localizedDescription]
						  message:[error localizedFailureReason]
						  delegate:self 
						  cancelButtonTitle:@"OK" 
						  otherButtonTitles:nil];
	[alert show];
	[alert release];
}

@end
