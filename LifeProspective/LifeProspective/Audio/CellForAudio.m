//
//  CellForAudio.m
//  LifeProspective
//
//  Created by Eiwodetianna on 15/4/16.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import "CellForAudio.h"
#import "Audio.h"
#import <BmobSDK/BmobFile.h>
#import "FXBlurView.h"
#import "DRNRealTimeBlurView.h"
#import "AMBlurView.h"



@interface CellForAudio ()

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UIImageView *authorPhotoImageView;
@property (nonatomic, strong) UILabel *authorNameLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) AMBlurView *blurView;
@property (nonatomic, strong) UIView *whiteBackView;

@property (nonatomic, strong) UIView *backGround;
@end

@implementation CellForAudio

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 70)];
        self.coverImageView.contentMode = UIViewContentModeRedraw;
        self.coverImageView.hidden = YES;
        [self.contentView addSubview:self.coverImageView];
        
//        CGRect rect = CGRectMake(0.0f, 0.0f, SCREENWIDTH, 44.0f);
//        UIGraphicsBeginImageContext(rect.size);
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        
//        CGContextSetFillColorWithColor(context, [[UIColor colorWithWhite: 1.0 alpha:0.5f] CGColor]);
//        CGContextFillRect(context, rect);
//        
//        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        self.blurView = [[AMBlurView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, self.coverImageView.frame.size.height)];
//        self.blurView.alpha = 0.5f;
//        self.blurView.hidden = YES;
//        [self.contentView addSubview:self.blurView];
        self.backGround = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, self.coverImageView.frame.size.height)];
        self.backGround.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.backGround];
        
//        self.backGround.isGlassEffectOn = YES;
//        self.backGround.image = image;
//        self.backGround.blurTintColor = [UIColor colorWithRed:1
//                                                         green:1
//                                                          blue:1
//                                                         alpha:0.3];
//        self.backGround.tintColor = [UIColor whiteColor];
////        self.backGround.blurRadius = 10.f;
//        [self.backGround setDynamic:YES];
        
        
        self.whiteBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, self.backGround.frame.size.height)];
        self.whiteBackView.backgroundColor = [UIColor blackColor];
        self.whiteBackView.alpha = 0.6f;
        self.whiteBackView.hidden = YES;
        [self.backGround addSubview:self.whiteBackView];
        self.authorPhotoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 10, 50, 50)];
        self.authorPhotoImageView.layer.cornerRadius = 25.f;
        self.authorPhotoImageView.clipsToBounds = YES;
        
        [self.backGround addSubview:self.authorPhotoImageView];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 10, SCREENWIDTH - 110 - 20, 30)];
        self.titleLabel.textColor = [UIColor blackColor];
        [self.backGround addSubview:self.titleLabel];
        self.authorNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 40, SCREENWIDTH - 110 - 20, 20)];
        self.authorNameLabel.textColor = [UIColor blackColor];
        [self.backGround addSubview:self.authorNameLabel];
        
    }
    return self;
}

- (void)setDataModel:(BaseModel *)dataModel
{
    [super setDataModel:dataModel];
    Audio *audio = (Audio *)dataModel;
    
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:audio.audioPhoto]];
    
    
    [self.authorPhotoImageView sd_setImageWithURL:[NSURL URLWithString:audio.authorPhoto]];
    self.titleLabel.text = audio.title;
    
    self.authorNameLabel.text = audio.authorName;
   
  
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    self.coverImageView.frame = CGRectMake(0, 0, SCREENWIDTH, 220);
//    self.backGround.frame = CGRectMake(0, self.coverImageView.frame.origin.y + self.coverImageView.frame.size.height- self.coverImageView.frame.size.height / 3, SCREENWIDTH, self.coverImageView.frame.size.height / 3);

    
    
    
//    [self.contentView sendSubviewToBack:view];
}

- (void)changeFrame:(BOOL)origin
{
    if (origin) {
        [UIView animateWithDuration:0.3f animations:^{
            self.coverImageView.hidden = YES;
        
            
            self.coverImageView.frame = CGRectMake(0, 0, SCREENWIDTH, 70);
            self.backGround.frame = CGRectMake(0, 0, SCREENWIDTH, self.coverImageView.frame.size.height);
            self.titleLabel.textColor = [UIColor blackColor];
            self.authorNameLabel.textColor = [UIColor blackColor];
//            self.blurView.frame = self.backGround.frame;
            self.whiteBackView.hidden = YES;
        }];
        
//        self.blurView.hidden = YES;
    
    } else {
        [UIView animateWithDuration:0.3f animations:^{
            self.coverImageView.hidden = NO;
        
            self.coverImageView.frame = CGRectMake(0, 0, SCREENWIDTH, 220);
            self.backGround.frame = CGRectMake(0, self.coverImageView.frame.origin.y + self.coverImageView.frame.size.height - 70, SCREENWIDTH, 70);
//            self.blurView.frame = self.backGround.frame;
            
            self.whiteBackView.hidden = NO;
//            self.blurView.hidden = NO;
            self.titleLabel.textColor = [UIColor whiteColor];
            self.authorNameLabel.textColor = [UIColor whiteColor];

        } completion:^(BOOL finished) {
            if (finished) {
                
            }
        }];
//        [UIView animateWithDuration:0.2f animations:^{
//        
//        
////            self.blurView.opaque = YES;
//       
////            self.whiteBackView.alpha = 0.35;
//        }];
//
        
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
