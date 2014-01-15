//
//  CBCNewsFeed.h
//  viei_A6
//
//  Created by Vieira Jason 070569870 on 3/5/13.
//  Copyright (c) 2013 Hoang Chinh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RSSVieiChannel;
@interface CBCNewsFeed : UITableViewController <NSXMLParserDelegate>
{
    NSURLConnection *connection;
    NSMutableData *xmlData;
    RSSVieiChannel *channel;
}
- (IBAction)refreshFeed:(id)sender;
- (void)fetchEntries;
- (IBAction)done:(UIStoryboardSegue *)segue;
@end
