//
//  FeedParser.h
//  May10
//
//  Created by Georges Labreche on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entry.h"

@interface FeedParser : NSObject<NSXMLParserDelegate>{
    NSURL *feedUrl;
    bool processingItem;
    bool processingTitle;
    bool processingContent;
    bool processingLink;
    bool processingPublicationDate;
    
    NSMutableArray *entries;
    NSData *feedData;
    Entry *entry;
    
    
}
-(NSMutableArray *) fetchAllNews;

-(NSMutableArray *) fetchMovies;

-(NSMutableArray *) fetchTV;

-(NSMutableArray *) fetchClickables;
@end
