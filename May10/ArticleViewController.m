//
//  ArticleViewController.m
//  May10
//
//  Created by Georges Labreche on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ArticleViewController.h"

@interface ArticleViewController ()

@end

@implementation ArticleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id) initWithArticleEntry:(Entry *) entry{
    self = [super initWithNibName:nil bundle:nil];
    if(self){
        articleEntry = entry;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Build web view with article HTML content retrieved from the feed url.
    UIWebView *webView = [[UIWebView alloc]init];
    
    NSMutableString *fullHtmlArticleContent = [NSMutableString stringWithString: @""];
    
    [fullHtmlArticleContent appendString: articleEntry.imageHtmlContent];
    [fullHtmlArticleContent appendString: articleEntry.articleHtmlContent];
    [fullHtmlArticleContent appendString: articleEntry.readMoreByHtmlContent];
    
    [webView loadHTMLString:fullHtmlArticleContent baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    
    // Assign the web view to this controller.
    self.view = webView;
    
    [super viewDidUnload];
}

- (void)viewDidUnload
{
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
