//
//  CDLoginViewController.m
//  CoronaDental
//
//  Created by Raju Gautam on 04/06/15.
//  Copyright (c) 2015 Raju Gautam. All rights reserved.
//

#import "CDLoginViewController.h"
#import "MMDrawerController.h"

@interface CDLoginViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIImageView *ivLogo;
@property (nonatomic, strong) NSString *initialRequestURLString;

@end

@implementation CDLoginViewController

@synthesize initialRequestURLString = _initialRequestURLString;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = TRUE;
    CGSize size = self.view.frame.size;
    
    self.webView.delegate = self;
    [self.webView.scrollView setShowsHorizontalScrollIndicator:FALSE];
    [self.webView.scrollView setShowsVerticalScrollIndicator:FALSE];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
        [self loadWebView];
        //[self performSegueWithIdentifier:@"DRAWER_SEGUE" sender:self];
}

- (void)loadWebView {
    self.webView.hidden = TRUE;
    NSString *requestPath = @"http://coronadentalnetwork.com/index.php/apilogin/index/login?username=amar.singh@stardental.in&password=corona";
        //    NSString *requestPath = @"http://app.factorlab.com/v2/ResponsiveApp.jsp#search";
    
    self.initialRequestURLString = requestPath;
    
    NSURL *requestURL = [NSURL URLWithString:requestPath];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:requestURL];
    (void)[NSURLConnection connectionWithRequest:request delegate:self];
    
    [self.webView loadRequest:request];
}


- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
        //NSDictionary *user = [[FLNetworkManager manager] loginUser];
    
//    NSURLCredential * cred = [NSURLCredential credentialWithUser:@"amar.singh@stardental.in"
//                                                        password:@"corona"
//                                                     persistence:NSURLCredentialPersistenceForSession];
    NSURLCredential * cred = [NSURLCredential credentialWithUser:@"admin"
                                                        password:@"ADmin@123"
                                                     persistence:NSURLCredentialPersistenceForSession];
    [[NSURLCredentialStorage sharedCredentialStorage]setCredential:cred forProtectionSpace:[challenge protectionSpace]];
    
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"error received %@ with error code %d", [error description], [error code]);
    if ([error code] == -1001 || [error code] == -1005 || [error code] == -1008 || [error code] == -1009) {
            self.webView.hidden = TRUE;
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"didFinishLoadCalled");
    [self performSegueWithIdentifier:@"DRAWER_SEGUE" sender:self];
    
}

- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection;
{
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated {
//    [self.webView stopLoading];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return TRUE;
    NSString* url = [[request URL] absoluteString];
    
    NSLog(@"Navigation type %ld and request url %@", (long)navigationType, url);
    if( [url isEqualToString:self.initialRequestURLString] ) {
        
        return YES;
        
    }
    if(navigationType == UIWebViewNavigationTypeLinkClicked || navigationType == UIWebViewNavigationTypeFormSubmitted) {
        
            //[self pushFrontWithURL:url];      //this will make a new webview and push it on our navigation controller
        
        return YES;
        
    }
    
    else if(navigationType == UIWebViewNavigationTypeOther) {
        
        NSString* documentURL = [[request mainDocumentURL] absoluteString];
        
        if( [url isEqualToString:documentURL]) {             //if they are the same this is a javascript href click
            
                //[self pushFrontWithLink:url];
                //[self.navigationController popViewControllerAnimated:YES];
            
            return YES;
            
        }
        
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DRAWER_SEGUE"]) {
        MMDrawerController *destinationViewController = (MMDrawerController *) segue.destinationViewController;
        [destinationViewController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
        
            // Instantitate and set the center view controller.
        UIViewController *centerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FIRST_TOP_VIEW_CONTROLLER"];
        NSLog(@"center View controller %@ and class %@", centerViewController, [centerViewController class]);
        [destinationViewController setCenterViewController:centerViewController];
        
            // Instantiate and set the left drawer controller.
        UIViewController *leftDrawerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SIDE_DRAWER_CONTROLLER"];
        NSLog(@"left View controller %@ and class %@", leftDrawerViewController, [leftDrawerViewController class]);
        [destinationViewController setLeftDrawerViewController:leftDrawerViewController];
        
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
