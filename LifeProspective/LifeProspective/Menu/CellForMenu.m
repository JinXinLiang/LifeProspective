//
//  CellForMenu.m
//  LifeProspective
//
//  Created by Eiwodetianna on 15/4/9.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import "CellForMenu.h"

@implementation CellForMenu

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.menuItem = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 110, 110)];
        [self.contentView addSubview:self.menuItem];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
