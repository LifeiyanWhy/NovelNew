//
//  NOVNextChapterTableViewCell.m
//  小说
//
//  Created by 李飞艳 on 2018/8/10.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVNextChapterTableViewCell.h"
#import "NOVChapterListModel.h"
@implementation NOVNextChapterTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.25];
        _authorImageButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.contentView addSubview:_authorImageButton];
        
        _titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
        
        _authorLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_authorLabel];
 
        _summaryLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_summaryLabel];
        
        _likeNumButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_likeNumButton];
        
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_commentButton];
        
        _createTimeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_createTimeLabel];
    }
    return self;
}

-(void)layoutSubviews{
    CGFloat width = self.frame.size.width;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    [_authorImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(10);
        make.height.and.width.mas_equalTo(width*0.1);
    }];
    
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
        make.height.mas_equalTo(20);
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
//    button.titleEdgeInsets = UIEdgeInsetsMake(0, -(buttonWidth-labelWidth-imageWidth)/2.0, 0, (buttonWidth-labelWidth-imageWidth)/2.0);
}

-(void)updateCellModelWithChapterListModel:(NOVChapterListModel *)chapterListModel{
    [self.authorImageButton setImage:[[UIImage imageNamed:@"cellimage.jpg"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    self.titleLabel.text = chapterListModel.title;
    self.authorLabel.text = chapterListModel.author.username;
    self.summaryLabel.text = chapterListModel.summary;
    [self.likeNumButton setTitle:[NSString stringWithFormat:@"%ld",(long)chapterListModel.likeNum] forState:UIControlStateNormal];
    [self.commentButton setTitle:@"评论" forState:UIControlStateNormal];
    self.createTimeLabel.text = [chapterListModel.createTime substringToIndex:10];
    
}

-(void)drawRect:(CGRect)rect{
//    UIColor *color = [UIColor lightGrayColor];
//    [color set];
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    path.lineWidth = 1.5;
//    [path moveToPoint:CGPointMake(0, self.frame.size.height)];
//    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
//    [path stroke];
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
