//
//  NOVMystartViewController+viewMove.h
//  小说
//
//  Created by 李飞艳 on 2018/9/19.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVMystartViewController.h"
@class NOVGetMyStartModel;
@class NOVStartBookModel;
@class NOVBookSetView;
@interface NOVMystartViewController (viewMove)
-(void)readBookWithModel:(NOVGetMyStartModel *)myStartModel;
-(void)editBookWithView:(NOVBookSetView *)setView getModel:(NOVGetMyStartModel *_Nullable)draftBookModel model:(NOVStartBookModel *_Nullable)startBookModel;
@end
