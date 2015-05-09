//
//  ColorLoadView.m
//  LifeProspective
//
//  Created by Eiwodetianna on 15/4/28.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import "ColorLoadView.h"

@interface ColorLoadView ()

@property (nonatomic, strong)UIImageView *colorImageView;

@end

@implementation ColorLoadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.colorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, self.frame.size.width-6, self.frame.size.height-6)];
        self.colorImageView.image = [UIImage imageNamed:@"loadColor"];
        self.colorImageView.userInteractionEnabled = YES;
        [self addSubview:self.colorImageView];
        self.colorImageView.hidden = YES;
        self.userInteractionEnabled = YES;
        
        
    }
    return self;
}

- (void)activate{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadAction:) name:@"colorLoad" object:nil];
}

- (void)unactivate {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"colorLoad" object:nil];
}

- (void)loadAction:(NSNotification *)notification {
    NSLog(@"loading");
    if ([notification.object isEqualToString:@"buffering"]) {
        [self startLoading];
    } else if ([notification.object isEqualToString:@"playing"]) {
        [self stopLoading];
    }
}

- (void)startLoading{
    self.colorImageView.hidden = NO;
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    CGRect frame = [self.colorImageView frame];
    self.colorImageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    self.colorImageView.layer.position = CGPointMake(frame.origin.x + 0.5 * frame.size.width, frame.origin.y + 0.5 * frame.size.height);
    [CATransaction commit];
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
    [CATransaction setValue:[NSNumber numberWithFloat:2.0] forKey:kCATransactionAnimationDuration];
    
    CABasicAnimation *animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.0];
    animation.toValue = [NSNumber numberWithFloat:2 * M_PI];
    animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
    animation.delegate = self;
    [self.colorImageView.layer addAnimation:animation forKey:@"rotationAnimation"];
    
    [CATransaction commit];
}

- (void)stopLoading {
    [self.colorImageView.layer removeAllAnimations];
    self.colorImageView.hidden = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
