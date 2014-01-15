//
//  RSSVieiDetailViewController.h
//  viei_A5
//
//  Created by Vieira Jason 070569870 on 2/23/13.
//  Copyright (c) 2013 Jason Vieira. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RSSVieiItem;
@interface CBCDetailView : UIViewController
{
    RSSVieiItem *item;

    NSURL * imageLink;
    NSData * imageData;
    NSString *text;

}
@property (strong, nonatomic) RSSVieiItem *item;
@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
