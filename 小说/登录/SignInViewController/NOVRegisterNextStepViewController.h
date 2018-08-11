//
//  NOVSignUpViewController.h
//  小说
//
//  Created by 李飞艳 on 2018/8/10.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NOVRegisterNextStepView;
@interface NOVRegisterNextStepViewController : UIViewController
@property(nonatomic,strong) NOVRegisterNextStepView *registerNextView;
@property(nonatomic,copy) NSString *account;
@property(nonatomic,copy) NSString *verityCode;
@end
