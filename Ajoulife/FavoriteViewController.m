//
//  FavoriteViewController.m
//  Ajoulife
//
//  Created by media on 6/22/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "FavoriteViewController.h"
#import "ChinaViewController.h"

@interface FavoriteViewController ()

@end

@implementation FavoriteViewController

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
    ChinaViewController *china = [self.storyboard instantiateViewControllerWithIdentifier:@"china"];
    china.kind = 10;
    china.navigationItem.hidesBackButton = YES;
    
    [self.navigationController pushViewController:china animated:YES];
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



@end
