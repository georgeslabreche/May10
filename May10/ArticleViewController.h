//
//  ArticleViewController.h
//  May10
//
//  Created by Georges Labreche on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleViewController : UIViewController{
    NSString *htmlContent;
}


-(id) initWithHtmlContent:(NSString *) content;

@end
