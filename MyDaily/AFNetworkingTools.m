//
//  AFNetworkingTools.m
//  MyDaily
//
//  Created by 李嘉翔 on 6/28/16.
//  Copyright © 2016 Jiaxiang Li. All rights reserved.
//

#import "AFNetworkingTools.h"


@implementation AFNetworkingTools

+(instancetype) sharedManager {
    static AFNetworkingTools *tool = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        tool = [[self alloc] initWithBaseURL:[NSURL URLWithString:BaseURL]];
    });
    
    return tool;
}

-(instancetype) initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    
    if (self) {
        NSAssert(url, @"Please input URL.");
        self.requestSerializer.timeoutInterval = 20;
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        
        AFJSONResponseSerializer *responseSerialzer = [AFJSONResponseSerializer serializer];
        responseSerialzer.removesKeysWithNullValues = YES;
        self.responseSerializer = responseSerialzer;
        
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content_Type"];
        [self.requestSerializer setValue:APIKey forHTTPHeaderField:@"apikey"];
        [self.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain",@"application/json",@"text/json",@"text/javascript",@"text/html", nil]];
    }
    
    return self;
}

+(void) requestWithType:(HttpRequestType)type withUrlString:(NSString *)urlStr withParameters:(id)parameters withSuccessBlock:(requestSuccess)successBlock withFailureBlock:(requestFailure)failureBlock progress:(downloadProgress)progress {
    
    switch (type) {
        case HttpRequestTypeGet: {
            [[AFNetworkingTools sharedManager] GET:urlStr parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
//                progress(downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                successBlock(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failureBlock(error);
            }];
            break;
        }
        case HttpRequestTypePost: {
            [[AFNetworkingTools sharedManager] POST:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                successBlock(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failureBlock(error);
            }];
            break;
        }
        default:
            break;
    }
}




@end
