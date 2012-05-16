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
    bool processingAuthor;
    bool processingContent;
    bool processingLink;
    bool processingPublicationDate;
    
    NSMutableArray *entries;
    NSData *feedData;
    Entry *entry;
    
    NSString *moviesUrlString;
    NSString *tvUrlString;
    NSString *musicUrlString;
    NSString *artUrlString;
    NSString *booksUrlString;
    NSString *industryUrlString;
    NSString *clickablesUrlString;
}

@property bool includeMovieNews;
@property bool includeTvNews;
@property bool includeMusicNews;
@property bool includeArtNews;
@property bool includeBooksNews;
@property bool includeIndustryNews;
@property bool includeClickablesNews;

-(NSMutableArray *) fetchAllNews;
-(NSMutableArray *) fetchMovies;
-(NSMutableArray *) fetchTV;
-(NSMutableArray *) fetchMusic;
-(NSMutableArray *) fetchArtAndBooks;
-(NSMutableArray *) fetchIndustry;
-(NSMutableArray *) fetchClickables;

@end
