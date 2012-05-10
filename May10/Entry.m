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
@synthesize contentArray;
@synthesize link;
@synthesize publicationDate;
@synthesize imageURL;

- (NSString *)description
{
    return [NSString stringWithFormat:@"\nTitle: %@\nImage URL: %@\nContent: $@\nLink: %@\nPublication Date: %@", title,  imageURL.description, contentArray.description, link, publicationDate];
}

@end
