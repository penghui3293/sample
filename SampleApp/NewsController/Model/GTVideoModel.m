//
//  GTVideoModel.m
//  SampleApp
//
//  Created by penghuizhang on 2020/3/23.
//  Copyright © 2020 penghuizhang. All rights reserved.
//

#import "GTVideoModel.h"

@implementation GTVideoModel

- (void)setComponentIndex:(NSString *)componentIndex {
    objc_setAssociatedObject(self, @selector(setComponentIndex:), componentIndex, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//- (NSString *)componentIndex {
//    NSString *index = objc_getAssociatedObject(self, @selector(setComponentIndex:)); return index ? : INDEX;
//}

@end
