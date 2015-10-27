//
//  WebNailGetter.m
//  WebNail
//
//  Created by iamchiwon on 2015. 10. 27..
//  Copyright © 2015년 iamchiwon. All rights reserved.
//

#import "WebNailGetter.h"

@interface WebNailGetter () <UIWebViewDelegate>
@property(strong, nonatomic)  UIWebView *webView;
@property(assign, nonatomic) NSInteger loadingCount;
@property (copy, nonatomic) void (^completBlock)(NSString *url, UIImage *nail);
@end

@implementation WebNailGetter

- (instancetype)init {
    self= [super init];
    if(self) {
        self.size= 512;
    }
    return self;
}

- (void)getImageWithAddress:(NSString*)address onComplete:(void (^)(NSString *url, UIImage *nail))complete
{
    self.completBlock= complete;
    self.loadingCount= 0;
    
    self.webView= [[UIWebView alloc] initWithFrame:CGRectMake(-self.size, -self.size, self.size, self.size)];
    self.webView.delegate= self;

    UIView *parent= [UIApplication sharedApplication].keyWindow.rootViewController.view;
    [parent addSubview:self.webView];
    
    if(![address hasPrefix:@"http://"] && ![address hasPrefix:@"https://"]) {
        address= [@"http://" stringByAppendingString:address];
    }
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:address]]];
}

- (UIImage *)imageFromView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0f);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.loadingCount++;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [NSTimer scheduledTimerWithTimeInterval:0.3
                                     target:self
                                   selector:@selector(webViewActuallyFinished)
                                   userInfo:nil
                                    repeats:NO];
}

/*
 * http://stackoverflow.com/questions/908367/uiwebview-how-to-identify-the-last-webviewdidfinishload-message
 */
- (void)webViewActuallyFinished {
    self.loadingCount--;
    if (self.loadingCount > 0) return;
    
    UIImage *img= [self imageFromView:_webView];
    NSString *address= [[[_webView request] URL] description];
    
    self.completBlock(address, img);
    
    [_webView removeFromSuperview];
    _webView= nil;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    self.loadingCount--;
}

@end
