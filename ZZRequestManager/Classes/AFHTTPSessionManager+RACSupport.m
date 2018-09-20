//
//  AFHTTPSessionManager+Support.m
//  Test
//
//  Created by 张晗 on 16/3/16.
//  Copyright © 2016年 张晗. All rights reserved.
//
#import <ReactiveObjC.h>
#import "AFHTTPSessionManager+RACSupport.h"

@implementation AFHTTPSessionManager (RACSupport)

- (RACSignal *)rac_GET:(NSString *)path parameters:(id)parameters{
    
    return [[self rac_requestPath:path parameters:parameters method:@"GET"] setNameWithFormat:@"%@ -rac_GET: %@, parameters: %@", self.class, path, parameters];
}

- (RACSignal *)rac_HEAD:(NSString *)path parameters:(id)parameters{
    
    return [[self rac_requestPath:path parameters:parameters method:@"HEAD"] setNameWithFormat:@"%@ -rac_HEAD: %@, parameters: %@", self.class, path, parameters];
}

- (RACSignal *)rac_POST:(NSString *)path parameters:(id)parameters{
    
    return [[self rac_requestPath:path parameters:parameters method:@"POST"] setNameWithFormat:@"%@ -rac_POST: %@, parameters: %@", self.class, path, parameters];
}

- (RACSignal *)rac_PUT:(NSString *)path parameters:(id)parameters{
    
    return [[self rac_requestPath:path parameters:parameters method:@"PUT"] setNameWithFormat:@"%@ -rac_PUT: %@, parameters: %@", self.class, path, parameters];
}

- (RACSignal *)rac_PATCH:(NSString *)path parameters:(id)parameters{
    
    return [[self rac_requestPath:path parameters:parameters method:@"PATCH"] setNameWithFormat:@"%@ -rac_PATCH: %@, parameters: %@", self.class, path, parameters];
}

- (RACSignal *)rac_DELETE:(NSString *)path parameters:(id)parameters{
    
    return [[self rac_requestPath:path parameters:parameters method:@"DELETE"] setNameWithFormat:@"%@ -rac_DELETE: %@, parameters: %@", self.class, path, parameters];
}

- (RACSignal *)rac_POST:(NSString *)path parameters:(id)parameters formData:(void (^)(id<AFMultipartFormData>))block{
    
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        [[RACScheduler mainThreadScheduler] schedule:^{
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        }];
    
        NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:path parameters:parameters constructingBodyWithBlock:block error:nil];
        
        NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
            if (error) {
                
                [subscriber sendError:error];
            
            }else {
                
                [subscriber sendNext:RACTuplePack(responseObject,response)];
                
                [subscriber sendCompleted];
            }
        }];
        
        [task resume];
        
        return [RACDisposable disposableWithBlock:^{
            
            [task cancel];
            
            [[RACScheduler mainThreadScheduler] schedule:^{
                
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            }];
        }];
        
    }] setNameWithFormat:@"%@ -rac_POST: %@, parameters: %@, formData:", self.class, path, parameters];
}


- (RACSignal *)rac_requestPath:(NSString *)path parameters:(id)parameters method:(NSString *)method{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[RACScheduler mainThreadScheduler] schedule:^{
           
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        }];
        
        NSURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:path parameters:parameters error:nil];
        
        NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            
            if (error) {
                
                [subscriber sendError:error];
                
            }else {
            
                [subscriber sendNext:RACTuplePack(responseObject,response)];
                
                [subscriber sendCompleted];
            }
        }];
        
        [task resume];
        
        return [RACDisposable disposableWithBlock:^{
           
            [task cancel];
            
            [[RACScheduler mainThreadScheduler] schedule:^{
                
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            }];
        }];
    }];
}

@end
