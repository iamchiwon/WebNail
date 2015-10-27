//
//  WebNailGetter.h
//  WebNail
//
//  Created by iamchiwon on 2015. 10. 27..
//  Copyright © 2015년 iamchiwon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebNailGetter : NSObject

@property NSUInteger size;

- (void)getImageWithAddress:(NSString*)address onComplete:(void (^)(NSString *url, UIImage *nail))complete;

@end
