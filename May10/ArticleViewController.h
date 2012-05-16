//
//  ArticleViewController.h
//  May10
//
//  Created by Georges Labreche on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Entry.h"

@interface ArticleViewController : UIViewController{
    Entry *articleEntry;
}


-(id) initWithArticleEntry:(Entry *) entry;

@end
