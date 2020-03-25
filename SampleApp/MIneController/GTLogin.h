//
//  GTLogin.h
//  SampleApp
//
//  Created by penghuizhang on 2020/3/1.
//  Copyright © 2020 penghuizhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class  GTListItem;

typedef void(^GTLoginFinishBlock)(BOOL isLogin);

/// QQ登录和分享相关逻辑
@interface GTLogin : NSObject

@property(nonatomic, strong, readonly)NSString *nick;
@property(nonatomic, strong, readonly)NSString *address;
@property(nonatomic, strong, readonly)NSString *avatarUrl;

+ (instancetype)sharedLogin;

#pragma - mark - 登录

- (BOOL)isLogin;
- (void)loginWithFinishBlock:(GTLoginFinishBlock)finishBlock;
- (void)logOut;

#pragma mark - 分享
- (void)shareToQQWithListItem:(GTListItem *)item;

@end

NS_ASSUME_NONNULL_END
