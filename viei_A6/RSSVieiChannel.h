//
//  RSSVieiChannel.h
//  viei_A5
//
//  Created by Vieira Jason 070569870 on 2/23/13.
//  Copyright (c) 2013 Jason Vieira. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSVieiChannel : NSObject <NSXMLParserDelegate>
{
    NSString *title;
    NSString *shortDescription;
    NSMutableArray *items;
    id parentParserDelegate;
    NSMutableString *currentString;
}
@property (nonatomic, readwrite ) id parentParserDelegate;

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *shortDescription;
@property (nonatomic, readonly) NSMutableArray *items;
@end
