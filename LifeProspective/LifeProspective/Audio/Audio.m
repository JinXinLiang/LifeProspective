//
//  Audio.m
//  LifeProspective
//
//  Created by Eiwodetianna on 15/4/14.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import "Audio.h"

@implementation Audio

- (instancetype)initWithBmobObject:(BmobObject *)object
{
    self = [super initWithBmobObject:object];
    if (self) {
        BmobFile *audioPhoto = [object objectForKey:@"audio_Photo"];
        
        self.audioPhoto = audioPhoto.url;
        
        BmobFile *authorPhoto = [object objectForKey:@"author_Photo"];
        
        self.authorPhoto = authorPhoto.url;
        
        BmobFile *voiceInfo = [object objectForKey:@"voice"];
        self.voiceInfo = voiceInfo.url;
        

        
//        BmobQuery *bquery = [BmobQuery queryWithClassName:@"Author"];
//        [bquery orderByDescending:@"updatedAt"];
//        [bquery whereObjectKey:@"author" relatedTo:object];
//        [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//            for (BmobObject * author in array) {
//                
//                self.authorInfo = [[Author alloc] initWithBmobObject:author];
//            }
//        }];
    }
    return self;
}




@end
