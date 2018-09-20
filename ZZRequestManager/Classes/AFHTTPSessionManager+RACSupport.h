//
//  AFHTTPSessionManager+Support.h
//  Test
//
//  Created by 张晗 on 16/3/16.
//  Copyright © 2016年 张晗. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@class RACSignal;

@interface AFHTTPSessionManager (RACSupport)

- (RACSignal *)rac_GET:(NSString *)path parameters:(id)parameters;

- (RACSignal *)rac_POST:(NSString *)path parameters:(id)parameters;

- (RACSignal *)rac_POST:(NSString *)path parameters:(id)parameters formData:(void(^)(id<AFMultipartFormData>formData))block;

- (RACSignal *)rac_HEAD:(NSString *)path parameters:(id)parameters;

- (RACSignal *)rac_PUT:(NSString *)path parameters:(id)parameters;

- (RACSignal *)rac_PATCH:(NSString *)path parameters:(id)parameters;

- (RACSignal *)rac_DELETE:(NSString *)path parameters:(id)parameters;

@end
