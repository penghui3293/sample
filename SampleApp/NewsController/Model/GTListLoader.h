//
//  GTListLoader.h
//  SampleApp
//
//  Created by penghuizhang on 2020/2/19.
//  Copyright © 2020 penghuizhang. All rights reserved.
//

#import <Foundation/Foundation.h>



@class GTListItem;

NS_ASSUME_NONNULL_BEGIN

typedef void(^GTListLoaderFinishBlock)(Boolean success,NSArray< GTListItem *>  *dataArray);

/// 列表请求
@interface GTListLoader : NSObject

- (void)loadListDataWithFinishBlock:(GTListLoaderFinishBlock) finishBlock type:(NSString *) type;

@end

NS_ASSUME_NONNULL_END
