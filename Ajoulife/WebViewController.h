//
//  WebViewController.h
//  Ajoulife
//
//  Created by  on 13. 5. 25..
//  Copyright (c) 2013년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
{
	UIWebView	*ajouWebView;
    UIWebView   *ajouNotice;
    UIWebView   *ajouQuestion;
}
@property (strong, nonatomic) IBOutlet UIWebView *ajouWebView;
@property (strong, nonatomic) IBOutlet UIWebView *ajouNotice;
@property (strong, nonatomic) IBOutlet UIWebView *ajouQuestion;

@end
