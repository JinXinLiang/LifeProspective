//
//  Audio.h
//  LifeProspective
//
//  Created by Eiwodetianna on 15/4/14.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import "BaseModel.h"
#import "Author.h"

@interface Audio : BaseModel

@property (nonatomic, strong)NSData *voice;
@property (nonatomic, strong)Author *author;

@property (nonatomic, strong)NSData *audio_Photo;
@property (nonatomic, strong) NSString *title;

@end
