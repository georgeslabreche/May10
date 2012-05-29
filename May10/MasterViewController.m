//
//  MasterViewController.m
//  May10
//
//  Created by Georges Labreche on 5/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"
#import "FeedContentViewController.h"
#import "AppDelegate.h"

@interface MasterViewController ()

@end

@implementation MasterViewController
@synthesize feedCategoriesTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)init{
    
    self = [super initWithNibName:nil bundle:nil];
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
    }
    return self;
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
	
    // load vulture feed logo view
    UIImage *vultureFeedImage = [UIImage imageNamed:@"Images/feed.png"];
    UIImageView *vultureFeedImageView = [[UIImageView alloc]initWithImage:vultureFeedImage];
    vultureFeedImageView.contentMode = UIViewContentModeTop;
    
    [self.view addSubview: vultureFeedImageView];
    
    // Load feed categories table view
    CGRect feedCategoriesTableViewBounds = CGRectMake(0, vultureFeedImageView.bounds.size.height, vultureFeedImageView.bounds.size.width, self.view.bounds.size.height);
    
    self.feedCategoriesTableView = [[UITableView alloc]initWithFrame:feedCategoriesTableViewBounds style:UITableViewStylePlain];
    self.feedCategoriesTableView.delegate = self;
    self.feedCategoriesTableView.dataSource = self;
    
    [self.view addSubview: feedCategoriesTableView];
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    NSInteger result = 0;
    
    if([tableView isEqual:self.feedCategoriesTableView]){
        result = 1;
    }
    
    return result;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSUInteger result = 0;
    
    if([tableView isEqual:self.feedCategoriesTableView]){
        result = feedMenuItems.count;
    }
    
    return result;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if([tableView isEqual:self.feedCategoriesTableView]){
        static NSString *cellIdentifier = @"Feeds";
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: cellIdentifier];
        }
        cell.textLabel.text = [feedMenuItems objectAtIndex: indexPath.row];
        
    }
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    // Get delegage. We need to operate on objects in the delegate
    AppDelegate *delegate=[[UIApplication sharedApplication] delegate];
    
    
    // This array will contain the feed to display
    feeds = nil;
    
    // Fetch required feed.
    NSString *selectedFeed = [feedMenuItems objectAtIndex: indexPath.row];
    NSLog(@"Fetch and display %@ feed.", selectedFeed);
    
    if(indexPath.row == 0){
        feeds = delegate.feedParser.fetchAllNews; 
        
    }else if(indexPath.row == 1){
        feeds = delegate.feedParser.fetchMovies;
        
    }else if(indexPath.row == 2){
        feeds = delegate.feedParser.fetchTV;
        
    }else if(indexPath.row == 3){
        feeds = delegate.feedParser.fetchMusic;
        
    }else if(indexPath.row == 4){
        feeds = delegate.feedParser.fetchArtAndBooks;
        
    }else if(indexPath.row == 5){
        feeds = delegate.feedParser.fetchIndustry;
        
    }else if(indexPath.row == 6){
        feeds = delegate.feedParser.fetchClickables;
    }
    else{
        // Error, return empty array
        feeds = [[NSMutableArray alloc]init];
    }
    
    // Reload content view because we have new feeds
    UINavigationController *feedContentNavigationController = [delegate.vultureFeedSplitViewController.viewControllers objectAtIndex:1];
    
    FeedContentViewController *feedContentViewController = [feedContentNavigationController.viewControllers objectAtIndex:0];
    
    feedContentViewController.vultureFeeds = feeds;
    
    [feedContentViewController.tableView reloadData];
    feedContentViewController.navigationController.navigationBar.topItem.title = selectedFeed;
    
}
@end

