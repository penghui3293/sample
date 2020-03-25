//
//  GTNotification.m
//  SampleApp
//
//  Created by penghuizhang on 2020/3/5.
//  Copyright © 2020 penghuizhang. All rights reserved.
//

#import "GTNotification.h"
#import <UserNotifications/UserNotifications.h>
#import "GTListItem.h"
#import "GTMediator.h"

@interface GTNotification()<UNUserNotificationCenterDelegate>

@property(nonatomic,strong,readwrite)NSString *articleUrl;

@property(nonatomic,strong,readwrite)GTNewsViewController *newsController;

@property(nonatomic,strong,readwrite)GTListItem *item ;

@end
@implementation GTNotification

+ (GTNotification *) notificationManager{
    static GTNotification *notification;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        notification = [[GTNotification alloc] init];
    });
    return notification;
}

- (void) checkNotificationAuthorization:(NSArray< GTListItem *>  *) dataArray  newsController:(GTNewsViewController *) newsController{
    
    UNUserNotificationCenter *center =  [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            self.item =   [dataArray firstObject];
            [self _pushLocalNotification:self.item];
            self.newsController = newsController;
            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [[UIApplication sharedApplication] registerForRemoteNotifications];
//            });
        }
    }];
}

#pragma mark -

- (void) _pushLocalNotification:(GTListItem *) item{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.badge = @(1);
    content.title = item.title;
    self.articleUrl = item.articleUrl;
//    content.body = item.authorName;
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:30.f repeats:NO ] ;
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"_pushLocalNotification" content:content trigger:trigger];
    
    [[UNUserNotificationCenter currentNotificationCenter]  addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"");
    }];
}

#pragma mark - delegate

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    completionHandler(UNNotificationPresentationOptionAlert);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
    
//    处理业务逻辑
    completionHandler();
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    Class cls = [GTMediator classForProtocol:@protocol(GTDetailViewControllerProtocol)];
    __kindof  UIViewController *detailController = [ [ cls alloc] detailViewControllerWithItem: self.item];
    detailController.title =   self.item.authorName;
//    detailController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<" style:UIBarButtonItemStyleDone target:self action:@selector(popController)];
    [self.newsController.navigationController pushViewController:detailController animated:YES];
}

@end
