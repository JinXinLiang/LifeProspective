//
//  CellForAudio.m
//  LifeProspective
//
//  Created by Eiwodetianna on 15/4/16.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import "CellForAudio.h"
#import "Audio.h"


@interface CellForAudio ()

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UIImageView *authorPhotoImageView;
@property (nonatomic, strong) UILabel *detailLabel;
@end

@implementation CellForAudio

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.authorPhotoImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        
        
    }
    return self;
}

- (void)setDataModel:(BaseModel *)dataModel
{
    [super setDataModel:dataModel];
    Audio *audio = (Audio *)dataModel;
    [self.authorPhotoImageView sd_setImageWithURL:[NSURL URLWithString:audio.audio_Photo]];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
