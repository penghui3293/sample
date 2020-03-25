//
//  GTListItem.h
//  SampleApp
//
//  Created by penghuizhang on 2020/2/20.
//  Copyright © 2020 penghuizhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGListKit.h"

NS_ASSUME_NONNULL_BEGIN
/// 列表结构化数据
@interface GTListItem : NSObject<NSSecureCoding,NSCopying,IGListDiffable>

@property(nonatomic,copy,readwrite)NSString *category;
@property(nonatomic,copy,readwrite)NSString *picUrl;
@property(nonatomic,copy,readwrite)NSString *uniqueKey;
@property(nonatomic,copy,readwrite)NSString *title;
@property(nonatomic,copy,readwrite)NSString *date;
@property(nonatomic,copy,readwrite)NSString *authorName;
@property(nonatomic,copy,readwrite)NSString *articleUrl;

- (void) configWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
