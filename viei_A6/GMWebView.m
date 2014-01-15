//
//  CBCWebView.m
//  viei_A6
//
//  Created by Vieira Jason 070569870 on 3/5/13.
//  Copyright (c) 2013 Hoang Chinh. All rights reserved.
//

#import "GMWebView.h"

@interface GMWebView ()

@end

@implementation GMWebView
@synthesize link;
- (void)setLink:(NSString *)newLink

{
    //NSLog(@"testing for crash");
    if (link != newLink) {
        link = newLink;
        // Update the view.
        [self configureView];
    }
    
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.link) {
        NSURL *url = [NSURL URLWithString:link];
        // Construct a requst object with that URL
        // Load the request into the web view
        //NSLog(@"The LINK is: %@", self.link);
        dispatch_queue_t downloadQueue = dispatch_queue_create("WebPageDL", NULL);
        dispatch_async(downloadQueue, ^{
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // Load the request into the web view
                NSURLRequest *req = [NSURLRequest requestWithURL:url];
                [self.webView loadRequest:req];
                
            });// main queue
        });//async
        [self.webView setScalesPageToFit:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
