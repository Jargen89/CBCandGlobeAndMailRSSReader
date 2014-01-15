//
//  CBCWebView.h
//  viei_A6
//
//  Created by Vieira Jason 070569870 on 3/5/13.
//  Copyright (c) 2013 Hoang Chinh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMWebView : UIViewController
{
    NSString *link;
}
@property (strong, nonatomic) NSString *link;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end
