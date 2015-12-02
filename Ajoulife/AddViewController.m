//
//  AddViewController.m
//  Ajoulife
//
//  Created by  on 13. 6. 15..
//  Copyright (c) 2013년 __MyCompanyName__. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController
@synthesize deliveryLabel;
@synthesize nightLabel;



@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize image;
@synthesize fieldNameOfTitle;
@synthesize fieldDetail;
@synthesize fieldTell;
@synthesize fieldTime;
@synthesize fieldLatitude;
@synthesize fieldLongitude;
@synthesize kind;
@synthesize isDelivery, isNight;

int flag = 0;

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
    
    isDelivery = NO;
    isNight = NO;
    
    deliveryLabel.text = @"";
    nightLabel.text = @"";
        
}

- (void)viewDidUnload
{
    [self setFieldNameOfTitle:nil];
    [self setFieldDetail:nil];
    [self setFieldTell:nil];
    [self setFieldTime:nil];
    [self setDeliveryLabel:nil];
    [self setNightLabel:nil];
    [self setFieldLatitude:nil];
    [self setFieldLongitude:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)addPressed:(id)sender {
    
    id appDelegate = (id)[[UIApplication sharedApplication] delegate]; 
    self.managedObjectContext = [appDelegate managedObjectContext];
    
    Restaurant *data = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:self.managedObjectContext];
    
    //입력 필드 시작
    data.nameOfTitle = fieldNameOfTitle.text;
    data.kind = [NSNumber numberWithInt:self.kind];
    data.detail = fieldDetail.text;
    data.tell = fieldTell.text;
    data.isNight = [NSNumber numberWithBool:isNight];
    data.isDelivery = [NSNumber numberWithBool:isDelivery];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    NSLog(@"%@<--", [numberFormatter numberFromString:fieldLatitude.text]);
    data.mapLatitude = [numberFormatter numberFromString:fieldLatitude.text];
    data.mapLongitude = [numberFormatter numberFromString:fieldLongitude.text]; 
    data.mapLatitudeDelta = [NSNumber numberWithFloat:0.0];
    data.mapLatitudeDelta = [NSNumber numberWithFloat:0.0];
    
    [self.managedObjectContext save:nil];
    
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:@"새로운 장소 추가"];
    [alert setMessage:@"저장할까요?"];
    [alert setDelegate:self];
    [alert addButtonWithTitle:@"네"];
    [alert addButtonWithTitle:@"아니오"];
    [alert show];

    //[self.managedObjectContext deleteObject:data];
    //[self.managedObjectContext save:nil];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self.navigationController popViewControllerAnimated:YES]; //뒤도가기
    }
    else if (buttonIndex == 1)
    {
    }
}


- (IBAction)addMenuImage:(id)sender {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
    picker.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
    [[self navigationController] presentModalViewController:picker animated:YES];
    
}

- (void) imagePickerController:(UIImagePickerController *)picker
 didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    //obtaining saving path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:@"latest_mainImagePath.png"];
    Restaurant *data = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:self.managedObjectContext];
    data.menuImagePath = imagePath;
    if(flag==1){data.mainImagePath = imagePath;}
}

- (IBAction)addMainImage:(id)sender {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIImagePickerController* pickerMain = [[UIImagePickerController alloc] init];
    pickerMain.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
    [[self navigationController] presentModalViewController:pickerMain animated:YES];
    flag=1;
}

- (IBAction)flipButton:(id)sender {
    
    if([sender tag] == 0) { //야식
        if (nightLabel.text == @"") {
            nightLabel.text = @"V";
            isNight = true;

        } else {
            nightLabel.text = @"";
            isNight = false;
           
        }
    } else { //배달
        if (deliveryLabel.text == @"") {
            deliveryLabel.text = @"V";
            isDelivery = true;
        } else {
            deliveryLabel.text = @"";
            isDelivery = false;
        } 
    }        
}

- (IBAction) textFieldDoneEditing:(id) sender // 텍스트 필드 입력 종료 액션
{
	[sender resignFirstResponder]; // 센더 (텍스트 필드)에게 최초 응답자 자리에서 물러나라는 메시지이다.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];// this will do the trick
}


@end
