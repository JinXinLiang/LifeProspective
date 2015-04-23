//
//  Author.m
//  LifeProspective
//
//  Created by Eiwodetianna on 15/4/14.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import "Author.h"

@implementation Author

- (instancetype)initWithBmobObject:(BmobObject *)object
{
    self = [super initWithBmobObject:object];
    if (self) {
 
        
        BmobFile *authorPhoto = [object objectForKey:@"author_photo"];
        self.authorPhoto = authorPhoto.url;
        
    }
    return self;
}



@end
