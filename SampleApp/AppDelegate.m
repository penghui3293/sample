//
//  AppDelegate.m
//  SampleApp
//
//  Created by penghuizhang on 2020/3/4.
//  Copyright © 2020 penghuizhang. All rights reserved.
//

#import "AppDelegate.h"
#import "GTNewsViewController.h"
#import "GTVideoViewController.h"
#import "GTRecommendViewController.h"
#import "GTMineViewController.h"
#import "GTSplashView.h"
#include <execinfo.h>
#import "GTLocation.h"
#import "GTNotification.h"
#import "GTListLoader.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@property (nonatomic, strong, readwrite) NSArray *dataArray;
@property (nonatomic, strong, readwrite) GTListLoader *listLoader;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
     self.window = [[UIWindow alloc]  initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UITabBarController *tarbarController = [[UITabBarController alloc] init];
    
    GTNewsViewController *newsController = [[GTNewsViewController alloc] initWithUrlString:@"top"];
    
    GTVideoViewController *videoViewController = [[GTVideoViewController alloc] init];
    
    GTRecommendViewController *recommendController = [[GTRecommendViewController alloc] init];
    
    GTMineViewController *mineViewController = [[GTMineViewController alloc] init];
    
    [tarbarController setViewControllers:@[newsController,videoViewController,recommendController,mineViewController]];
    
    tarbarController.delegate = self;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tarbarController];
    
    self.window.rootViewController = navigationController;
    
    [self.window makeKeyAndVisible];
    
    [self.window addSubview:({
        GTSplashView *splashView = [[GTSplashView alloc] initWithFrame:self.window.bounds];
        splashView;
    })];
    //static
    //    [[GTStaticTest alloc] init];
    //framework
    //    [[GTFrameworkTest alloc] init];
    
//    [self _caughtException];
//    [@[].mutableCopy addObject:nil];
//
    [[GTLocation locationManager] checkLocationAuthorization];
    
//
    self.listLoader = [[GTListLoader alloc]init];
    __weak typeof(self) wself = self;
    
    [self.listLoader loadListDataWithFinishBlock:^(Boolean success, NSArray<GTListItem *> * _Nonnull dataArray) {
        __strong typeof(self) strongSelf  = wself;
        strongSelf.dataArray = dataArray;
    } type:@"top"];
    
    [[GTNotification notificationManager] checkNotificationAuthorization:self.dataArray  newsController:newsController];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 1;
    
//  NSUserDefaults *userDefault =  [[NSUserDefaults alloc] initWithSuiteName:@"group.com.penghuizhang.sample"];
//    [userDefault setObject:@"从零开始iOS开发" forKey:@"title"];
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//    [self _changeIcon];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    //GTNotificaton实现
    NSLog(@"");
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
     NSLog(@"");
}

#pragma mark -

- (void) _changeIcon{
    
    if ([ [UIApplication sharedApplication] supportsAlternateIcons]) {
        [ [UIApplication sharedApplication] setAlternateIconName:@"ICONBLACK" completionHandler:^(NSError * _Nullable error) {
            NSLog(@"");
        }];
    }
}

#pragma mark - crash

- (void) _caughtException{
//    NSException
    NSSetUncaughtExceptionHandler(HandlerNSException);
//    signal
    signal(SIGABRT, SignalExceptionHandler);
    signal(SIGKILL, SignalExceptionHandler);
    signal(SIGSEGV, SignalExceptionHandler);
    signal(SIGFPE, SignalExceptionHandler);
    signal(SIGPIPE, SignalExceptionHandler);
}

void SignalExceptionHandler(int signal){
    void *callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack, frames);
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (int i = 0; i < frames;  i ++) {
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    //存储crash信息
}

void HandlerNSException(NSException *exception){
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    //存储crash信息
}




@end
