//
//  RSSVieiItem.h
//  viei_A5
//
//  Created by Vieira Jason 070569870 on 2/23/13.
//  Copyright (c) 2013 Jason Vieira. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSVieiItem : NSObject <NSXMLParserDelegate> {
    NSString *title;
    NSString *link;
    NSString *description;
    NSMutableString *currentString;
    id parentParserDelegate;
}
@property (nonatomic, readwrite) id parentParserDelegate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *link;
@property (nonatomic, retain) NSString *description;

@end
