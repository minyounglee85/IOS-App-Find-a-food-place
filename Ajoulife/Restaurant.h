//
//  Restaurant.h
//  Ajoulife
//
//  Created by media on 6/22/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Restaurant : NSManagedObject

@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSNumber * isDelivery;
@property (nonatomic, retain) NSNumber * isFavorite;
@property (nonatomic, retain) NSNumber * isNight;
@property (nonatomic, retain) NSNumber * kind;
@property (nonatomic, retain) NSString * mainImagePath;
@property (nonatomic, retain) NSNumber * mapLatitude;
@property (nonatomic, retain) NSNumber * mapLatitudeDelta;
@property (nonatomic, retain) NSNumber * mapLongitude;
@property (nonatomic, retain) NSNumber * mapLongitudeDelta;
@property (nonatomic, retain) NSString * menuImagePath;
@property (nonatomic, retain) NSString * nameOfTitle;
@property (nonatomic, retain) NSString * tell;
@property (nonatomic, retain) NSString * time;

@end
