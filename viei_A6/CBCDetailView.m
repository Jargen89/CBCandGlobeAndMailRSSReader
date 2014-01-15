//
//  RSSVieiDetailViewController.m
//  viei_A5
//
//  Created by Vieira Jason 070569870 on 2/23/13.
//  Copyright (c) 2013 Jason Vieira. All rights reserved.
//

#import "CBCDetailView.h"
#import "RSSVieiItem.h"
#import "CBCWebView.h"
/*
@interface CBCDetailView ()
- (void)configureView;
@end
*/
@implementation CBCDetailView
@synthesize item;
#pragma mark - Managing the detail item

- (void)setItem:(RSSVieiItem *)newItem
{
    if (item != newItem) {
        item = newItem;
        // Update the view.
        [self configureView];
    }
}
- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.item) {
        // Update the user interface for the detail item.
        
        NSCharacterSet *quoteSet = [NSCharacterSet characterSetWithCharactersInString:@"\""];
        
        NSString *imgSource=@"src=\"";
        NSString *paraStart=@"<p>";
        NSString *paraEnd=@"</p>";
        
        NSString *imageURL;
        NSString *textblock;
        
        NSString *input = self.item.description;
        //NSLog(@"%@", input);
        
        NSScanner *theScanner = [NSScanner scannerWithString:input];
        //NSLog(@"111");
        [theScanner scanUpToString:imgSource intoString:NULL];
        [theScanner scanString:imgSource intoString:NULL];
        //NSLog(@"111");
        // NSLog(@"current scanLocation %d", [theScanner scanLocation]);
        //NSLog(@"111");
        
        [theScanner scanUpToCharactersFromSet:quoteSet intoString:&imageURL];
        //NSLog(@"IMAGE__ %@",imageURL);
        //NSLog(@"111");
        [theScanner scanUpToString:paraStart intoString:NULL];
        [theScanner scanString:paraStart intoString:NULL];
        //NSLog(@"current scanLocation %d", [theScanner scanLocation]);
        [theScanner scanUpToString:paraEnd intoString:&textblock];
        
        text = textblock;
        imageLink = [NSURL URLWithString:imageURL];
        imageData = [NSData dataWithContentsOfURL:imageLink];
        [self.imageView  setImage:[UIImage imageWithData:imageData]];
        self.textView.text = text;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"pushCBCWeb"]) {
        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //NSDate *object = _objects[indexPath.row];
        //[[segue destinationViewController] setDetailItem:object];
        CBCWebView *webView = [segue destinationViewController];
        webView.link = item.link;
    }
}
@end
