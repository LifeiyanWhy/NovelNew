//
//  NOVRenewModel.h
//  小说
//
//  Created by 李飞艳 on 2018/8/8.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NOVRenewModel : NSObject
@property(nonatomic,assign) NSInteger parentId;
@property(nonatomic,assign) NSInteger bookId;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *content;
@property(nonatomic,copy) NSString *summary;//摘要
@end
