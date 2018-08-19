//
//  NOVReadNovelViewController+catalog.h
//  小说
//
//  Created by 李飞艳 on 2018/8/18.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVReadNovelViewController.h"

@interface NOVReadNovelViewController (catalog)<UITableViewDelegate,UITableViewDataSource>
-(void)updateCatalog;
@end
