//
//  BaseModel.h
//  LifeProspective
//
//  Created by Eiwodetianna on 15/3/4.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BmobSDK/BmobObject.h>
@interface BaseModel : BmobObject

- (instancetype)initWithBmobObject:(BmobObject *)object;

@end
