//
//  TabView.m
//  LifeProspective
//
//  Created by Eiwodetianna on 15/4/1.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import "TabView.h"
#import "UIColor+AddColor.h"

@implementation TabView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lifeGreenColor];
        
        self.allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.allBtn.frame = CGRectMake(self.center.x / 2 - 40, 6, 80, 30);
        [self.allBtn setTitle:@"All" forState:UIControlStateNormal];
        self.allBtn.layer.cornerRadius = 10;
        self.allBtn.backgroundColor = [UIColor lifeGreenColor];
        self.allBtn.clipsToBounds = YES;
        [self addSubview:self.allBtn];
        self.friendsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.friendsBtn.frame = CGRectMake(self.center.x - 40, 6, 80, 30);
        [self.friendsBtn setTitle:@"Friends" forState:UIControlStateNormal];
        self.friendsBtn.layer.cornerRadius = 10;
        self.friendsBtn.backgroundColor = [UIColor lifeGreenColor];
        self.friendsBtn.clipsToBounds = YES;
        [self addSubview:self.friendsBtn];
        self.lifeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.lifeBtn.frame = CGRectMake(self.center.x + self.center.x / 2 - 40, 6, 80, 30);
        [self.lifeBtn setTitle:@"Life" forState:UIControlStateNormal];
        self.lifeBtn.layer.cornerRadius = 10;
        self.lifeBtn.backgroundColor = [UIColor lifeGreenColor];
        self.lifeBtn.clipsToBounds = YES;
        [self addSubview:self.lifeBtn];
        
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
