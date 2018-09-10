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
@protocol NOVMystartViewDategate <NSObject>
@required
-(NOVBookSetView *)viewForPape:(NSInteger)page WithWidth:(CGFloat)width Height:(CGFloat)height;
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
-(instancetype)initWithFrame:(CGRect)frame withViewNumber:(NSInteger)viewNumber;
-(void)addViewWithModel:(NOVStartBookModel *)model;
@end
