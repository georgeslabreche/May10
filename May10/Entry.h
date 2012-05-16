//
//  Entry.h
//  May10
//
//  Created by Georges Labreche on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Entry : NSObject{
    
}
@property NSString* title;
@property NSString* author;
@property NSString* imageHtmlContent;
@property NSString* articleHtmlContent;
@property NSString* readMoreByHtmlContent;

@property NSString* link;
@property NSString* publicationDate;
@property (retain, nonatomic) NSURL* imageURL;
@property (retain, nonatomic) NSURL* articleURL;

@property bool isMovieNews;
@property bool isTvNews;
@property bool isMusicNews;
@property bool isArtNews;
@property bool isBooksNews;
@property bool isIndustryNews;
@property bool isClickablesNews;

@end
