//
//  ViewController+keyboardChange.h
//  小说
//
//  Created by 李飞艳 on 2018/9/11.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (keyboardChange)
- (void)keyboardShow:(NSNotification *)notification;
- (void)keyboardHidden:(NSNotification *)notification;
@end
