//
//  ChinaDetailViewController.h
//  Ajoulife_original
//
//  Created by  on 13. 5. 30..
//  Copyright (c) 2013년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ChinaDetailViewController : UIViewController <CLLocationManagerDelegate> 
{
    CLLocationManager *lm;
}

@property (nonatomic, retain) NSString *imagePath;
@property (nonatomic, retain) NSString *tell;
@property (nonatomic, retain) NSString *bbsPath; //후기 게시판 주소 경로
@property (strong, nonatomic) IBOutlet UIImageView *imageMenu; //식당 메뉴
@property (strong, nonatomic) IBOutlet MKMapView *mapView; //식당 맵
@property (strong, nonatomic) IBOutlet UIWebView *afterBbs; //식당 후기



//map data
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic) double latitudeDelta;
@property (nonatomic) double longitudeDelta;



- (IBAction)segmented:(id)sender;
@end
