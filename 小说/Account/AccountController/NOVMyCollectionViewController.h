//
//  NOVMyCollectionViewController.h
//  小说
//
//  Created by 李飞艳 on 2018/9/3.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, NOVShowChapterType) {
    NOVShowChapterTypeCollection = 1,
    NOVShowChapterTypeLike
};

@interface NOVMyCollectionViewController : UIViewController
@property(nonatomic,assign) NOVShowChapterType showChapterType;
@end
