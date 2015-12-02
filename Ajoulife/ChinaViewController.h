//
//  ChinaViewController.h
//  Ajoulife
//
//  Created by  on 13. 5. 26..
//  Copyright (c) 2013년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"
#import "ChinaDetailViewController.h"
#import "Restaurant.h"

@interface ChinaViewController : CoreDataTableViewController

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property int kind;
@property bool isNight, isFavorite, isDelivery;
@property int searchCondition1;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;

- (IBAction)callButtonPressed:(id)sender;
- (IBAction)starPressed:(id)sender;
- (IBAction)plusButtonPressed:(id)sender;

@end
