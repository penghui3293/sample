//
//  GTLocation.h
//  SampleApp
//
//  Created by penghuizhang on 2020/3/5.
//  Copyright © 2020 penghuizhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//App统一定位管理
@interface GTLocation : NSObject
+ (GTLocation *) locationManager;
- (void) checkLocationAuthorization;
@end

NS_ASSUME_NONNULL_END
