//
//  NOVMyCollecitonTableViewCell.m
//  小说
//
//  Created by 李飞艳 on 2018/8/19.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVMyCollecitonTableViewCell.h"
#import <UIButton+WebCache.h>
#import "NOVMyCollectionModel.h"

@implementation NOVMyCollecitonTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _authorImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_authorImageButton];
        
        _authorLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_authorLabel];
        
        _titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
        
        _summaryLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_summaryLabel];
        
        _likeNumButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_likeNumButton];;
        
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_commentButton];
        
        _createTimeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_createTimeLabel];
        
    }
    return self;
}

-(void)layoutSubviews{
    CGFloat width = self.frame.size.width;
    
    [_authorImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(10);
        make.height.and.width.mas_equalTo(width*0.1);
    }];
    _authorImageButton.backgroundColor = [UIColor redColor];
    
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:_authorImageButton.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(width*0.1, width*0.1)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _authorImageButton.bounds;
    maskLayer.path = maskPath.CGPath;   // 轨迹
    _authorImageButton.layer.mask = maskLayer;
    
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_authorImageButton.mas_right).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(_authorImageButton).multipliedBy(0.5);
        make.top.equalTo(_authorImageButton);
    }];
    [self setLabelWithLabel:_titleLabel textSize:13];
    
    [_authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_authorImageButton.mas_right).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(_authorImageButton).multipliedBy(0.5);
        make.bottom.equalTo(_authorImageButton);
    }];
    [self setLabelWithLabel:_authorLabel textSize:11];
    
    [_summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_authorLabel.mas_bottom).offset(5);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
    }];
    [self setLabelWithLabel:_summaryLabel textSize:13];
    _summaryLabel.numberOfLines = 0;
    
    [_likeNumButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_summaryLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(25);
        make.left.equalTo(self).offset(10);
        make.width.mas_equalTo(60);
    }];
    [self setButtonWithButton:_likeNumButton withImageName:@"点赞renewList.png"];
    [_likeNumButton setImage:[UIImage imageNamed:@"点赞renewList1.png"] forState:UIControlStateSelected];
    
    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_likeNumButton.mas_right).offset(20);
        make.width.and.top.height.equalTo(_likeNumButton);
    }];
    [self setButtonWithButton:_commentButton withImageName:@"评论renewList.png"];
    [_commentButton setTitle:@"评论" forState:UIControlStateNormal];
    
    [_createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.width.equalTo(self).multipliedBy(0.3f);
        make.top.and.height.equalTo(_likeNumButton);
    }];
    [self setLabelWithLabel:_createTimeLabel textSize:13];
}

-(void)setLabelWithLabel:(UILabel *)label textSize:(CGFloat)textSize{
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:textSize];
    if ([label isEqual:_createTimeLabel]) {
        label.textAlignment = NSTextAlignmentRight;
    }else{
        label.textAlignment = NSTextAlignmentLeft;
    }
}

-(void)setButtonWithButton:(UIButton *)button withImageName:(NSString *)imageName{
    [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    CGFloat labelWidth = button.titleLabel.intrinsicContentSize.width;
    CGFloat imageWidth = button.imageView.intrinsicContentSize.width;
    CGFloat buttonWidth = 60;
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -(buttonWidth-labelWidth-imageWidth)/2.0, 0,(buttonWidth-labelWidth-imageWidth)/2.0);
}


-(void)updateCellWithModel:(NOVMyCollectionModel *)model{
//    NSLog(@"%@",model.author.icon);
    [_authorImageButton sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",UserImageUrl,model.author.icon]] forState:UIControlStateNormal];
    _titleLabel.text = model.title;
    _authorLabel.text = model.author.username;
    _summaryLabel.text = model.summary;
    [_likeNumButton setTitle:[NSString stringWithFormat:@"%ld",(long)model.likeNum]forState:UIControlStateNormal];
    _createTimeLabel.text = [model.createTime substringToIndex:10];
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
