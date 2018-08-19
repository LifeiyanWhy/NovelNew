//
//  NOVMyRenewTableViewCell.m
//  小说
//
//  Created by 李飞艳 on 2018/8/16.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVMyRenewTableViewCell.h"
#import "NOVGetMyRenewModel.h"
#import <UIImageView+WebCache.h>

@implementation NOVMyRenewTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        _myRenewTitle = [[UILabel alloc] init];
        [self.contentView addSubview:_myRenewTitle];
        
        _summaryLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_summaryLabel];
        
        _likeNum = [[UILabel alloc] init];
        [self.contentView addSubview:_likeNum];
        
        _createTimeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_createTimeLabel];
    }
    return self;
}

-(void)layoutSubviews{
    CGFloat width = self.frame.size.width;
    [_myRenewTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.height.mas_equalTo(width*0.05);
        make.left.equalTo(self).offset(10);
        make.width.equalTo(self).multipliedBy(0.6);
    }];
    [self setLabelWithLabel:_myRenewTitle fontSize:13 color:[UIColor blackColor]];
    
    [_summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_myRenewTitle.mas_bottom).offset(5);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
    }];
    [self setLabelWithLabel:_summaryLabel fontSize:12 color:[UIColor grayColor]];
    _summaryLabel.numberOfLines = 0;
    [_summaryLabel sizeToFit];
    
    [_likeNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_summaryLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(_myRenewTitle);
        make.left.equalTo(_myRenewTitle);
        make.width.equalTo(self).multipliedBy(0.4);
    }];
    [self setLabelWithLabel:_likeNum fontSize:12 color:[UIColor grayColor]];
    
    [_createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.height.equalTo(_likeNum);
        make.right.equalTo(_summaryLabel);
        make.width.equalTo(self).multipliedBy(0.3);
    }];
    _createTimeLabel.textAlignment = NSTextAlignmentRight;
    [self setLabelWithLabel:_createTimeLabel fontSize:12 color:[UIColor grayColor]];
}

-(void)setLabelWithLabel:(UILabel *)label fontSize:(NSInteger)fontSize color:(UIColor *)color{
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = color;
}

-(void)updateCellModel:(NOVMyBranchModel *)model{
    _myRenewTitle.text = [NSString stringWithFormat:@"%@",model.title];
    _summaryLabel.text = model.summary;
    _likeNum.text = [NSString stringWithFormat:@"%ld人喜欢",(long)model.likeNum];
    _createTimeLabel.text = [model.createTime substringToIndex:10];
}

-(void)drawRect:(CGRect)rect{
    UIColor *color = [UIColor colorWithRed:0.74 green:0.74 blue:0.74 alpha:1.00];
    [color set];
    UIBezierPath *bezierpath = [UIBezierPath bezierPath];
    bezierpath.lineWidth = 1.5;
    bezierpath.lineCapStyle = kCGLineCapButt;
    [bezierpath moveToPoint:CGPointMake(10, self.frame.size.height)];
    [bezierpath addLineToPoint:CGPointMake(self.frame.size.width - 10, self.frame.size.height)];
    [bezierpath stroke];
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
