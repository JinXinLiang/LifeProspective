//
//  CellFactory.m
//  LifeProspective
//
//  Created by Eiwodetianna on 15/3/21.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import "CellFactory.h"
#import "BaseCell.h"
#import "BaseModel.h"

@implementation CellFactory

+ (BaseCell *)cellForModel:(BaseModel *)dataModel
{
    NSString *className = [@"CellFor" stringByAppendingString:NSStringFromClass([dataModel class])];
    
    Class class = NSClassFromString(className);
    
    BaseCell *cell = [[class alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([dataModel class])];
    
    return cell;
}

@end
