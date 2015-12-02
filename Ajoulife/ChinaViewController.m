//
//  ChinaViewController.m
//  Ajoulife
//
//  Created by  on 13. 5. 26..
//  Copyright (c) 2013년 __MyCompanyName__. All rights reserved.
//

#import "ChinaViewController.h"
#import "ChinaDetailViewController.h"
#import "AddViewController.h"
#import "Restaurant.h"

@interface ChinaViewController ()

@end

@implementation ChinaViewController
@synthesize addButton;

@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize kind, isNight, isFavorite, isDelivery, searchCondition1;

- (void)setupFetchedResultsController
{
    // 1 - Decide what Entity you want
    NSString *entityName = @"Restaurant";
    NSLog(@"Entity %@에서 category1:%d, 배달가능:%i 영업시간:%i 만 필터하여 fetch합니다.", entityName, kind, isDelivery, isNight);
    
    // 2 - Request that Entity
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    // 3 - Filter it if you want
    //NSString *filterString = [NSString stringWithFormat:@"Restaurant.category1 = %@", categorySelect];
    
    // 야식이면 isNignt == YES인 것만 fetch 
    if (kind == 8)
    {
        request.predicate = [NSPredicate predicateWithFormat:@"isNight == %@", [NSNumber numberWithBool:YES]];        
    }
    else if (kind == 10)
    {
         request.predicate = [NSPredicate predicateWithFormat:@"isFavorite == %@", [NSNumber numberWithBool:YES]];     
        
    }
    else if (kind == 11)
    {
        NSString *predicateString = @"";
        
        
        if (isNight) {
            predicateString = [predicateString stringByAppendingFormat:@"isNight == %@ AND ", [NSNumber numberWithBool:isNight]];
        }
        
        if (isDelivery) {
            predicateString = [predicateString stringByAppendingFormat:@"isDelivery == %@ AND ", [NSNumber numberWithBool:isDelivery]];
        }
        
        if (searchCondition1 == 0) {
            predicateString = [predicateString stringByAppendingFormat:@"kind != %@", [NSNumber numberWithInt:999]];
        } else {
            predicateString = [predicateString stringByAppendingFormat:@"kind == %@", [NSNumber numberWithInt:searchCondition1]];
        }
        
        NSLog(@"(%@) 조건에서 fetch!", predicateString);
        request.predicate = [NSPredicate predicateWithFormat:predicateString];   
        
    }
    else
    {
        request.predicate = [NSPredicate predicateWithFormat:@"kind == %@", [NSNumber numberWithInt:kind]]; 
    }
    
    // 4 - Sort it if you want
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"nameOfTitle"
                                                                                     ascending:YES
                                                                                      selector:@selector(localizedCaseInsensitiveCompare:)]];
    // 5 - Fetch it
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    [self performFetch];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupFetchedResultsController];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    id appDelegate = (id)[[UIApplication sharedApplication] delegate]; 
    self.managedObjectContext = [appDelegate managedObjectContext];
    
    if(kind == 8 || kind == 10 || kind == 11)
    {
        self.addButton.enabled = NO;
    }

    // [self.managedObjectContext deleteObject:data];
    // [self.managedObjectContext save:nil];
    
}

- (void)viewDidUnload
{
    [self setAddButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


// 테이블 뷰 내용 구성하는 함수
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ChiCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    Restaurant *data = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //RestaurantData *data = [self.listData objectAtIndex:indexPath.row];

    UIImageView *MainImageView = (UIImageView *)[cell viewWithTag:101];
    MainImageView.image = [UIImage imageNamed:data.mainImagePath];
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:201];
    nameLabel.text = data.nameOfTitle;
    
    UILabel *telLabel = (UILabel *)[cell viewWithTag:301];
    telLabel.text = data.tell;
 
    UILabel *detailLabel = (UILabel *)[cell viewWithTag:401];
    detailLabel.text = data.detail;
    
    UILabel *timeLabel = (UILabel *)[cell viewWithTag:501];
    timeLabel.text = data.time;
    
    UIButton *star = (UIButton *)[cell viewWithTag:801];
    if ([data.isFavorite boolValue]) {
        star.imageView.image = [UIImage imageNamed:@"starPressed.png"];
    } else {
        star.imageView.image = [UIImage imageNamed:@"star.png"];
    }
    
    /*
    UIButton *ImageView = (UIImageView *)[cell viewWithTag:801];
    TimeImageView.image = [UIImage imageNamed:data.TimeImagePath];
    */
    /*UIImageView *TimeImageView = (UIImageView *)[cell viewWithTag:601];
    TimeImageView.image = [UIImage imageNamed:data.TimeImagePath];
a    */
    
    return cell;
}

// 테이블 뷰 셀이 눌렸을 때 세부정보로 가는 함수
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChinaDetailViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"detailChina"];
    
    Restaurant *data = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    detail.imagePath = data.menuImagePath;
    detail.tell = data.tell;
    
    
    // sending map data   
    
    detail.latitude =  [data.mapLatitude doubleValue];    
    detail.longitude = [data.mapLongitude doubleValue];
    detail.latitudeDelta = [data.mapLatitudeDelta doubleValue];
    detail.longitudeDelta = [data.mapLongitudeDelta doubleValue];

    MKPinAnnotationView *annotationView = nil; 
    annotationView.canShowCallout = YES;
    [self.navigationController pushViewController:detail animated:YES];
    
    [tableView reloadData];
    
}

// 전화 버튼 눌렸을 때 전화하는 코드
- (IBAction)callButtonPressed:(id)sender {
        
    UIButton *button = (UIButton *)sender;
    UITableViewCell *cell = (UITableViewCell *)button.superview.superview;
    UITableView *tableView = (UITableView *)cell.superview;
    NSIndexPath *indexPath = [tableView indexPathForCell:cell];
    
    Restaurant *data = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSString *tell = data.tell;
    
    // 기호 제거
    tell = [[tell componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
    NSLog(@"전화번호에서 기호 제거 : %@", tell);
    
    // telString : tel://1231444 형태가 되도록 수정
    NSString *tellString = @"tel://";
    tellString = [tellString stringByAppendingString:tell];
    
    // 전화 걸기
    NSLog(@"Calling to %@", tellString);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tellString]];
}

//별 버튼 눌렀을 때 데이터 내용 바꾸는 코드
- (IBAction)starPressed:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    UITableViewCell *cell = (UITableViewCell *)button.superview.superview;
    UITableView *tableView = (UITableView *)cell.superview;
    NSIndexPath *indexPath = [tableView indexPathForCell:cell];
    
    Restaurant *data = [self.fetchedResultsController objectAtIndexPath:indexPath];
    if([data.isFavorite boolValue] ) {
        data.isFavorite = [NSNumber numberWithBool:NO];
        [sender imageView].image = [UIImage imageNamed:@"star.png"];
    } else {
        data.isFavorite = [NSNumber numberWithBool:YES];
        [sender imageView].image = [UIImage imageNamed:@"starPressed.png"];
    }
    
    NSLog(@"즐겨찾기->%@", data.isFavorite);
    
    NSError *error = nil;
    [self.managedObjectContext save:&error];  
    [tableView reloadData];
    
    //[self.managedObjectContext deleteObject:data];
}

- (IBAction)plusButtonPressed:(id)sender {
      
    AddViewController *add = [self.storyboard instantiateViewControllerWithIdentifier:@"add"];
    
    add.kind = self.kind;
    NSLog(@"%d", add.kind);
    
    [self.navigationController pushViewController:add animated:YES];
}
@end
