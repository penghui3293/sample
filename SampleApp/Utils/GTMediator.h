//
//  GTMediator.h
//  SampleApp
//
//  Created by penghuizhang on 2020/2/29.
//  Copyright © 2020 penghuizhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GTListItem;

@protocol GTDetailViewControllerProtocol <NSObject>

- ( __kindof UIViewController *) detailViewControllerWithItem:(GTListItem *) item;

@end

@interface GTMediator : NSObject

//target action
+ ( __kindof UIViewController *) detailViewControllerWithItem:(GTListItem *) item;

//url scheme
typedef void(^GTMediatorProcessBlock)(NSDictionary *params);
+ (void) registerScheme:(NSString *)scheme processBlock:(GTMediatorProcessBlock)processBlock ;
+ (void) openUrl:(NSString *) url params:(NSDictionary *) params;

//protocol class
+ (void) registerProtocol:(Protocol *) proto class:(Class) cls;
+ (Class)classForProtocol:(Protocol *) proto;

@end

NS_ASSUME_NONNULL_END
