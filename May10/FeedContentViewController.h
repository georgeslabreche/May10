//
//  FeedContentViewController.h
//  May10
//
//  Created by Georges Labreche on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedContentViewController : UITableViewController{
    NSArray *vultureFeeds;
}
- (id)initWithAllNewsFeeds;
- (id)initWithFeeds:(NSArray *) feeds;
@end
