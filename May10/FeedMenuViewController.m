//
//  FeedMenuViewController.m
//  May10
//
//  Created by Georges Labreche on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedMenuViewController.h"
#import "FeedContentViewController.h"
#import "AppDelegate.h"

@interface FeedMenuViewController ()

@end

@implementation FeedMenuViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

-(id)initWithFeedContentlViewController: (FeedContentViewController *) viewController{
    self = [super initWithStyle:UITableViewCellStyleDefault];
    if (self) {
        feedMenuItems = [NSArray arrayWithObjects:
                         @"All News",
                         @"Movies",
                         @"TV",
                         @"Music",
                         @"Art, Books...",
                         @"The Industry",
                         @"Clickables",
                         nil];
        
        feedContentViewController = viewController;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return feedMenuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Feeds";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    // Configure the cell...
    if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: cellIdentifier];
	}
    
    // Configure the cell...
	//The .textLabel and .detailTextLabel properties are UILabels.
	//The .imageView property is a UIImage.
	cell.textLabel.text = [feedMenuItems objectAtIndex: indexPath.row];
    
    //TODO: Background image
    //NSString *fileName = [cell.textLabel.text stringByAppendingString: @".jpg"];
	//cell.imageView.image = [UIImage imageNamed: fileName];	//nil if .jpg file doesn't exist
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    // Get delegage. We need to operate on objects in the delegate
    AppDelegate *delegate=[[UIApplication sharedApplication] delegate];
    
    // This array will contain the feed to display
    NSMutableArray *feeds;
    
    // Fetch required feed.
    NSString *selectedFeed = [feedMenuItems objectAtIndex: indexPath.row];
    NSLog(@"Fetch and display %@ feed.", selectedFeed);
    
    if(indexPath.row == 0){
        NSLog(@"Fetch news feed...");
        feeds = delegate.feedParser.fetchAllNews; 
        
    }else if(indexPath.row == 1){
        NSLog(@"Fetch news feed...");
        feeds = delegate.feedParser.fetchMovies;
    }
    else{
        feeds = [[NSMutableArray alloc]init];
    }
         
    // Create the new feed content view controller
    FeedContentViewController *nextFeedContentViewController = [[FeedContentViewController alloc] 
                                                                initWithFeeds:feeds];
    
    
    // Update split view with new content
    NSArray *viewControllers = [NSArray arrayWithObjects:
                                                      self,
                                                      nextFeedContentViewController,
                                                      nil
                                                      ];
    
    delegate.vultureFeedSplitViewController.viewControllers = viewControllers;
    
}

@end
