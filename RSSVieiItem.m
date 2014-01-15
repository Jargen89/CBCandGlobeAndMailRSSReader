//
//  RSSVieiItem.m
//  viei_A5
//
//  Created by Vieira Jason 070569870 on 2/23/13.
//  Copyright (c) 2013 Jason Vieira. All rights reserved.
//

#import "RSSVieiItem.h"

@implementation RSSVieiItem

@synthesize title, link, description, parentParserDelegate;
- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    NSLog(@"\t\t%@ found a %@ element", self, elementName);
    if ([elementName isEqual:@"title"]) {
        currentString = [[NSMutableString alloc] init];
        [self setTitle:currentString];
    }
    else if ([elementName isEqual:@"link"]) {
        currentString = [[NSMutableString alloc] init];
        [self setLink:currentString];
    }
    else if ([elementName isEqual:@"description"]) {
        currentString = [[NSMutableString alloc] init];
        [self setDescription:currentString];
    }
    else if ([elementName isEqual:@"media:thumbnail"]) {
        currentString = (NSMutableString *)[attributeDict objectForKey:@"url"];
        [self setDescription:currentString];
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)str
{
    [currentString appendString:str];
}
- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    currentString = nil;
    if ([elementName isEqual:@"item"])
        [parser setDelegate:parentParserDelegate];
}
@end
