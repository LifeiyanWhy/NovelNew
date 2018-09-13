//
//  UIFont+fontAdjust.m
//  小说
//
//  Created by 李飞艳 on 2018/9/13.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "UIFont+fontAdjust.h"
#import <objc/runtime.h>

@implementation UIFont (fontAdjust)
+ (void)load {
    // 获取替换后的类方法
    Method newMethod = class_getClassMethod([self class], @selector(adjustFont:));
    // 获取替换前的类方法
    Method method = class_getClassMethod([self class], @selector(systemFontOfSize:));
    // 然后交换类方法，交换两个方法的IMP指针，(IMP代表了方法的具体的实现）
    method_exchangeImplementations(newMethod, method);
}

+ (UIFont *)adjustFont:(CGFloat)fontSize {
    UIFont *newFont = nil;
    if (ScreenWidth == 320) {
        fontSize -= 2;
    }else if (ScreenWidth > 375){
        fontSize += 2;
    }
    newFont = [UIFont adjustFont:fontSize];
    return newFont;
}
@end
