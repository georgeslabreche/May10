//
//  VultureFeedSplitViewController.m
//  May10
//
//  Created by Georges Labreche on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VultureFeedSplitViewController.h"
#import "FeedContentViewController.h"

@interface VultureFeedSplitViewController ()

@end

@implementation VultureFeedSplitViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.delegate = self;
    }
    return self;
}

// Called when rotating to portrait
- (void)splitViewController:(UISplitViewController*)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem*)barButtonItem
       forPopoverController:(UIPopoverController*)pc {
    
    // Popover controller is visible in portrait
    UINavigationController *feedContentNavigationController = [svc.viewControllers objectAtIndex:1];
    
    // FeedContentViewController is the root controller in the navigation controller (index 0).
    FeedContentViewController *feedContentViewController = [feedContentNavigationController.viewControllers objectAtIndex:0];
    
    //feedContentViewController.navigationItem.leftBarButtonItem = barButtonItem;
    [feedContentViewController.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];

    NSLog(@"Rotating to portrait.");
}


// Called when rotating to landscape
- (void)splitViewController:(UISplitViewController*)svc 
     willShowViewController:(UIViewController *)aViewController 
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    // No popover controller in landscape view
    UINavigationController *feedContentNavigationController = [svc.viewControllers objectAtIndex:1];
    
    // FeedContentViewController is the root controller in the navigation controller (index 0).
    FeedContentViewController *feedContentViewController = [feedContentNavigationController.viewControllers objectAtIndex:0];

    feedContentViewController.navigationItem.leftBarButtonItem = nil;
    
    NSLog(@"Rotrating to landscape.");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
