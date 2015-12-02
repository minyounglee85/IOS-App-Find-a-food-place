//
//  MoreViewController.h
//  Ajoulife
//
//  Created by  on 13. 5. 25..
//  Copyright (c) 2013년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface MoreViewController : UIViewController <MFMailComposeViewControllerDelegate>
{
    
}


- (IBAction)sendMailForEnroll:(id)sender;
- (IBAction)sendMailForAds:(id)sender;
- (IBAction)sendMailForAsk:(id)sender;

@end
