//
//  FeedMenuViewController.h
//  May10
//
//  Created by Georges Labreche on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedContentViewController.h"

@interface FeedMenuViewController : UITableViewController{
    NSArray *feedMenuItems;
    UINavigationController *feedContentNavigationViewController;
    NSMutableArray *feeds;
}
-(id)init;
@end
