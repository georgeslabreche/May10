//
//  FeedContentViewController.m
//  May10
//
//  Created by Georges Labreche on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedContentViewController.h"
#import "ArticleViewController.h"
#import "Entry.h"

@interface FeedContentViewController ()

@end

@implementation FeedContentViewController
@synthesize vultureFeeds;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}


- (id)init{
    self = [super initWithStyle:UITableViewCellStyleDefault];
    if (self) {

    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.rowHeight = 100;
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.topItem.title = @"All News";
    
    //[self.navigationController setNavigationBarHidden:YES];
    
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
    return vultureFeeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Feed";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: cellIdentifier];
	}
    
    // Configure the cell...
    Entry *entry = [vultureFeeds objectAtIndex: indexPath.row];
    
	cell.textLabel.text = entry.title;
    
    if(entry.imageURL != nil){
        NSData *imageData = [[NSData alloc]initWithContentsOfURL: entry.imageURL];
        
        cell.imageView.image = [[UIImage alloc]initWithData:imageData];
    }
    
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
    // get selected entry
    Entry *entry = [vultureFeeds objectAtIndex: indexPath.row];
    
    NSLog(@"Selected article: %@", entry.title);
    
    // Build view controller that will display the entry's article content
    ArticleViewController *articleViewController = [[ArticleViewController alloc]initWithArticleEntry:entry];
    
    // Load article view.
    [self.navigationController pushViewController:articleViewController animated:YES];
    
    // Show navigation bar when displaying article in web view.
    // This is so that the user can easily got back to the table view
    [self.navigationController setNavigationBarHidden:NO];
    
    // title of article is navigation bar top item title
    self.navigationController.navigationBar.topItem.title = entry.title;
}

@end
