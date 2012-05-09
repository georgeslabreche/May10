//
//  FeedParser.m
//  May10
//
//  Created by Georges Labreche on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedParser.h"

@implementation FeedParser

-(id) init{
    self = [super init];
    
    if(self){
        NSString *feedUrlString = @"http://www.vulture.com/rss/index.xml";
        feedUrl = [[NSURL alloc]initWithString:feedUrlString];
        feedData = [self replaceUnsupportedCharactersAndHtmlEntitiesFromUrl:feedUrl];
        
        entries = [[NSMutableArray alloc]init];
        
        
    }
    
    return self;
}

// It appears that NSXMLParser will not support html entities like "&#039;" and some special characters.
// Need to use better suited parsing solution.
// Check out libxml2: http://cocoawithlove.com/2008/10/using-libxml2-for-parsing-and-xpath.html
// Or research for an RSS feed parsing library that polls and does caching: https://github.com/touchcode/TouchRSS
// In the meantime, use this temp string replace solution
- (NSData *)replaceUnsupportedCharactersAndHtmlEntitiesFromUrl:(NSURL *)url {
    
    NSData *data = [[NSData alloc]initWithContentsOfURL:url];
    
    NSString *htmlCode = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
    NSMutableString *temp = [NSMutableString stringWithString:htmlCode];
    
    [temp replaceOccurrencesOfString:@"&#039;" withString:@"'" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    
    // This is not workin
    [temp replaceOccurrencesOfString:@"’" withString:@"'" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    
    NSData *finalData = [temp dataUsingEncoding:NSISOLatin1StringEncoding];
    return finalData;
    
}

-(NSMutableArray *) parseFeed{
    NSXMLParser *feedParser = [[NSXMLParser alloc]initWithData:feedData];
    [feedParser setDelegate:self];
    [feedParser parse];
    
    return entries;
}

-(NSMutableArray *) fetchAllNews{
    return [self parseFeed];
}

-(NSMutableArray *) fetchMovies{
    return [self parseFeed];
}

-(NSMutableArray *) fetchTV{
    return [self parseFeed];
}

-(NSMutableArray *) fetchClickables{
    return [self parseFeed];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict{
    
    // Set appropriate xml element processing flag.
    [self setProcessingFlagForElementName:elementName to:true];
    
    // We are about processing a new entry, let's initialise a new one.
    if(processingItem && entry == nil){
        entry = [[Entry alloc]init];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    // We are done processing an entry, let's put the created entry in an array and reset it.
    if([elementName isEqualToString: @"item"] && processingItem){
        [entries addObject:entry];
        entry = nil;
    }

    // Set appropriate xml element processing flag.
    [self setProcessingFlagForElementName:elementName to:false];
  
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock{
    if(processingContent){
        NSString *contentString = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        
        // init content array if this is the first content block retrieve for this item 
        if(entry.contentArray == nil){
            entry.contentArray = [[NSMutableArray alloc]init];
        }
        
        [entry.contentArray addObject:contentString];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if(processingItem){
        if(processingTitle){
            entry.title = string;
        }

        else if(processingLink){
            entry.link = string;
        }
        
        else if(processingPublicationDate){
            entry.publicationDate = string;
        }
    }
    
}

-(void) setProcessingFlagForElementName: (NSString *)elementName to: (bool) flag{
    if([elementName isEqualToString: @"item"]){
        processingItem = flag;
    }else if([elementName isEqualToString: @"title"]){
        processingTitle = flag && processingItem;
    }else if([elementName isEqualToString: @"description"]){
        processingContent = flag && processingItem;
    }else if([elementName isEqualToString: @"link"]){
        processingLink = flag && processingItem;
    }else if([elementName isEqualToString: @"pubDate"]){
        processingPublicationDate = flag && processingItem;
    }
}

@end
