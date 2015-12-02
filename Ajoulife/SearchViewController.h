//
//  SearchViewController.h
//  Ajoulife
//
//  Created by media on 6/23/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIPickerView *pickerview;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerview2;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerview3;

@property (nonatomic, strong) NSArray *itemKind;
@property (nonatomic, strong) NSArray *itemDelivery;
@property (nonatomic, strong) NSArray *itemTime; 

@property (strong, nonatomic) IBOutlet UILabel *kindLabel;
@property (strong, nonatomic) IBOutlet UILabel *deliveryLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

- (IBAction)buttonPressed:(id)sender;
- (IBAction)confirmPressed:(id)sender;

@end
