//
//  GTListItem.m
//  SampleApp
//
//  Created by penghuizhang on 2020/2/20.
//  Copyright © 2020 penghuizhang. All rights reserved.
//

#import "GTListItem.h"

@implementation GTListItem
#pragma mark - NSSecureCoding
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.category = [aDecoder decodeObjectForKey:@"category"];
        self.picUrl = [aDecoder decodeObjectForKey:@"picUrl"];
        self.uniqueKey = [aDecoder decodeObjectForKey:@"uniqueKey"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.date = [aDecoder decodeObjectForKey:@"date"];
        self.authorName = [aDecoder decodeObjectForKey:@"authorName"];
        self.articleUrl = [aDecoder decodeObjectForKey:@"articleUrl"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.category forKey:@"category"];
    [aCoder encodeObject:self.picUrl forKey:@"picUrl"];
    [aCoder encodeObject:self.uniqueKey forKey:@"uniqueKey"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.authorName forKey:@"authorName"];
    [aCoder encodeObject:self.articleUrl forKey:@"articleUrl"];
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (id)copyWithZone:(nullable NSZone *)zone{
    return self;
}

#pragma mark - public method
- (void)configWithDictionary:(NSDictionary *)dictionary {
#warning 类型是否匹配
    self.category = [dictionary objectForKey:@"category"];
    self.picUrl = [dictionary objectForKey:@"thumbnail_pic_s"];
    self.uniqueKey = [dictionary objectForKey:@"uniquekey"];
    self.title = [dictionary objectForKey:@"title"];
    self.date = [dictionary objectForKey:@"date"];
    self.authorName = [dictionary objectForKey:@"author_name"];
    self.articleUrl = [dictionary objectForKey:@"url"];
}

@end
