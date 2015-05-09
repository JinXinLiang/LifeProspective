//
//  AudioPalyerManager.m
//  LifeProspective
//
//  Created by Eiwodetianna on 15/4/24.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import "AudioPalyerManager.h"
#import <AVFoundation/AVFoundation.h>
#import "STKAudioPlayer.h"
#import "SampleQueueId.h"

NSString *str;

@interface AudioPalyerManager ()<STKAudioPlayerDelegate>

@property (nonatomic, strong) STKAudioPlayer *player;

@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy, readwrite)NSString *playUrl;



@end

@implementation AudioPalyerManager



- (instancetype)init
{
    self = [super init];
    if (self) {
        
      
        self.player = [[STKAudioPlayer alloc] initWithOptions:(STKAudioPlayerOptions){ .flushQueueOnSeek = YES, .enableVolumeMixer = YES, .equalizerBandFrequencies = {50, 100, 200, 400, 800, 1600, 2600, 16000} }];
        
        
            self.player.delegate = self;
//        self.player.volume = 0.2;
        self.player.meteringEnabled = YES;

//        self.player = [[AVPlayer alloc] init];
        self.playing = NO;

        
       
    }
    return self;
}




+ (AudioPalyerManager *)defaultPlayer{
    static AudioPalyerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AudioPalyerManager alloc] init];
    });
    return manager;
}


- (void)playWithUrlString:(NSString *)urlString {
    self.playUrl = urlString;
    NSURL *url = [NSURL URLWithString:urlString];
    if (self.playing) {
        [self stop];
    }
//    [self.player replaceCurrentItemWithPlayerItem:[[AVPlayerItem alloc]  initWithURL:url]];
//    self.player = [AVPlayer playerWithURL:url];
//    [self.player play];
    STKDataSource *dataSource = [STKAudioPlayer dataSourceFromURL:url];
    
    [self.player setDataSource:dataSource withQueueItemId:[[SampleQueueId alloc] initWithUrl:url andCount:0]];
    self.playing = YES;

}

- (void)stop {
    
    [self.player stop];
    self.playing = NO;
}


#pragma mark - 播放器协议方法
/// Raised when an item has started playing
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didStartPlayingQueueItemId:(NSObject*)queueItemId
{
    NSLog(@"开始播放");
}
/// Raised when an item has finished buffering (may or may not be the currently playing item)
/// This event may be raised multiple times for the same item if seek is invoked on the player
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didFinishBufferingSourceWithQueueItemId:(NSObject*)queueItemId
{
    NSLog(@"完成加载");
}
/// Raised when the state of the player has changed
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer stateChanged:(STKAudioPlayerState)state previousState:(STKAudioPlayerState)previousState
{
    NSLog(@"播放状态改变");
    if (previousState == STKAudioPlayerStateReady && state == STKAudioPlayerStateBuffering) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"colorLoad" object:@"buffering"];
    } else if (state == STKAudioPlayerStatePlaying) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"colorLoad" object:@"playing"];
    } else if (state == STKAudioPlayerStateStopped){
        [self.playBtn setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        self.playing = NO;
    }
    
}
/// Raised when an item has finished playing
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didFinishPlayingQueueItemId:(NSObject*)queueItemId withReason:(STKAudioPlayerStopReason)stopReason andProgress:(double)progress andDuration:(double)duration
{
    self.playing = NO;
    NSLog(@"结束播放");
    NSLog(@"结束原因: %d, progress: %f, duration: %f", stopReason, progress, duration);
}
/// Raised when an unexpected and possibly unrecoverable error has occured (usually best to recreate the STKAudioPlauyer)
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer unexpectedError:(STKAudioPlayerErrorCode)errorCode
{
    NSLog(@"错误原因: %d", errorCode);
}


/// Optionally implemented to get logging information from the STKAudioPlayer (used internally for debugging)
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer logInfo:(NSString*)line
{
    NSLog(@"信息: %@", line);
}
/// Raised when items queued items are cleared (usually because of a call to play, setDataSource or stop)
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didCancelQueuedItems:(NSArray*)queuedItems
{
    NSLog(@"未知");
}


@end
