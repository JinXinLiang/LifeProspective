//
//  ShareViewController.m
//  LifeProspective
//
//  Created by Eiwodetianna on 15/4/11.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import "ShareViewController.h"
#import "Share.h"

@interface ShareViewController ()

@property (nonatomic, strong) NSMutableArray *shareArr;

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.shareArr = [NSMutableArray array];
    self.query = [BmobQuery queryWithClassName:@"Share"];
    [self.query orderByDescending:@"createdAt"];
    self.query.cachePolicy = kBmobCachePolicyNetworkElseCache;
}

- (void)getData
{
    self.query.limit = self.limit;
    self.query.skip = self.skip;
    [self.query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (nil != array) {
            if (self.getDataType == refreshData) {
                [self.shareArr removeAllObjects];
            }
            for (BmobObject *object in array) {
                Share *share = [[Share alloc] initWithBmobObject:object];
                
                [self.shareArr addObject:share];
            }
        }
        NSLog(@"array:%@", self.shareArr);
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
