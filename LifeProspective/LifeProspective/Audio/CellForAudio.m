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
#import "AudioPalyerManager.h"
#import "ColorLoadView.h"


@interface CellForAudio ()

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UIImageView *authorPhotoImageView;
@property (nonatomic, strong) UILabel *authorNameLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *blurView;
//@property (nonatomic, strong) UIView *whiteBackView;

@property (nonatomic, strong) UIView *backGround;

@property (nonatomic, strong) UIButton *playBtn;

@property (nonatomic, strong) ColorLoadView *colorLoadView;

@end

@implementation CellForAudio

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 70)];
        self.coverImageView.userInteractionEnabled = YES;
        self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.coverImageView.clipsToBounds = YES;
        self.coverImageView.hidden = YES;
        [self.contentView addSubview:self.coverImageView];
        
        self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.playBtn.frame = CGRectMake(SCREENWIDTH / 2 - 35, 40, 70, 0);
        self.playBtn.backgroundColor = [UIColor clearColor];
//        self.playBtn.frame = CGRectMake(SCREENWIDTH / 2 - 40, 40, 70, 70);
        self.playBtn.alpha = 0.0f;
        
        
        [self.playBtn addTarget:self action:@selector(playBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.coverImageView addSubview:self.playBtn];
        
//        CGRect rect = CGRectMake(0.0f, 0.0f, SCREENWIDTH, 44.0f);
//        UIGraphicsBeginImageContext(rect.size);
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        
//        CGContextSetFillColorWithColor(context, [[UIColor colorWithWhite: 1.0 alpha:0.5f] CGColor]);
//        CGContextFillRect(context, rect);
//        
//        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
        
//        self.blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
//        self.blurView.frame = CGRectMake(0, 0, SCREENWIDTH, self.coverImageView.frame.size.height);
//                self.blurView.alpha = 0.9f;
//        self.blurView.hidden = YES;
//        
//        [self.contentView addSubview:self.blurView];
        self.backGround = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, self.coverImageView.frame.size.height)];
        self.backGround.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.backGround];
        
        if (IS_iOS8) {
            self.blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
            self.blurView.frame = CGRectMake(0, 0, SCREENWIDTH, self.coverImageView.frame.size.height);
            self.blurView.alpha = 0.9f;
        } else {
            self.blurView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, self.coverImageView.frame.size.height)];
            self.blurView.backgroundColor = [UIColor blackColor];
            self.blurView.alpha = 0.6f;
        
        }
        self.blurView.hidden = YES;
        [self.backGround addSubview:self.blurView];
        
       
        self.authorPhotoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 10, 50, 50)];
        self.authorPhotoImageView.layer.cornerRadius = 25.f;
        self.authorPhotoImageView.clipsToBounds = YES;
        self.authorPhotoImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.authorPhotoImageView.layer.borderWidth = 3.f;
        
        [self.backGround addSubview:self.authorPhotoImageView];
        
        
        self.colorLoadView = [[ColorLoadView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        self.colorLoadView.hidden = YES;
//        self.colorLoadView.backgroundColor = [UIColor cyanColor];
        [self.authorPhotoImageView addSubview:self.colorLoadView];
        
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
    
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:audio.audioPhoto] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    
    [self.authorPhotoImageView sd_setImageWithURL:[NSURL URLWithString:audio.authorPhoto]];
    self.titleLabel.text = audio.title;
    
    self.authorNameLabel.text = audio.authorName;
    AudioPalyerManager *player = [AudioPalyerManager defaultPlayer];
    
    [self.playBtn setBackgroundImage:player.playing && [player.playUrl isEqualToString:audio.voiceInfo]? [UIImage imageNamed:@"stop"] : [UIImage imageNamed:@"play"] forState:UIControlStateNormal];
   
  
}

- (void)playBtnAction:(UIButton *)button {
    Audio *audio = (Audio *)self.dataModel;
    AudioPalyerManager *player = [AudioPalyerManager defaultPlayer];
    player.playBtn = button;
    if (player.playing && [player.playUrl isEqualToString:audio.voiceInfo]) {
        [player stop];
        [button setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    } else {
        
        [player playWithUrlString:audio.voiceInfo];
        [button setBackgroundImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
        
    }
}


- (void)changeFrame:(BOOL)origin
{
    if (origin) {
        [UIView animateWithDuration:0.3f animations:^{
            self.coverImageView.hidden = YES;
        
            
            self.coverImageView.frame = CGRectMake(0, 0, SCREENWIDTH, 70);
            self.playBtn.frame = CGRectMake(SCREENWIDTH / 2 - 35, 40, 70, 0);
            self.backGround.frame = CGRectMake(0, 0, SCREENWIDTH, self.coverImageView.frame.size.height);
            self.titleLabel.textColor = [UIColor blackColor];
            self.playBtn.alpha = 0.0f;
            self.authorNameLabel.textColor = [UIColor blackColor];
//            self.blurView.frame = self.backGround.frame;
//            self.whiteBackView.hidden = YES;
            self.blurView.hidden = YES;
            self.colorLoadView.hidden = YES;
        }];
        [self.colorLoadView unactivate];
        
    
    } else {
        [UIView animateWithDuration:0.3f animations:^{
            self.coverImageView.hidden = NO;
        
            self.coverImageView.frame = CGRectMake(0, 0, SCREENWIDTH, 220);
            self.backGround.frame = CGRectMake(0, self.coverImageView.frame.origin.y + self.coverImageView.frame.size.height - 70, SCREENWIDTH, 70);
            self.playBtn.frame = CGRectMake(SCREENWIDTH / 2 - 35, 40, 70, 70);
            self.playBtn.alpha = 1.0f;
//            self.blurView.frame = self.backGround.frame;
            
//            self.whiteBackView.hidden = YES;
            self.blurView.hidden = NO;
            self.titleLabel.textColor = [UIColor whiteColor];
            self.authorNameLabel.textColor = [UIColor whiteColor];
            self.colorLoadView.hidden = NO;

        }];
        [self.colorLoadView activate];
        
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
