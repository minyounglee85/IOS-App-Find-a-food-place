//
//  MoreViewController.m
//  Ajoulife
//
//  Created by  on 13. 5. 25..
//  Copyright (c) 2013년 __MyCompanyName__. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)sendMailForEnroll:(id)sender {
    
    MFMailComposeViewController *mailsome=[[MFMailComposeViewController alloc] init];
	mailsome.mailComposeDelegate=self;
	if ([MFMailComposeViewController canSendMail]){
        
		[mailsome setToRecipients:[NSArray arrayWithObjects:@"kbstar.c@gmail.com",nil]];
		[mailsome setSubject:@"[매장등록요청]"];
		[mailsome setMessageBody:@"1.매장이름: \n2.매장주소: \n3.전화번호: " isHTML:NO];
		[self presentModalViewController:mailsome animated:YES];
        
	}
}

- (IBAction)sendMailForAds:(id)sender {
    MFMailComposeViewController *mailsome=[[MFMailComposeViewController alloc] init];
	mailsome.mailComposeDelegate=self;
	if ([MFMailComposeViewController canSendMail]){
        
		[mailsome setToRecipients:[NSArray arrayWithObjects:@"kbstar.c@gmail.com",nil]];
		[mailsome setSubject:@"[광고제휴문의]"];
		[mailsome setMessageBody:@"1.연락처: \n2.내용: \n" isHTML:NO];
		[self presentModalViewController:mailsome animated:YES];
        
	}
}

- (IBAction)sendMailForAsk:(id)sender {
    MFMailComposeViewController *mailsome=[[MFMailComposeViewController alloc] init];
	mailsome.mailComposeDelegate=self;
	if ([MFMailComposeViewController canSendMail]){
        
		[mailsome setToRecipients:[NSArray arrayWithObjects:@"kbstar.c@gmail.com",nil]];
		[mailsome setSubject:@"[서비스문의]"];
		[mailsome setMessageBody:@"궁금한 사항은 언제든지 문의 주세요~" isHTML:NO];
		[self presentModalViewController:mailsome animated:YES];
        
	}
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
    
	[self dismissModalViewControllerAnimated:YES];
	if (result == MFMailComposeResultFailed) {
		
		UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"can not send mail" message:@"sorry" delegate:self cancelButtonTitle:@"Okey" otherButtonTitles:nil];
		[alert show];
		
	}
    
}

@end
