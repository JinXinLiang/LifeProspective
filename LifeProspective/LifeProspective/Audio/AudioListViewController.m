//
//  AudioListViewController.m
//  LifeProspective
//
//  Created by Eiwodetianna on 15/4/10.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import "AudioListViewController.h"
#import "Audio.h"
#import "CellFactory.h"
#import "CellForAudio.h"



@interface AudioListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *listArr;
@property (strong, nonatomic) IBOutlet UITableView *audioTabelView;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation AudioListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.listArr = [NSMutableArray array];
    self.query = [BmobQuery queryWithClassName:@"Audio"];
    [self.query orderByDescending:@"createdAt"];
    self.query.cachePolicy = kBmobCachePolicyNetworkElseCache;
    self.audioTabelView.backgroundColor = [UIColor clearColor];
    [self setupRefreshWith:self.audioTabelView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (self.selectedIndexPath != nil && indexPath.row == self.selectedIndexPath.row) {
        
        return 220;
    }
    
    return 70;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CellForAudio *cell = (CellForAudio *)[tableView cellForRowAtIndexPath:indexPath];
    
//    NSMutableArray *indexPathArr = [NSMutableArray array];
//    if (self.selectedIndexPath == nil || self.selectedIndexPath.row != indexPath.row) {
//        if (self.selectedIndexPath != nil) {
//            [indexPathArr addObject:[NSIndexPath indexPathForRow:self.selectedIndexPath.row inSection:self.selectedIndexPath.section]];
//            
////            [tableView reloadRowsAtIndexPaths:@[self.selectedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
//        }
//        self.selectedIndexPath = indexPath;
//        [indexPathArr addObject:indexPath];
////        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
//        [cell changeFrame:NO];
//    } else {
//        [indexPathArr addObject:indexPath];
//        self.selectedIndexPath = nil;
//        [cell changeFrame:YES];
//    }
    
    if (self.selectedIndexPath != nil) {
        CellForAudio *selectedCell = (CellForAudio *)[tableView cellForRowAtIndexPath:self.selectedIndexPath];
        [selectedCell changeFrame:YES];
        self.audioTabelView.scrollEnabled = YES;
        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:self.selectedIndexPath.row inSection:self.selectedIndexPath.section];
        self.selectedIndexPath = nil;
        [tableView reloadRowsAtIndexPaths:@[selectedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    } else {
        self.selectedIndexPath = indexPath;
        self.audioTabelView.scrollEnabled = NO;
        [cell changeFrame:NO];
        [tableView reloadRowsAtIndexPaths:@[self.selectedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
        
//            [tableView reloadRowsAtIndexPaths:indexPathArr withRowAnimation:UITableViewRowAnimationNone];
//    [tableView reloadData];
    
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
        
//    });
    
    
}

#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseModel *audio = self.listArr[indexPath.row];
    CellForAudio *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([audio class])];
    if (!cell) {
        cell = (CellForAudio *)[CellFactory cellForModel:audio];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if (self.selectedIndexPath) {
        
        if (self.selectedIndexPath.row == indexPath.row) {
            [cell changeFrame:NO];
        } else {
            [cell changeFrame:YES];
        }
    } else {
        [cell changeFrame:YES];
    }
    cell.dataModel = audio;
    return cell;
}

- (void)getData
{
    self.query.limit = self.limit;
    self.query.skip = self.skip;
    [self.query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (nil != array) {
            if (self.getDataType == refreshData) {
                [self.listArr removeAllObjects];
            }
            for (BmobObject *object in array) {
                NSLog(@"%@", object);
                Audio *audio = [[Audio alloc] initWithBmobObject:object];
//
                [self.listArr addObject:audio];
            }
        }
        NSLog(@"array:%@", self.listArr);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
