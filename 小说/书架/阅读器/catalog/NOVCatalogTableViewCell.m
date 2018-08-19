//
//  NOVCatalogTableViewCell.m
//  小说
//
//  Created by 李飞艳 on 2018/8/18.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVCatalogTableViewCell.h"
#import "NOVRecordModel.h"
@implementation NOVCatalogTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
        
        _authorLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_authorLabel];
        
        _timeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_timeLabel];
    }
    return self;
}

-(void)layoutSubviews{
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.height.equalTo(self).multipliedBy(0.4);
        make.left.equalTo(self).offset(10);
        make.width.equalTo(self).multipliedBy(0.8);
    }];
    [self setLabel:_titleLabel withFontSize:15];
    
    [_authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom);
        make.height.equalTo(self).multipliedBy(0.4);
        make.left.equalTo(_titleLabel);
        make.width.equalTo(self).multipliedBy(0.4);
    }];
    [self setLabel:_authorLabel withFontSize:12];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.width.equalTo(self).multipliedBy(0.4);
        make.top.and.bottom.equalTo(_authorLabel);
    }];
    [self setLabel:_timeLabel withFontSize:13];
    _timeLabel.textAlignment = NSTextAlignmentRight;
}

-(void)setLabel:(UILabel *)label withFontSize:(NSInteger)fontSize{
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:fontSize];
}

-(void)updateCellWithModel:(NOVChapterReadModel *)model{
    _titleLabel.text = model.chapterTitle;
    _timeLabel.text = [model.createTime substringToIndex:10];
    _authorLabel.text = model.authorName;
}

-(void)drawRect:(CGRect)rect{
    UIColor *color = [UIColor colorWithRed:0.74 green:0.74 blue:0.74 alpha:1.00];
    [color set];
    UIBezierPath *bezierpath = [UIBezierPath bezierPath];
    bezierpath.lineWidth = 1.5;
    bezierpath.lineCapStyle = kCGLineCapButt;
    [bezierpath moveToPoint:CGPointMake(0, self.frame.size.height)];
    [bezierpath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
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
