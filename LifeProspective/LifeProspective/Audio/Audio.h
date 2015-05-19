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

@property (nonatomic, copy)NSString *voiceInfo;
@property (nonatomic, strong)Author *authorInfo;

@property (nonatomic, copy)NSString *audioPhoto;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, copy) NSString *authorName;
@property (nonatomic, copy) NSString *authorPhoto;
@property (nonatomic, copy) NSString *audioUrl;

@end
