//
//  NOVChapterModel.m
//  小说
//
//  Created by 李飞艳 on 2018/7/23.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVChapterModel.h"

@implementation NOVChapterAuthor

-(id)copyWithZone:(NSZone *)zone{
    NOVChapterAuthor *author = [[NOVChapterAuthor allocWithZone:zone] init];
    author.account = [self.account mutableCopy];
    author.userId = self.userId;
    author.username = [self.username mutableCopy];
    return author;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.account forKey:@"account"];
    [aCoder encodeInteger:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.username forKey:@"username"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self.account = [aDecoder decodeObjectForKey:@"account"];
    self.userId = [aDecoder decodeIntegerForKey:@"userId"];
    self.username = [aDecoder decodeObjectForKey:@"username"];
    return self;
}
@end

@implementation NOVChapterModel

-(id)copyWithZone:(NSZone *)zone
{
    NOVChapterModel *model = [[NOVChapterModel allocWithZone:zone] init];
    model.content = [self.content mutableCopy];
    model.title = [self.title mutableCopy];
    model.branchId = self.branchId;
    model.author = [self.author copy];
    return model;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:self.branchId forKey:@"branchId"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.author forKey:@"author"];
    [aCoder encodeObject:self.createTime forKey:@"createTime"];
//    [aCoder encodeObject:self.summary forKey:@"summary"];
    [aCoder encodeInteger:self.likeNum forKey:@"likeNum"];
    [aCoder encodeInteger:self.dislikeNum forKey:@"dislikeNum"];
    [aCoder encodeInteger:self.parentId forKey:@"parentId"];
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.voteStatus forKey:@"voteStatus"];
    [aCoder encodeInteger:self.layer forKey:@"layer"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self.branchId = [aDecoder decodeIntegerForKey:@"branchId"];
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.author = [aDecoder decodeObjectForKey:@"author"];
    self.createTime = [aDecoder decodeObjectForKey:@"createTime"];
//    self.summary = [aDecoder decodeObjectForKey:@"summary"];
    self.likeNum = [aDecoder decodeIntegerForKey:@"likeNum"];
    self.dislikeNum = [aDecoder decodeIntegerForKey:@"dislikeNum"];
    self.parentId = [aDecoder decodeIntegerForKey:@"parentId"];
    self.content = [aDecoder decodeObjectForKey:@"content"];
    self.voteStatus = [aDecoder decodeObjectForKey:@"voteStatus"];
    self.layer = [aDecoder decodeIntegerForKey:@"layer"];
    return self;
}

@end
