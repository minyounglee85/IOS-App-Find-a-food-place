//
//  AppDelegate.m
//  Ajoulife
//
//  Created by  on 13. 5. 25..
//  Copyright (c) 2013년 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "Restaurant.h"
#import "ChinaViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize fetchedResultsController = __fetchedResultsController;


- (void)setupFetchedResultsController
{
    // 1 - Decide what Entity you want
    NSString *entityName = @"Restaurant"; // Put your entity name here
    NSLog(@"%@라는 이름의 엔티티를 모두 가져옵니다", entityName);
    
    // 2 - Request that Entity
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    // 3 - Filter it if you want
    //request.predicate = [NSPredicate predicateWithFormat:@"Person.name = Blah"];
    
    // 4 - Sort it if you want
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"nameOfTitle"
                                                                                     ascending:YES
                                                                                      selector:@selector(localizedCaseInsensitiveCompare:)]];
    // 5 - Fetch it
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    [self.fetchedResultsController performFetch:nil];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [self setupFetchedResultsController];
    
    if (![[self.fetchedResultsController fetchedObjects] count] > 0 ) {
        NSLog(@"스택에 아무것도 없으므로 로딩 시작!");
        
        // kind : 1.한식 2.중식 3.일식 4.고깃집 5.치킨 6.양식 7.술&카페 8.야식 9.즐겨찾기 10.검색
        // isNight : 야식인지 여부 (bool)
        // isFavorable : 즐겨찾기 여부 (bool)
             
        /*
        Restaurant *data = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:self.managedObjectContext];
        data.nameOfTitle = @"미스터쉐프";
        data.kind = [NSNumber numberWithInt:6];
        data.isNight = [NSNumber numberWithBool:YES];
        data.isFavorite = [NSNumber numberWithBool:NO];
        data.isDelivery = [NSNumber numberWithBool:NO];
        data.tell = @"031-243-1535";
        data.time = @"05시~3시";
        data.detail = @"배달안됨...좋음..";
        data.mainImagePath = @"star.png";
        data.menuImagePath = @"starPressed.png";
        data.mapLatitude = [NSNumber numberWithDouble:37.5];
        data.mapLatitudeDelta = [NSNumber numberWithDouble:0.0];
        data.mapLongitude = [NSNumber numberWithDouble:127.0];
        data.mapLongitudeDelta = [NSNumber numberWithDouble:0.0];
        [self.managedObjectContext save:nil];
        
        data = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:self.managedObjectContext];
        data.nameOfTitle = @"천애부";
        data.kind = [NSNumber numberWithInt:3];
        data.isNight = [NSNumber numberWithBool:NO];
        data.isFavorite = [NSNumber numberWithBool:NO];
        data.isDelivery = [NSNumber numberWithBool:YES];
        data.tell = @"031-243-1535";
        data.time = @"05시~3시";
        data.detail = @"배달됨..헤헤";
        data.mainImagePath = @"star.png";
        data.menuImagePath = @"starPressed.png";
        data.mapLatitude = [NSNumber numberWithDouble:37.5];
        data.mapLatitudeDelta = [NSNumber numberWithDouble:0.0];
        data.mapLongitude = [NSNumber numberWithDouble:127.0];
        data.mapLongitudeDelta = [NSNumber numberWithDouble:0.0];
        [self.managedObjectContext save:nil];
        
        */
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"restaurantList" ofType:@"txt"];
        NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
        NSArray *rows = [content componentsSeparatedByString:@"\n"];
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];

        for (NSString *row in rows) {
            NSArray *elements = [row componentsSeparatedByString:@"/"];
            Restaurant *data = (Restaurant *)[NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:self.managedObjectContext];
            
            //다음 순서대로 restaurantList.txt를 수정해야 함
            //name/kind/detail/time/isDelivery/isNight/mainImagePath/menuImagePath/mapLatitude/mapLatitudeDelta/mapLongitude/mapLongitudeDelta
            
            data.nameOfTitle = [elements objectAtIndex:0];
            data.kind =  [numberFormatter numberFromString:[elements objectAtIndex:1]];
            data.detail = [elements objectAtIndex:2];
            data.tell = [elements objectAtIndex:3];
            data.time = [elements objectAtIndex:4];
            data.isDelivery = [numberFormatter numberFromString:[elements objectAtIndex:5]];
            data.isNight = [numberFormatter numberFromString:[elements objectAtIndex:6]];
            data.mainImagePath = [elements objectAtIndex:7];
            data.menuImagePath = [elements objectAtIndex:8];
            data.mapLatitude = [numberFormatter numberFromString:[elements objectAtIndex:9]];
            data.mapLongitude = [numberFormatter numberFromString:[elements objectAtIndex:10]];
            data.mapLatitudeDelta = [numberFormatter numberFromString:[elements objectAtIndex:11]];
            data.mapLongitudeDelta = [numberFormatter numberFromString:[elements objectAtIndex:12]];
            
            [self.managedObjectContext save:nil];
            }
    
        
    }
    else {
        NSLog(@"스택에 이미 로딩됐음");    
    }
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
/////////////
- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] & ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Ajoulife.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
@end
