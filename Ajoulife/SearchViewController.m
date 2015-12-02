//
//  SearchViewController.m
//  Ajoulife
//
//  Created by media on 6/23/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "SearchViewController.h"
#import "ChinaViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize kindLabel;
@synthesize deliveryLabel;
@synthesize timeLabel;
@synthesize pickerview;
@synthesize pickerview2;
@synthesize pickerview3;

@synthesize itemKind, itemDelivery, itemTime;

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
    pickerview.hidden = true;
    pickerview2.hidden = true;
    pickerview3.hidden = true;
    
    itemKind = [[NSArray alloc] initWithObjects:@"전체", @"한식", @"중식", @"일식", @"고깃집", @"치킨", @"양식", @"술&카페", nil];
    itemDelivery = [[NSArray alloc] initWithObjects:@"상관 없음", @"배달 가능", nil];
    itemTime = [[NSArray alloc] initWithObjects:@"상관 없음", @"자정 이후", nil];
}

- (void)viewDidUnload
{
    [self setPickerview:nil];
    [self setPickerview2:nil];
    [self setPickerview3:nil];
    [self setKindLabel:nil];
    [self setDeliveryLabel:nil];
    [self setTimeLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UIPickerView DataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([pickerView isEqual: pickerview]){
        return [itemKind count];
    } else if ([pickerView isEqual: pickerview2]){
        return [itemDelivery count];
    } else if ([pickerView isEqual: pickerview3]){
        return [itemTime count];
    } 
    return 1;
}

#pragma mark - UIPickerView Delegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30.0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([pickerView isEqual: pickerview]){
        return [itemKind objectAtIndex:row];
    } else if ([pickerView isEqual: pickerview2]){
        return [itemDelivery objectAtIndex:row];
    } else if ([pickerView isEqual: pickerview3]){
        return [itemTime objectAtIndex:row];
    } 
    return @"";
    
    
}

//If the user chooses from the pickerview, it calls this function;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([pickerView isEqual: pickerview]){
        kindLabel.text = [itemKind objectAtIndex:row];
        pickerview.hidden = true;
    } else if ([pickerView isEqual: pickerview2]){
        deliveryLabel.text = [itemDelivery objectAtIndex:row];
         pickerview2.hidden = true;
    } else if ([pickerView isEqual: pickerview3]){
        timeLabel.text = [itemTime objectAtIndex:row];
         pickerview3.hidden = true;
    } 
}


- (IBAction)buttonPressed:(id)sender {
    if ([sender tag] == 1)
        pickerview.hidden = false;
    else if ([sender tag] == 2)
        pickerview2.hidden = false;
    else if ([sender tag] == 3)
        pickerview3.hidden = false;
        
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [pickerview resignFirstResponder];
        [pickerview2 resignFirstResponder];
        [pickerview3 resignFirstResponder];
        
        pickerview.hidden = YES;
        pickerview2.hidden = YES;
        pickerview3.hidden = YES;

    }
}

- (IBAction)confirmPressed:(id)sender {
    
    ChinaViewController *china = [self.storyboard instantiateViewControllerWithIdentifier:@"china"];
    
    china.kind = 11;
    
    if (kindLabel.text == @"한식") {
        china.searchCondition1 = 1;
    } else if (kindLabel.text == @"중식") {
        china.searchCondition1 = 2;
    } else if (kindLabel.text == @"일식") {
        china.searchCondition1 = 3;
    } else if (kindLabel.text == @"고깃집") {
        china.searchCondition1 = 4;
    } else if (kindLabel.text == @"치킨") {
        china.searchCondition1 = 5;
    } else if (kindLabel.text == @"양식") {
        china.searchCondition1 = 6;
    } else if (kindLabel.text == @"술&카페") {
        china.searchCondition1 = 7;
    } else {
        china.searchCondition1 = 0;
    }
    
    NSLog(@"%d", china.searchCondition1);
    
    if (deliveryLabel.text == @"배달 가능") {
        china.isDelivery = YES;
    } else {
        china.isDelivery = NO;
    }
    
    if (timeLabel.text == @"자정 이후") {
        china.isNight= YES;
    } else {
        china.isNight = NO;
    }    
    
    NSLog(@"업종:%d 배달가능:%i 영업시간:%i", china.searchCondition1, china.isDelivery, china.isNight);
          
    [self.navigationController pushViewController:china animated:YES];
    
}



@end
