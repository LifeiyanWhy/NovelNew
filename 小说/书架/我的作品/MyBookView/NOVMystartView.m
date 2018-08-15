//
//  NOVMystartView.m
//  小说
//
//  Created by 李飞艳 on 2018/5/22.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVMystartView.h"
#import "NOVBookSetView.h"
#import "NOVStartBookModel.h"
#import "NOVSetbackView.h"

@implementation NOVMystartView{
    CGFloat scrollviewHeight;
}

-(instancetype)initWithFrame:(CGRect)frame withViewNumber:(NSInteger)viewNumber{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, frame.size.width, frame.size.height - 64)];
        [self addSubview:_scrollView];
        _viewNumber = viewNumber;
    }
    return self;
}

-(void)layoutSubviews{
    _scrollView.contentSize = CGSizeMake(self.frame.size.width*_viewNumber, self.frame.size.height - 64);
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    scrollviewHeight = self.frame.size.height - 64;
    _scrollView.pagingEnabled = YES;
    
    for (int i = 0; i < _viewNumber; i++) {
        NOVBookSetView *bookSetView;
        if ([_delegate respondsToSelector:@selector(viewForPape:WithWidth:Height:)]) {
            bookSetView = [self.delegate viewForPape:i WithWidth:self.frame.size.width Height:scrollviewHeight];
        }else{
            bookSetView = [[NOVBookSetView alloc] initWithFrame:CGRectMake(self.frame.size.width*(0.15+i), scrollviewHeight*0.07, self.frame.size.width*0.7, scrollviewHeight*0.83)];
        }
        bookSetView.tag = i + 1;
        bookSetView.detailButton.tag = i + 1;
        [bookSetView.editButton setTitle:@"已发布(不可编辑)" forState:UIControlStateNormal];
        bookSetView.editButton.userInteractionEnabled = NO;
        [_scrollView addSubview:bookSetView];
    }
}

-(void)addViewWithModel:(NOVStartBookModel *)model{
    _viewNumber++;
    _scrollView.contentSize = CGSizeMake(self.frame.size.width*_viewNumber, scrollviewHeight);
    NOVBookSetView *setview = [[NOVBookSetView alloc] initWithFrame:CGRectMake(self.frame.size.width*(_viewNumber - 1 + 0.15), scrollviewHeight*0.07, self.frame.size.width*0.7, scrollviewHeight*0.83)];
    //标记作品
    setview.tag = _viewNumber;
    setview.detailButton.tag = _viewNumber;
    [setview.editButton setTitle:@"编辑作品(未发布)" forState:UIControlStateNormal];
    [setview.editButton addTarget:self action:@selector(touchEditButton:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:setview];
    [_scrollView setContentOffset:CGPointMake(self.frame.size.width*(_viewNumber - 1), 0) animated:NO];
    [setview setBookWithModel:model];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.frame.size.height*0.07;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 0;
    }
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

-(void)touchEditButton:(UIButton *)button{
    //参数为所点击的setView(即小说)
    if ([_delegate respondsToSelector:@selector(touchEditButtonInSetView:)]) {
        [self.delegate touchEditButtonInSetView:(NOVBookSetView *)[[button superview] superview]];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
