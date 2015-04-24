//
//  CellForArticle.m
//  LifeProspective
//
//  Created by Eiwodetianna on 15/3/30.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import "CellForArticle.h"
#import "UIColor+AddColor.h"
#import "Article.h"
#import "UIImageView+WebCache.h"

@interface CellForArticle ()

@property (nonatomic, strong)UIView *blueView;

@end

@implementation CellForArticle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
  
        self.backgroundColor = [UIColor clearColor];
        self.articleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.articleImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.articleImageView.layer.cornerRadius = 7;
        self.articleImageView.clipsToBounds = YES;
        self.articleImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.articleImageView];
        
    self.articleImageView.layer.shadowOffset = CGSizeMake(0, 0);
    self.articleImageView.layer.shadowOpacity = 0.8;
        self.articleImageView.layer.shadowRadius = 7;
        
    self.articleImageView.layer.shadowColor = [UIColor blackColor].CGColor;
        
//        self.blueView = [[UIView alloc] initWithFrame:CGRectZero];
//        self.blueView.backgroundColor = [UIColor lifeGreenColor];
//        [self.contentView addSubview:self.blueView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.textColor = [UIColor whiteColor];
//        self.titleLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.titleLabel];
        
//        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        self.dateLabel.backgroundColor = [UIColor blueColor];
//        [self.contentView addSubview:self.dateLabel];
    }
    return self;
}


- (void)setDataModel:(BaseModel *)dataModel
{
    [super setDataModel:dataModel];
    Article *article = (Article *)dataModel;
    self.titleLabel.text = article.title;
    [self.articleImageView sd_setImageWithURL:[NSURL URLWithString:article.pic] placeholderImage:[UIImage imageNamed:@"placeholder"]];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//    NSString *dateStr = [formatter stringFromDate:article.createdAt];
//    self.dateLabel.text = dateStr;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.articleImageView.frame = CGRectMake(0, 0, self.frame.size.width, 170);
    self.blueView.frame = CGRectMake(0, 155, self.frame.size.width, 3);
    [self.titleLabel sizeToFit];
    self.titleLabel.frame = CGRectMake(10, 175, self.frame.size.width - 10, 25);
//    self.dateLabel.frame = CGRectMake(10, 185, self.frame.size.width - 10, 20);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
