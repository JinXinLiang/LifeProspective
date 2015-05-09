//
//  Article.m
//  LifeProspective
//
//  Created by Eiwodetianna on 15/3/30.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import "Article.h"

@implementation Article

- (instancetype)initWithBmobObject:(BmobObject *)object
{
    self = [super initWithBmobObject:object];
    if (self) {
        BmobFile *articlePic = [object objectForKey:@"articlePic"];
        
        self.picUrl = articlePic.url;
    }
    return self;
    
}

@end
