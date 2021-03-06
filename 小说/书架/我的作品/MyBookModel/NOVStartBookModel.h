//
//  NOVMystartModel.h
//  小说
//
//  Created by 李飞艳 on 2018/5/23.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIImage+AFNetworking.h>
@class NOVGetMyStartModel;

typedef void(^succeedBlock)(id responseObject);
typedef void(^failureBlock)(NSError *error);

//发起类型
typedef NS_OPTIONS(NSInteger, NOVStartType){
    //续写
    NOVStartTypeStartRenew = 0,
    //根据背景扩展
    NOVStartTypeBackgroundExtension,
};

//作品权限
typedef NS_OPTIONS(NSInteger, NOVJurisdiction){
    //公开
    NOVJurisdictionPublic = 0,
    //粉丝可见
    NOVJurisdictionFans,
    //好友可见
    NOVJurisdictionFriend,
};

//作品类型
typedef NS_OPTIONS(NSInteger, NOVType) {
    NOVBookTypeFantasySentiment = 0,
    NOVBookTypeImmortalChivalry,
    NOVBookTypeAncientSentiment,
    NOVBookTypeModernSentiment,
    NOVBookTypeRomanticYouth,
    NOVBookTypeSuspensePsychic,
    NOVBookTypeScienceSpace,
    NOVBookTypeGameCompetition,
    NOVBookTypeTanbiNovel,
};

@interface NOVStartBookModel : NSObject
@property(nonatomic,assign) NSInteger bookId;
@property(nonatomic,strong) NSString *name;//作品名称
@property(nonatomic,assign) NOVType bookType;//作品类型
@property(nonatomic,strong) NSString *introduction;//作品简介
@property(nonatomic,strong) UIImage *bookImage;//图片
@property(nonatomic,strong) NSString *firstTitle;//第一段的标题
@property(nonatomic,copy) NSString *firstContent;//第一段内容
@property(nonatomic,copy) NSString *firstSummary;//第一段的摘要
@property(nonatomic,assign) NOVStartType startType;//发起形式
@property(nonatomic,assign) NOVJurisdiction renewPeople;//续写人员
@property(nonatomic,assign) NOVJurisdiction viewerType;//可观看人群
//@property(nonatomic,assign) BOOL isSave;//是否有保存记录
-(instancetype)initWithDraft:(NOVGetMyStartModel *)draftBookModel;
-(void)obtainDraftContentWithBookId:(NSInteger)bookId succeed:(succeedBlock _Nullable)success  fail:(failureBlock _Nullable)fail;
@end
