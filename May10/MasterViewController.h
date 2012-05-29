//
//  MasterViewController.h
//  May10
//
//  Created by Georges Labreche on 5/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    NSArray *feedMenuItems;
    UINavigationController *feedContentNavigationViewController;
    NSMutableArray *feeds;
}
@property(nonatomic, strong) UITableView *feedCategoriesTableView;

-(id)init;
@end
