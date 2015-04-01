//
//  BaseModel.m
//  LifeProspective
//
//  Created by Eiwodetianna on 15/3/4.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import "BaseModel.h"
#import "NSObject+MJKeyValue.h"

@implementation BaseModel

- (instancetype)initWithBmobObject:(BmobObject *)object
{
    self = [super init];
    if (self) {
        NSDictionary *dic = [object keyValues];
        [self setValuesForKeysWithDictionary:[dic objectForKey:@"bmobDataDic"]];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
