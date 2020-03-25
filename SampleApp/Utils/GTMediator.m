//
//  GTMediator.m
//  SampleApp
//
//  Created by penghuizhang on 2020/2/29.
//  Copyright © 2020 penghuizhang. All rights reserved.
//

#import "GTMediator.h"

@implementation GTMediator


+ ( __kindof UIViewController *) detailViewControllerWithItem:(GTListItem *) item{
    
   Class detailCls =  NSClassFromString(@"GTDetailViewController");
    UIViewController *controller = [[detailCls alloc] performSelector:NSSelectorFromString(@"initWithItem:") withObject:item];
    return controller;
}

#pragma mark -

+ (NSMutableDictionary *) mediatorCache{
    static NSMutableDictionary *cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = @{}.mutableCopy;
    });
    return cache;
}

+ (void) registerScheme:(NSString *)scheme processBlock:(GTMediatorProcessBlock)processBlock {
    if (scheme && processBlock) {
        [[ [self class] mediatorCache] setObject:processBlock forKey:scheme];
    }
}
+ (void) openUrl:(NSString *) url params:(NSDictionary *) params{
    GTMediatorProcessBlock block = [[ [self class] mediatorCache] objectForKey:url];
    if (block) {
        block(params);
    }
}

+ (void) registerProtocol:(Protocol *) proto class:(Class) cls{
    if (proto && cls) {
        [[[self class] mediatorCache] setObject:cls forKey: NSStringFromProtocol(proto)];
    }
}
+ (Class)classForProtocol:(Protocol *) proto{
    return [[[self class] mediatorCache] objectForKey:NSStringFromProtocol(proto)];
}

@end
