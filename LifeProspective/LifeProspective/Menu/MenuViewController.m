//
//  MenuViewController.m
//  LifeProspective
//
//  Created by Eiwodetianna on 15/3/19.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import "MenuViewController.h"
#import "UIColor+AddColor.h"

@interface MenuViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *menuTableView;
@property (strong, nonatomic) NSArray *menuImageArr;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.menuImageArr = @[[UIImage imageNamed:@"menuChat.png"], [UIImage imageNamed:@"menuUsers.png"], [UIImage imageNamed:@"menuMap.png"], [UIImage imageNamed:@"menuClose.png"]];
    self.menuTableView.separatorColor = [UIColor grayColor];
    self.menuTableView.rowHeight = 120.f;
    self.menuTableView.backgroundColor = [UIColor colorFromHexCode:@"#1c1c1c"];
    self.menuTableView.separatorInset = UIEdgeInsetsZero;
    
    if ([self.menuTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.menuTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.menuTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.menuTableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
   
   
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *resuse = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resuse];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:resuse];
        cell.backgroundColor = [UIColor colorFromHexCode:@"#1c1c1c"];
    }

    cell.imageView.image = self.menuImageArr[indexPath.row];
    return cell;
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
