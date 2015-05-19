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
#import "UIView+Shadow.h"

@interface CellForArticle ()

@property (nonatomic, strong)UIView *blueView;
@property (nonatomic, strong) UIImageView *separatorView;

@end

@implementation CellForArticle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
  
        self.backgroundColor = [UIColor clearColor];
        self.articleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, SCREENWIDTH - 30, 170)];
        self.articleImageView.contentMode = UIViewContentModeScaleAspectFill;
       
        [self.contentView addSubview:self.articleImageView];
//        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.articleImageView.bounds];

        
//         self.articleImageView.layer.shadowPath = shadowPath.CGPath;
                self.articleImageView.layer.cornerRadius = 7;
//        self.articleImageView.layer.masksToBounds = NO;
        self.articleImageView.clipsToBounds = YES;
    self.articleImageView.layer.shadowOffset = CGSizeMake(0.f, 0.f);
    self.articleImageView.layer.shadowOpacity = 0.8;
        self.articleImageView.layer.shadowRadius = 5;
//
    self.articleImageView.layer.shadowColor = [UIColor blackColor].CGColor;
//        [self.articleImageView makeInsetShadowWithRadius:5.f Alpha:0.8];
        
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
        self.separatorView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.separatorView.image = [UIImage imageNamed:@"separatorView"];
        self.separatorView.frame = CGRectZero;
        [self.contentView addSubview:self.separatorView];
    }
    return self;
}


- (void)setDataModel:(BaseModel *)dataModel
{
    [super setDataModel:dataModel];
    Article *article = (Article *)dataModel;
    self.titleLabel.text = article.title;
    [self.articleImageView sd_setImageWithURL:[NSURL URLWithString:article.picUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
//    [self.articleImageView sd_sd_setImageWithURL:[NSURL URLWithString:article.picUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//    NSString *dateStr = [formatter stringFromDate:article.createdAt];
//    self.dateLabel.text = dateStr;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.articleImageView.frame = CGRectMake(15, 10, self.frame.size.width - 30, 165);
    [self.titleLabel sizeToFit];
    self.titleLabel.frame = CGRectMake(15, self.articleImageView.frame.origin.y + self.articleImageView.frame.size.height + 10, self.frame.size.width - 30, 25);
    self.separatorView.frame = CGRectMake(0, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 15, SCREENWIDTH, 1);
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
