//
//  ZZRequsetManager.h
//  ZZRequestManager
//
//  Created by Min Han on 2018/9/20.
//  Copyright © 2018年 Luojm. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RACSignal;
@interface ZZRequsetManager : NSObject

// 单例管理类
+(ZZRequsetManager*)shareZZRequestmanager;

@property (nonatomic, assign, readonly) BOOL isReachable;

- (RACSignal *)rac_GETWithMatchString:(NSString *)shortURL parameters:(NSDictionary *)parameters;

- (RACSignal *)rac_POSTWithMatchString:(NSString *)shortURL parameters:(NSDictionary *)parameters;
@end
