//
//  GTLogin.m
//  SampleApp
//
//  Created by penghuizhang on 2020/3/1.
//  Copyright © 2020 penghuizhang. All rights reserved.
//

#import "GTLogin.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "GTListItem.h"

@interface GTLogin ()<TencentSessionDelegate>

@property (nonatomic, strong, readwrite) TencentOAuth *oauth;
@property (nonatomic, copy, readwrite) GTLoginFinishBlock finishBlock;
@property (nonatomic, assign, readwrite) BOOL isLogin;

@end

@implementation GTLogin

+ (instancetype)sharedLogin {
    static GTLogin *login;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        login = [[GTLogin alloc] init];
    });
    return login;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _isLogin = NO;
        _oauth = [[TencentOAuth alloc] initWithAppId:@"222222" andDelegate:(self)];
    }
    return self;
}

- (BOOL)isLogin {
    //登陆态失效的逻辑
    return _isLogin;
}

- (void)loginWithFinishBlock:(GTLoginFinishBlock)finishBlock {
    _finishBlock = [finishBlock copy];

    _oauth.authMode = kAuthModeClientSideToken;
    [ _oauth authorize:@[ kOPEN_PERMISSION_GET_USER_INFO,
                          kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                          kOPEN_PERMISSION_ADD_ALBUM,
                          kOPEN_PERMISSION_ADD_TOPIC,
                          kOPEN_PERMISSION_CHECK_PAGE_FANS,
                          kOPEN_PERMISSION_GET_INFO,
                          kOPEN_PERMISSION_GET_OTHER_INFO,
                          kOPEN_PERMISSION_LIST_ALBUM,
                          kOPEN_PERMISSION_UPLOAD_PIC,
                          kOPEN_PERMISSION_GET_VIP_INFO,
                          kOPEN_PERMISSION_GET_VIP_RICH_INFO]];
}

- (void)logOut {
    [_oauth logout:self];
    _isLogin = NO;
}

#pragma mark - delegate

/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin {
    _isLogin = YES;
//保存openid
    [_oauth getUserInfo];
}

/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled {
    if (_finishBlock) {
        _finishBlock(NO);
    }
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork {
}

//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    return [TencentOAuth HandleOpenURL:url];
//}
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation {
//    return [TencentOAuth HandleOpenURL:url];
//}

- (void)tencentDidLogout {
    //退出登录，需要清理下存储在本地的登录数据
}

- (void)getUserInfoResponse:(APIResponse *)response {
    NSDictionary *userInfo = response.jsonResponse;

    _nick =  userInfo[@"nickname"];
    _address =  userInfo[@"city"];
    _avatarUrl =  userInfo[@"figureurl_qq_2"];
    if (_finishBlock) {
        _finishBlock(YES);
    }
}

#pragma mark -

- (void)shareToQQWithListItem:(GTListItem *)item {
    //登陆校验
    //loginWithFinishBlock

    NSString *utf8String = item.articleUrl;
    NSString *title =  item.title;
    NSString *description = item.authorName;
    NSString *previewImageUrl = item.picUrl;

    QQApiNewsObject *newsObj = [QQApiNewsObject
                                objectWithURL:[NSURL URLWithString:utf8String]
                                         title:title
                                   description:description
                               previewImageURL:[NSURL URLWithString:previewImageUrl]];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    //将内容分享到qq
    //QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    //将内容分享到qzone
    QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
//    QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:articleUrl title:@"iOS" description:@"从0开始iOS开发" previewImageURL:nil];
//    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
//    __unused QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
}

@end
