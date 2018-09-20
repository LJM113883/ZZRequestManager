//
//  ZZRequsetManager.m
//  ZZRequestManager
//
//  Created by Min Han on 2018/9/20.
//  Copyright © 2018年 Luojm. All rights reserved.
//
#import "AFHTTPSessionManager+RACSupport.h"
#import "ZZRequsetManager.h"
#import <ReactiveObjC.h>
@interface ZZRequsetManager()
@property (nonatomic, strong)AFHTTPSessionManager *sessionManager;

@end
@implementation ZZRequsetManager
static ZZRequsetManager *_instance;
+ (id)allocWithZone:(NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ \
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
+ (ZZRequsetManager *)shareZZRequestmanager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sessionManager = [AFHTTPSessionManager manager];
        self.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    }
    return self;
}
- (NSMutableDictionary *)parameters{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    return dict;
}
#pragma mark -- GET请求方式
- (RACSignal *)rac_GETWithMatchString:(NSString *)shortURL parameters:(NSDictionary *)parameters{
    
    NSMutableDictionary *dict = [self parameters];
    [dict addEntriesFromDictionary:parameters];
    return [[[[[self.sessionManager rac_GET:shortURL parameters:dict] map:^id(RACTuple *tuple) {
        
        return [[NSString alloc] initWithData:tuple.first encoding:NSUTF8StringEncoding];
        
    }] filter:^BOOL(NSDictionary *responseObject) {
        return NO;
    }] map:^id(id value) {
        return value;
    }] doError:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
}

#pragma mark -- POST请求方式
- (RACSignal *) rac_POSTWithMatchString:(NSString *)shortURL parameters:(NSDictionary *)parameters{
    
    NSMutableDictionary *dict = [self parameters];
    [dict addEntriesFromDictionary:parameters];
    NSLog(@"请求条件 %@",dict);
    return [[[[[self.sessionManager rac_POST:shortURL parameters:dict] map:^id(RACTuple *tuple) {
        return [[NSString alloc] initWithData:tuple.first encoding:NSUTF8StringEncoding];
    }] filter:^BOOL(NSDictionary *responseObject) {
        return NO;
    }] map:^id(id value) {
        return value;
    }] doError:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
}
@end
