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
#import "STKAudioPlayer.h"
#import "SampleQueueId.h"
#import "AudioPalyerManager.h"



@interface AudioListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *listArr;
@property (strong, nonatomic) IBOutlet UITableView *audioTabelView;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (nonatomic, strong) NSIndexPath *lastIndexPath;


@end

@implementation AudioListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"准播报";
    self.dataArr = [NSMutableArray array];
    self.listArr = self.dataArr;
    self.query = [BmobQuery queryWithClassName:@"Audio"];
    [self.query orderByDescending:@"createdAt"];
    self.query.cachePolicy = kBmobCachePolicyCacheThenNetwork;
    self.audioTabelView.backgroundColor = [UIColor clearColor];
//    self.audioTabelView.separatorColor = [UIColor whiteColor];
    [self setupRefreshWith:self.audioTabelView];
    self.audioTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if ([self.audioTabelView respondsToSelector:@selector(setSeparatorInset:)]) {

        [self.audioTabelView setSeparatorInset:UIEdgeInsetsZero];

    }
    
    
    self.selectedIndexPath = [AudioPalyerManager defaultPlayer].listIndexPath;
    if ([self.audioTabelView respondsToSelector:@selector(setLayoutMargins:)]) {

        [self.audioTabelView setLayoutMargins:UIEdgeInsetsZero];
        
    }
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
//        [tableView beginUpdates];
        
        [UIView animateWithDuration:0.3f animations:^{
            
            [selectedCell changeFrame:YES];
            NSArray *cells = tableView.visibleCells;
            for (UITableViewCell *otherCell in cells) {
                NSIndexPath *otherIndexPath = [tableView indexPathForCell:otherCell];
                if (otherIndexPath.row > self.selectedIndexPath.row) {
                    
                    CGRect rect = otherCell.contentView.frame;
                    rect.origin.y -= 150;
                    otherCell.contentView.frame = rect;
                }
            }
            //        [tableView endUpdates];
//            self.audioTabelView.scrollEnabled = YES;
//            NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:self.selectedIndexPath.row inSection:self.selectedIndexPath.section];
            self.selectedIndexPath = nil;
            //        [tableView reloadRowsAtIndexPaths:@[selectedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            

            
        } completion:^(BOOL finished) {
            [tableView reloadData];
                    }];
    } else {
        [AudioPalyerManager defaultPlayer].listIndexPath = indexPath;
        self.selectedIndexPath = indexPath;
//        self.audioTabelView.scrollEnabled = NO;
//        [tableView beginUpdates];
//        [UIView animateWithDuration:0.3f animations:^{
//            
//        } completion:^(BOOL finished) {
//            
//        }];
        [UIView animateWithDuration:0.3f animations:^{
            
            [cell changeFrame:NO];
            NSArray *cells = tableView.visibleCells;
            for (UITableViewCell *otherCell in cells) {
                    NSIndexPath *otherIndexPath = [tableView indexPathForCell:otherCell];
                    if (otherIndexPath.row > indexPath.row) {
                        
                        CGRect rect = otherCell.contentView.frame;
                        rect.origin.y += 150;
                        otherCell.contentView.frame = rect;
                    }
            }
        } completion:^(BOOL finished) {
            [tableView reloadData];
            //        [tableView endUpdates];
            //        NSArray *arr = [tableView indexPathsForVisibleRows];
            //
            //
            //        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            //
//            if (self.lastIndexPath.row > 3 && indexPath.row >= (self.lastIndexPath.row - 3) && indexPath.row <= self.lastIndexPath.row) {
//                [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
//            }

        }];
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
    self.lastIndexPath = indexPath;
    BaseModel *audio = self.listArr[indexPath.row];
    CellForAudio *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([audio class])];
    if (!cell) {
        cell = (CellForAudio *)[CellFactory cellForModel:audio];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
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
    __block NSInteger count = 1;
    [self.query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (nil != array) {
            if (1 == count) {
                
                if (self.getDataType == refreshData) {
                    [self.listArr removeAllObjects];
                }
                for (BmobObject *object in array) {
                    NSLog(@"%@", object);
                    Audio *audio = [[Audio alloc] initWithBmobObject:object];
                    //
                    [self.listArr addObject:audio];
                }
                count++;
            }
        }
        NSLog(@"array:%@", self.listArr);
        [self endRefreshing];
    }];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{

    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {

        [cell setSeparatorInset:UIEdgeInsetsZero];

    }

    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {

        [cell setLayoutMargins:UIEdgeInsetsZero];

    }

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
