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


@interface AudioListViewController ()

@property (nonatomic, strong) NSMutableArray *listArr;

@end

@implementation AudioListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.listArr = [NSMutableArray array];
    self.query = [BmobQuery queryWithClassName:@"Audio"];
    [self.query orderByDescending:@"createdAt"];
    self.query.cachePolicy = kBmobCachePolicyNetworkElseCache;
    
}

#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseModel *audio = self.listArr[indexPath.row];
    BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([audio class])];
    if (!cell) {
        cell = [CellFactory cellForModel:audio];
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
                Audio *audio = [[Audio alloc] initWithBmobObject:object];
                
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
