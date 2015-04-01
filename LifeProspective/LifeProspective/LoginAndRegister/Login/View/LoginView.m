//
//  LoginView.m
//  LifeProspective
//
//  Created by Eiwodetianna on 15/3/4.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = LPBLUECORLOR;
        UIImage *titleImage = [UIImage imageNamed:@"title"];
        UIImageView *titleView = [[UIImageView alloc] initWithFrame:CGRectMake(self.center.x / 2 - 30, self.center.y / 2 - 30, 200, 30)];
        titleView.image = titleImage;
        [self addSubview:titleView];
        
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
