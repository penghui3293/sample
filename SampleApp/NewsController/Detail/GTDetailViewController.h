//
//  GTDetailViewController.h
//  SampleApp
//
//  Created by penghuizhang on 2020/3/20.
//  Copyright © 2020 penghuizhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTMediator.h"

NS_ASSUME_NONNULL_BEGIN

/// 文章底层页
@interface GTDetailViewController : UIViewController<GTDetailViewControllerProtocol>

- (instancetype)initWithItem:(GTListItem *) item;

@end

NS_ASSUME_NONNULL_END
