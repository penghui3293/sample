//
//  GTListModel.m
//  SampleApp
//
//  Created by penghuizhang on 2020/3/17.
//  Copyright © 2020 penghuizhang. All rights reserved.
//

#import "GTRNSModel.h"

@interface GTRNSModel()

@property(nonatomic,strong,readwrite)NSString *uniqueId;
@property(nonatomic,assign,readwrite)CGRect *componentFrame;
@property(nonatomic,strong,readwrite)RNSComponentContext *customContext;

@end

@implementation GTRNSModel

-(NSString *)getUniqueId{
    return _uniqueId;
}
//-(void)setComponentFrame:(CGRect)frame{
//    _componentFrame = frame;
//}
//-(CGRect)getComponentFrame{
//    return _componentFrame;
//}
-(Class)getComponentViewClass{
    return NSClassFromString(@"GTComponentView");
}

-(Class)getComponentControllerClass{
    return NSClassFromString(@"GTComponentController");
}
-(__kindof RNSComponentContext *)getCustomContext{
    return _customContext;
}

@end
