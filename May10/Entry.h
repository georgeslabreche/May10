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
@property NSMutableArray* contentArray;
@property NSString* link;
@property NSString* publicationDate;
@property NSURL* imageURL;

@end
