//
//  NOVBookTableViewCell.m
//  小说
//
//  Created by 李飞艳 on 2018/4/10.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVBookTableViewCell.h"
#import "NOVbookMessage.h"
#import <UIImageView+WebCache.h>

@implementation NOVBookTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _leftImageView = [[UIImageView alloc] init];
        [self addSubview:_leftImageView];
        
        _bookName = [[UILabel alloc] init];
        [self addSubview:_bookName];
        
        _authorName = [[UILabel alloc] init];
        [self addSubview:_authorName];
        
        _createTimeLabel = [[UILabel alloc] init];
        [self addSubview:_createTimeLabel];
        
        _joinNumberLabel = [[UILabel alloc] init];
        [self addSubview:_joinNumberLabel];
        
        _contentLabel = [[UILabel alloc] init];
        [self addSubview:_contentLabel];
    }
    return self;
}

-(void)layoutSubviews{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    //设置cell阴影
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.layer.shadowOpacity = 0.8f;
    self.layer.shadowOffset = CGSizeMake(-2, 3);
    self.layer.shadowRadius = 4.0f;
    self.layer.masksToBounds = NO;
    
    _leftImageView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self).multipliedBy(0.9f);
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(self.frame.size.width*0.015);
        make.width.equalTo(self).multipliedBy(0.23f);
    }];
    
    
    [_bookName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImageView.mas_right).offset(self.frame.size.height*0.05);
        make.width.equalTo(self).multipliedBy(0.5f);
        make.top.equalTo(_leftImageView);
        make.height.equalTo(self).multipliedBy(0.18f);
    }];
    [_bookName setFont:[UIFont systemFontOfSize:15]];
    
    [_authorName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bookName);
        make.right.equalTo(self).offset(self.frame.size.height*0.05*-1);
        make.top.equalTo(_bookName.mas_bottom).offset(5);
        make.height.equalTo(self).multipliedBy(0.15f);
    }];
    [_authorName setFont:[UIFont systemFontOfSize:12]];
    [_authorName setTextColor:[UIColor grayColor]];

    [_joinNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(_authorName);
        make.right.equalTo(self).offset(-10);
        make.width.equalTo(self).multipliedBy(0.15);
    }];
    [_joinNumberLabel setFont:[UIFont systemFontOfSize:12]];
    [_joinNumberLabel setTextColor:[UIColor grayColor]];
    _joinNumberLabel.textAlignment = NSTextAlignmentRight;
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bookName);
        make.right.equalTo(self).offset(-5);
        make.top.equalTo(_authorName.mas_bottom).offset(5);
        make.height.equalTo(self).multipliedBy(0.3f);
    }];
    _contentLabel.numberOfLines = 0;
    [_contentLabel setFont:[UIFont systemFontOfSize:12]];
    [_contentLabel setTextColor:[UIColor grayColor]];
    
    
    [_createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contentLabel);
        make.width.equalTo(self).multipliedBy(0.5);
        make.bottom.equalTo(self).offset(-5);
        make.top.equalTo(_contentLabel.mas_bottom);
    }];
    [_createTimeLabel setFont:[UIFont systemFontOfSize:12]];
    [_createTimeLabel setTextColor:[UIColor grayColor]];
    _createTimeLabel.textAlignment = NSTextAlignmentLeft;
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 5;
    frame.origin.y += 20;
    frame.size.height -= 20;
    frame.size.width -= 15;
    [super setFrame:frame];
}

-(void)updateCellModel:(NOVbookMessage *)model{
    [_bookName setText:model.bookName];//书名
    [_authorName setText:model.author.username];
    [_createTimeLabel setText:[model.createTime substringToIndex:10]];
    [_joinNumberLabel setText:[NSString stringWithFormat:@"%ld人参与",(long)model.branchNum]];//参与人数
    [_contentLabel setText:model.content];//简介
    NSLog(@"%@",model.bookImage);
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BookImageUrl,model.bookImage]] placeholderImage:[UIImage imageNamed:@""]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
