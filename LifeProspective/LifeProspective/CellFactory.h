//
//  CellFactory.h
//  LifeProspective
//
//  Created by Eiwodetianna on 15/3/21.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseCell.h"
#import "BaseModel.h"

@interface CellFactory : NSObject

+ (BaseCell *)cellForModel:(BaseModel *)dataModel;

@end
