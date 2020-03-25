//
//  GTListLoader.m
//  SampleApp
//
//  Created by penghuizhang on 2020/2/19.
//  Copyright © 2020 penghuizhang. All rights reserved.
//

#import "GTListLoader.h"
#import <AFNetworking.h>
#import "GTListItem.h"

@interface GTListLoader()


@end

@implementation GTListLoader

- (void)loadListDataWithFinishBlock:(GTListLoaderFinishBlock)finishBlock type:(NSString *) type{
//    [[AFHTTPSessionManager manager] GET:@"http://v.juhe.cn/toutiao/index?type=top&key=97ad001bfcc2082e2eeaf798bad3d54e" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//    }];

    NSArray<GTListItem *> *listData =  [self _readDataFromLocal:type];
    if (listData) {
        finishBlock(YES, listData);
    }
    
 

    NSString *urlString =  [NSString stringWithFormat:@"%@%@%@", @"http://v.juhe.cn/toutiao/index?type=", type, @"&key=97ad001bfcc2082e2eeaf798bad3d54e"];

    NSURL *listUrl = [NSURL URLWithString:urlString];

    __unused NSURLRequest *listRequest = [NSURLRequest requestWithURL:listUrl];

    NSURLSession *session = [NSURLSession sharedSession];

    __weak typeof(self) weakSelf = self;

    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:listRequest completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        NSError *jsonError;
        id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
#warning 类型检查

          NSMutableArray *listItemArray = @[].mutableCopy;
        NSArray *dataArray;
        id result = [((NSDictionary *)jsonObj) objectForKey:@"result"];
//        if ( ) {

//        }
                    dataArray = [((NSDictionary *)[((NSDictionary *)jsonObj) objectForKey:@"result"]) objectForKey:@"data"];

                    for (NSDictionary *info in dataArray) {
                        GTListItem *listItem  = [[GTListItem alloc]init];
                        [listItem configWithDictionary:info];
                        [listItemArray addObject:listItem];
                    }

                    [weakSelf _archiveListDataWithArray:listItemArray.copy type:type];

                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (finishBlock) {
                            finishBlock(error == nil, listItemArray.copy);
                        }
                    });
    }];

    [dataTask resume];
}

#pragma mark - private method

- (NSArray<GTListItem *> *)_readDataFromLocal:(NSString *) type {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [pathArray firstObject];

    NSFileManager *fileManager =  [NSFileManager defaultManager];
    NSString *str = @"GTData/" ;
    if ([type isEqualToString: @"top"]) {
       str = [str stringByAppendingString:@"topList"];
    }else if ([type isEqualToString: @"keji"]){
        str = [str stringByAppendingString:@"kejiList"];
    }else if ([type isEqualToString: @"yule"]){
        str = [str stringByAppendingString:@"yuleList"];
    }else  if ([type isEqualToString: @"shishang"]){
        str = [str stringByAppendingString:@"shishangList"];
    }
    NSString *listDataPath = [cachePath stringByAppendingPathComponent:str];

    NSData *readListData = [fileManager contentsAtPath:listDataPath];

    id unarchiverObj =  [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class], [GTListItem class], nil] fromData:readListData error:nil];

    if ([unarchiverObj isKindOfClass:[NSArray class]] && [unarchiverObj count] > 0) {
        return (NSArray<GTListItem *> *)unarchiverObj;
    }
    return nil;
}

- (void)_archiveListDataWithArray:(NSArray<GTListItem *> *)array  type:(NSString *) type {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [pathArray firstObject];

//    创建文件夹
    NSFileManager *fileManager =  [NSFileManager defaultManager];
    NSString *dataPath = [cachePath stringByAppendingPathComponent:@"GTData"];
    NSError *createError;
    [fileManager createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:&createError];

//    创建文件
    NSString *listDataPath;
    if ([type isEqualToString: @"top"]) {
         listDataPath = [dataPath stringByAppendingPathComponent:@"topList"];
    }else if ([type isEqualToString: @"keji"]){
         listDataPath = [dataPath stringByAppendingPathComponent:@"kejiList"];
    }else if ([type isEqualToString: @"yule"]){
        listDataPath = [dataPath stringByAppendingPathComponent:@"yuleList"];
    }else if ([type isEqualToString: @"shishang"]){
        listDataPath = [dataPath stringByAppendingPathComponent:@"shishangList"];
    }
   

    NSData *listData =   [NSKeyedArchiver archivedDataWithRootObject:array requiringSecureCoding:YES error:nil];
//    NSData *listData = [@"abc" dataUsingEncoding:(NSUTF8StringEncoding)];
    [fileManager createFileAtPath:listDataPath contents:listData attributes:nil];

//    NSData *readListData = [fileManager contentsAtPath:listDataPath];

//    [[NSUserDefaults standardUserDefaults] setObject:listData forKey:@"listData"];
//
//    NSData *listDataTest = [[NSUserDefaults standardUserDefaults] dataForKey:@"listData" ];

//    id unarchiverObj =  [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class], [GTListItem class], nil] fromData:listDataTest error:nil];
//
//    NSLog(@"");
//    查询文件
//   __unused BOOL fileExist = [fileManager fileExistsAtPath:listDataPath];

//    删除文件
//    if (fileExist) {
//        [fileManager removeItemAtPath:listDataPath error:nil];
//    }

//    NSFileHandle *fileHandler = [NSFileHandle  fileHandleForUpdatingAtPath:listDataPath];
//
//    [fileHandler seekToEndOfFile];
//    [fileHandler writeData:[@"def" dataUsingEncoding:(NSUTF8StringEncoding)]];
//
//    [fileHandler synchronizeFile];
//    [fileHandler closeFile];
}

@end
