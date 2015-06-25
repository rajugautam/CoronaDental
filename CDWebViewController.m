//
//  CDWebViewController.m
//  CoronaDental
//
//  Created by Raju Gautam on 06/06/15.
//  Copyright (c) 2015 Raju Gautam. All rights reserved.
//

#import "CDWebViewController.h"

@interface CDWebViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSString *initialRequestURLString;
@property (readwrite) int requestCount;
@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

@end

@implementation CDWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    CGSize size = self.view.frame.size;
    self.webView.frame = CGRectMake(self.webView.frame.origin.x, self.webView.frame.origin.y, size.width, size.height);
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.webView.scrollView setShowsHorizontalScrollIndicator:FALSE];
    [self.webView.scrollView setShowsVerticalScrollIndicator:FALSE];
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    
    [self loadWebView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadWebView {
        //self.webView.hidden = FALSE;
    NSString *requestPath = self.url;//@"http://coronadentalnetwork.com/index.php/customer/account/";
        //    NSString *requestPath = @"http://app.factorlab.com/v2/ResponsiveApp.jsp#search";
    
    self.initialRequestURLString = requestPath;
    
    NSURL *requestURL = [NSURL URLWithString:requestPath];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:requestURL];
    (void)[NSURLConnection connectionWithRequest:request delegate:self];
    
    [self.webView loadRequest:request];
}

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    NSURLCredential * cred = nil;
//    if(_requestCount >1 ) {
//        cred = [NSURLCredential credentialWithUser:@"amar.singh@stardental.in"
//                                          password:@"corona"
//                                       persistence:NSURLCredentialPersistenceForSession];
//    } else {
//            //NSDictionary *user = [[FLNetworkManager manager] loginUser];
    
        cred = [NSURLCredential credentialWithUser:@"admin"
                                          password:@"ADmin@123"
                                       persistence:NSURLCredentialPersistenceForSession];
//    }
        //    NSURLCredential * cred = [NSURLCredential credentialWithUser:@"admin"
        //                                                        password:@"ADmin@123"
        //                                                     persistence:NSURLCredentialPersistenceForSession];
    _requestCount++;
    [[NSURLCredentialStorage sharedCredentialStorage]setCredential:cred forProtectionSpace:[challenge protectionSpace]];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if ([error code] == -1001 || [error code] == -1005 || [error code] == -1008 || [error code] == -1009) {
        self.webView.hidden = TRUE;
    }
}

- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection;
{
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.webView stopLoading];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_loadingView removeFromSuperview];
    [_loadingIndicator stopAnimating];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.view addSubview:_loadingView];
    [self.view bringSubviewToFront:_loadingView];
    [_loadingIndicator startAnimating];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString* url = [[request URL] absoluteString];
    
    NSLog(@"Navigation type %ld and request url %@", (long)navigationType, url);
    if( [url isEqualToString:self.initialRequestURLString] ) {
        
        return YES;
        
    }

    if(navigationType == UIWebViewNavigationTypeLinkClicked || navigationType == UIWebViewNavigationTypeFormSubmitted) {
        
        CDWebViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
        newView.url = url;
        [self.navigationController pushViewController:newView animated:NO];      //this will make a new webview and push it on our navigation controller
        
        return YES;
        
    }
    
    else if(navigationType == UIWebViewNavigationTypeOther) {
        
        NSString* documentURL = [[request mainDocumentURL] absoluteString];
        
        if( [url isEqualToString:documentURL]) {             //if they are the same this is a javascript href click
            
                //[self pushFrontWithLink:url];
                //[self.navigationController popViewControllerAnimated:YES];
            return YES;
            return NO;
            
        }
        
    }
    
    return YES;
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
