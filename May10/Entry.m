//
//  Entry.m
//  May10
//
//  Created by Georges Labreche on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Entry.h"

@implementation Entry

@synthesize title;
@synthesize author;
@synthesize imageHtmlContent;
@synthesize articleHtmlContent;
@synthesize readMoreByHtmlContent;

@synthesize link;
@synthesize publicationDate;
@synthesize imageURL;
@synthesize articleURL;

@synthesize isMovieNews;
@synthesize isTvNews;
@synthesize isMusicNews;
@synthesize isArtNews;
@synthesize isBooksNews;
@synthesize isIndustryNews;
@synthesize isClickablesNews;

- (id) init{
    self = [super init];
    
    if(self){
        isMovieNews = false;
        isTvNews = false;
        isMusicNews = false;
        isArtNews = false;
        isBooksNews = false;
        isIndustryNews = false;
        isClickablesNews = false;       
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"\nTitle: %@\nAuthor: %@\nImage URL: %@\nLink: %@\nPublication Date: %@", title, author, imageURL.description, link, publicationDate];
}

@end
