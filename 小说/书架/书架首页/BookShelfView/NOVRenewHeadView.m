//
//  NOVRenewHeadView.m
//  小说
//
//  Created by 李飞艳 on 2018/8/17.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVRenewHeadView.h"
#import "NOVGetMyRenewModel.h"
#import <UIImageView+WebCache.h>
@implementation NOVRenewHeadView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        _bookImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_bookImage];
        
        _goNovelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_goNovelButton];
        
        _bookNameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_bookNameLabel];
        
        _authorLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_authorLabel];
        
        _joinNumLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_joinNumLabel];
        
        _bookCreateTime = [[UILabel alloc] init];
        [self.contentView addSubview:_bookCreateTime];
        
        _myRenewLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_myRenewLabel];
    }
    return self;
}

-(void)layoutSubviews{
    CGFloat width = self.frame.size.width;
    [_bookImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.height.mas_equalTo(width*0.17);
        make.left.equalTo(self).offset(10);
        make.width.equalTo(self).multipliedBy(0.13);
    }];
    
    [_bookNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bookImage);
        make.height.mas_equalTo(width*0.05);
        make.left.equalTo(_bookImage.mas_right).offset(10);
        make.width.equalTo(self).multipliedBy(0.7);
    }];
    [self setLabelWithLabel:_bookNameLabel fontSize:13 color:[UIColor blackColor]];
    
    [_goNovelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.height.equalTo(_bookNameLabel);
        make.right.equalTo(self).offset(-10);
        make.width.equalTo(self).multipliedBy(0.15);
    }];
    [_goNovelButton setTitle:@"前往作品" forState:UIControlStateNormal];
    [_goNovelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _goNovelButton.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [_authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bookNameLabel.mas_bottom).offset(5);
        make.height.equalTo(_bookNameLabel);
        make.left.equalTo(_bookNameLabel);
        make.width.equalTo(self).multipliedBy(0.6);
    }];
    [self setLabelWithLabel:_authorLabel fontSize:12 color:[UIColor grayColor]];
    
    [_joinNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.height.equalTo(_authorLabel);
        make.right.equalTo(self).offset(-10);
        make.width.equalTo(self).multipliedBy(0.3);
    }];
    [self setLabelWithLabel:_joinNumLabel fontSize:12 color:[UIColor grayColor]];
    _joinNumLabel.textAlignment = NSTextAlignmentRight;
    
    [_bookCreateTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_joinNumLabel.mas_bottom).offset(5);
        make.bottom.equalTo(_bookImage);
        make.right.equalTo(self).offset(-10);
        make.width.equalTo(self).multipliedBy(0.3);
    }];
    [self setLabelWithLabel:_bookCreateTime fontSize:12 color:[UIColor grayColor]];
    _bookCreateTime.textAlignment = NSTextAlignmentRight;
    
    [_myRenewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bookImage.mas_bottom).offset(5);
        make.height.equalTo(_bookNameLabel);
        make.left.equalTo(_bookImage);
        make.width.equalTo(self).multipliedBy(0.3);
    }];
    _myRenewLabel.text = @"我的续写";
    [self setLabelWithLabel:_myRenewLabel fontSize:13 color:[UIColor blackColor]];
}

-(void)setLabelWithLabel:(UILabel *)label fontSize:(NSInteger)fontSize color:(UIColor *)color{
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = color;
}

-(void)updateCellModel:(NOVSimpleBookModel *)model{
    [_bookImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BookImageUrl,model.bookImage]]];
    _bookNameLabel.text = model.bookName;
    _authorLabel.text = model.author.username;
    _joinNumLabel.text = [NSString stringWithFormat:@"%ld人参与",(long)model.joinUsers];
    _bookCreateTime.text = [model.createTime substringToIndex:10];
}

-(void)drawRect:(CGRect)rect{
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = SystemCGColor;
    border.fillColor = [UIColor clearColor].CGColor;
    border.path = [UIBezierPath bezierPathWithRect:self.goNovelButton.bounds].CGPath;
    border.frame = self.goNovelButton.bounds;
    border.lineWidth = 1.f;
    [self.goNovelButton.layer addSublayer:border];
    
    CAShapeLayer *border1 = [CAShapeLayer layer];
    border1.strokeColor = [UIColor lightGrayColor].CGColor;
    border1.fillColor = [UIColor clearColor].CGColor;
    border1.path = [UIBezierPath bezierPathWithRect:self.bookImage.bounds].CGPath;
    border1.frame = self.bookImage.bounds;
    border1.lineWidth = 0.8;
    [self.bookImage.layer addSublayer:border1];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
