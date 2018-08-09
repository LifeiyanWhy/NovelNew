//
//  NOVNetworkAnomalyView.h
//  小说
//
//  Created by 李飞艳 on 2018/7/21.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NOVNetworkAnomalyViewDelegate <NSObject>

@optional
-(void)touchAnomalyImage;

@end

@interface NOVNetworkAnomalyView : UIView
@property(nonatomic,strong) id <NOVNetworkAnomalyViewDelegate>delegate;
@end
