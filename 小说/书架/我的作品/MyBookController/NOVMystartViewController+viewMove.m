//
//  NOVMystartViewController+viewMove.m
//  小说
//
//  Created by 李飞艳 on 2018/9/19.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVMystartViewController+viewMove.h"
#import "NOVAllMyStartView.h"
#import "NOVMystartView.h"
#import "NOVView.h"

@implementation NOVMystartViewController (viewMove)


-(void)touchRespone:(UIButton *)touchButton{
    self.touchTopButton = YES;
    [self.allMyStartView.scrollView setContentOffset:CGPointMake(ScreenWidth*touchButton.tag + 1, 0) animated:YES];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.touchTopButton = NO;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //如果是点击button导致的scrollView移动则不触发该方法
    if (self.touchTopButton) {
        return;
    }
    CGPoint point = scrollView.contentOffset;
    if ([scrollView isEqual:self.allMyStartView.scrollView]) {
        NSLog(@"%f",point.x);
        
        [self.allMyStartView.headView setButtonPostion:point width:ScreenWidth];
    }
}

@end
