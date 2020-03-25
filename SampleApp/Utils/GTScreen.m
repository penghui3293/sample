//
//  GTScreen.m
//  SampleApp
//
//  Created by penghuizhang on 2020/2/27.
//  Copyright © 2020 penghuizhang. All rights reserved.
//

#import "GTScreen.h"

@implementation GTScreen

//iphone xs max
+ (CGSize) sizeFor65Inch{
    return CGSizeMake(414, 896);
}
//iphone xr
+ (CGSize) sizeFor61Inch{
    return CGSizeMake(414, 896);
}
//iphone x
+ (CGSize) sizeFor58Inch{
    return CGSizeMake(375, 812);
}
@end
