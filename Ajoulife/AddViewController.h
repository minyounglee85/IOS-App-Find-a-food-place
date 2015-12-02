//
//  AddViewController.h
//  Ajoulife
//
//  Created by  on 13. 6. 15..
//  Copyright (c) 2013년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"
#import "ChinaDetailViewController.h"
#import "Restaurant.h"

@interface AddViewController : UIViewController
//@interface AddViewController : CoreDataTableViewController
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) UIImage * image;

@property (weak, nonatomic) IBOutlet UITextField *fieldNameOfTitle;
@property (weak, nonatomic) IBOutlet UITextField *fieldDetail;
@property (weak, nonatomic) IBOutlet UITextField *fieldTell;
@property (weak, nonatomic) IBOutlet UITextField *fieldTime;
@property (weak, nonatomic) IBOutlet UITextField *fieldLatitude;
@property (weak, nonatomic) IBOutlet UITextField *fieldLongitude;
@property int kind;

@property bool isDelivery;
@property bool isNight;
@property (weak, nonatomic) IBOutlet UILabel *deliveryLabel;
@property (weak, nonatomic) IBOutlet UILabel *nightLabel;

- (IBAction)addPressed:(id)sender;
- (IBAction)addMenuImage:(id)sender;
- (IBAction)addMainImage:(id)sender;
- (IBAction)flipButton:(id)sender;

-(IBAction) textFieldDoneEditing:(id) sender; // 텍스트 필드 입력이 끝났다는 액션 등록

@end
