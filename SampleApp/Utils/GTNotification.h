//
//  GTNotification.h
//  SampleApp
//
//  Created by penghuizhang on 2020/3/5.
//  Copyright © 2020 penghuizhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTNewsViewController.h"

@class GTListItem;
NS_ASSUME_NONNULL_BEGIN

//app统一通知管理
@interface GTNotification : NSObject

+ (GTNotification *) notificationManager;
- (void) checkNotificationAuthorization:(NSArray< GTListItem *>  *) dataArray  newsController:(GTNewsViewController *) newsController;

@end

NS_ASSUME_NONNULL_END
