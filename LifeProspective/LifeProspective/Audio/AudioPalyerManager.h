//
//  AudioPalyerManager.h
//  LifeProspective
//
//  Created by Eiwodetianna on 15/4/24.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STKAudioPlayer.h"

@interface AudioPalyerManager : NSObject 


@property (nonatomic, strong)NSIndexPath *listIndexPath;
@property (nonatomic, assign)BOOL playing;
@property (nonatomic, copy, readonly)NSString *playUrl;
@property (nonatomic, strong)UIButton *playBtn;
@property (nonatomic, strong) STKAudioPlayer *player;

+ (AudioPalyerManager *)defaultPlayer;
- (void)playWithUrlString:(NSString *)urlString;
- (void)stop;
@end
