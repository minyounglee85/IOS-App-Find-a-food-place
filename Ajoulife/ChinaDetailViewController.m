//
//  ChinaDetailViewController.m
//  Ajoulife
//
//  Created by  on 13. 5. 30..
//  Copyright (c) 2013년 __MyCompanyName__. All rights reserved.
//

#import "ChinaDetailViewController.h"
#import "ChinaViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocation.h>

@interface ChinaDetailViewController ()

@end

@implementation ChinaDetailViewController

@synthesize afterBbs, bbsPath;
@synthesize imageMenu, imagePath, tell;
@synthesize mapView;
@synthesize latitude, longitude, latitudeDelta, longitudeDelta;

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
    UIImage *image = [UIImage imageNamed:imagePath];
    imageMenu.image = image;
    NSLog(@"메뉴이미지:%@, 맵좌표: %f, %f, %f, %f" , imagePath, latitude, latitudeDelta, longitude, longitudeDelta);

    
    // 맵 관련 초기 설정
    lm = [[CLLocationManager alloc] init];
	lm.delegate = self;
	//lm.desiredAccuracy = kCLLocationAccuracyHundredMeters;
	//lm.distanceFilter = kCLDistanceFilterNone;
	[lm startUpdatingLocation];
	//map.mapType = MKMapTypeStandard;
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D center;
    center.latitude = latitude;
    center.longitude = longitude;
    [annotation setCoordinate:center];
    [annotation setTitle:@"전화걸기"]; //터치 했을때
    [self.mapView addAnnotation:annotation];
    
    //후기게시판
    NSURL *urlAfter=[NSURL URLWithString:@"http://wo.to/board/board.php?id=a.4.phantazia"]; // bbsPath 
    NSURLRequest *requestAfter=[NSURLRequest requestWithURL:urlAfter];
    [afterBbs setScalesPageToFit:NO];
    [afterBbs loadRequest:requestAfter];
}

- (void)viewDidUnload
{
    [self setImageMenu:nil];
    [self setMapView:nil];
    [self setAfterBbs:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)segmented:(id)sender {
    if ([sender selectedSegmentIndex] == 0) {
        imageMenu.hidden = NO; mapView.hidden = YES; afterBbs.hidden = YES;
    }
    if([sender selectedSegmentIndex] == 1){
        imageMenu.hidden = YES; mapView.hidden = NO; afterBbs.hidden = YES;
    }
    if([sender selectedSegmentIndex] == 2){
        imageMenu.hidden = YES; mapView.hidden = YES; afterBbs.hidden = NO;
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //미스터쉐프
	MKCoordinateRegion region = mapView.region; 
	region.center.latitude = self.latitude; //좌표
	region.center.longitude = self.longitude; //좌표
	region.span.latitudeDelta = self.latitudeDelta; //비율
	region.span.longitudeDelta = self.longitudeDelta; //비율
	[mapView setRegion:region animated:YES];
    MKPinAnnotationView *annotationView = nil; 
    annotationView.canShowCallout = YES;
    
}

-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    // return which subview we want to zoom
    return self.imageMenu;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
