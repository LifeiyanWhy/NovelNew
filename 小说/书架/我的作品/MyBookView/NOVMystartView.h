//
//  NOVMystartView.h
//  小说
//
//  Created by 李飞艳 on 2018/5/22.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NOVBookSetView;
@class NOVStartBookModel;
@class NOVGetMyStartModel;
@class NOVMystartView;

@protocol NOVMystartViewDategate <NSObject>
@required
-(NOVBookSetView *)mystartView:(NOVMystartView *)myStartView viewForPape:(NSInteger)page WithWidth:(CGFloat)width Height:(CGFloat)height;
@optional
//点击编辑button时执行
-(void)touchEditButtonInSetView:(NOVBookSetView *)setView;
-(void)changeBookImageWithView:(UIImageView *)imageView;
@end

@interface NOVMystartView : UIView<UITableViewDelegate>
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,readonly,assign) NSInteger viewNumber;
@property(nonatomic,weak) id <NOVMystartViewDategate>delegate;
-(instancetype)initWithFrame:(CGRect)frame;
-(void)setSubViewsWithViewNumber:(NSInteger)viewNumber isPublish:(BOOL)isPublish;
-(void)addViewWithModel:(NOVStartBookModel *)model;
@end
