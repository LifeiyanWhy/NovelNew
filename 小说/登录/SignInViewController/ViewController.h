//
//  ViewController.h
//  小说
//
//  Created by 李飞艳 on 2018/3/29.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NOVSigninView;
@interface ViewController : UIViewController
@property(nonatomic,strong) NOVSigninView *signView;
@property(nonatomic,copy) NSString *account;
@property(nonatomic,copy) NSString *passward;
@end

