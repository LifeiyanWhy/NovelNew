//
//  NOVMyRenewTableViewCell.m
//  小说
//
//  Created by 李飞艳 on 2018/8/16.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVMyRenewTableViewCell.h"
#import "NOVGetMyRenewModel.h"

@implementation NOVMyRenewTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _goNovelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_goNovelButton];
        
        _bookNameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_bookNameLabel];
        
        _authorLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_authorLabel];
        
        _joinNumLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_joinNumLabel];
        
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
    
    [_bookNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.height.mas_equalTo(width*0.06);
        make.left.equalTo(self).offset(10);
        make.width.equalTo(self).multipliedBy(0.7);
    }];
//    _bookNameLabel.backgroundColor = [UIColor redColor];
    [self setLabelWithLabel:_bookNameLabel fontSize:13];
    
    [_goNovelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.height.equalTo(_bookNameLabel);
        make.right.equalTo(self).offset(-10);
        make.width.equalTo(self).multipliedBy(0.15);
    }];
    _goNovelButton.backgroundColor = [UIColor redColor];
    
    [_authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bookNameLabel.mas_bottom).offset(5);
        make.height.equalTo(_bookNameLabel);
        make.left.equalTo(_bookNameLabel);
        make.width.equalTo(self).multipliedBy(0.6);
    }];
//    _authorLabel.backgroundColor = [UIColor redColor];
    [self setLabelWithLabel:_authorLabel fontSize:12];
    
    [_joinNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.height.equalTo(_authorLabel);
        make.right.equalTo(self).offset(-10);
        make.width.equalTo(self).multipliedBy(0.3);
    }];
//    _joinNumLabel.backgroundColor = [UIColor redColor];
    [self setLabelWithLabel:_joinNumLabel fontSize:12];
    _joinNumLabel.textAlignment = NSTextAlignmentRight;
    
    [_myRenewTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_joinNumLabel.mas_bottom).offset(5);
        make.height.equalTo(_bookNameLabel);
        make.left.equalTo(_bookNameLabel);
        make.width.equalTo(self).multipliedBy(0.6);
    }];
//    _myRenewTitle.backgroundColor = [UIColor redColor];
    [self setLabelWithLabel:_myRenewTitle fontSize:13];
    
    [_summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_myRenewTitle.mas_bottom).offset(5);
        make.left.equalTo(_bookNameLabel);
        make.right.equalTo(self).offset(-10);
    }];
//    _summaryLabel.backgroundColor = [UIColor redColor];
    [self setLabelWithLabel:_summaryLabel fontSize:12];
    _summaryLabel.numberOfLines = 0;
    [_summaryLabel sizeToFit];
    
    [_likeNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_summaryLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(_bookNameLabel);
        make.left.equalTo(_bookNameLabel);
        make.width.equalTo(self).multipliedBy(0.4);
    }];
//    _likeNum.backgroundColor = [UIColor redColor];
    [self setLabelWithLabel:_likeNum fontSize:12];
    
    [_createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.height.equalTo(_likeNum);
        make.right.equalTo(_joinNumLabel);
        make.width.equalTo(self).multipliedBy(0.3);
    }];
//    _createTimeLabel.backgroundColor = [UIColor redColor];
    _createTimeLabel.textAlignment = NSTextAlignmentRight;
    [self setLabelWithLabel:_createTimeLabel fontSize:12];
}

-(void)setLabelWithLabel:(UILabel *)label fontSize:(NSInteger)fontSize{
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = [UIColor grayColor];
}

-(void)updateCellModel:(NOVGetMyRenewModel *)model{
    _bookNameLabel.text = model.simpleBookDTO.bookName;
    _authorLabel.text = model.simpleBookDTO.author.username;
    _joinNumLabel.text = [NSString stringWithFormat:@"%ld人参与",(long)model.simpleBookDTO.joinUsers];
    NOVMyBranchModel *myModel = model.myWriteBranchDTOS[0];
    _myRenewTitle.text = [NSString stringWithFormat:@"我的续写%@",myModel.title];
    _summaryLabel.text = myModel.summary;
    _likeNum.text = [NSString stringWithFormat:@"%ld人喜欢",(long)myModel.likeNum];
    _createTimeLabel.text = [myModel.createTime substringToIndex:10];
}

-(void)drawRect:(CGRect)rect{
    UIColor *color = [UIColor whiteColor];
    [color set];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) cornerRadius:5];
    [path fill];
    
    [self.layer setShadowPath:path.CGPath];
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.layer.shadowOpacity = 0.6;
    self.layer.shadowOffset = CGSizeMake(0, 2);
    self.layer.shadowRadius = 4.0f;
    self.layer.masksToBounds = NO;
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
