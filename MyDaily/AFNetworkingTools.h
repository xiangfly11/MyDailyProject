//
//  AFNetworkingTools.h
//  MyDaily
//
//  Created by 李嘉翔 on 6/28/16.
//  Copyright © 2016 Jiaxiang Li. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

/* Http Request Type */
typedef NS_ENUM(NSUInteger,HttpRequestType){
    HttpRequestTypeGet = 0,
    HttpRequestTypePost
};

/* Block for request success */
typedef void(^requestSuccess) (NSDictionary *object);

/* Block for request failed */
typedef void(^requestFailure)(NSError *error);

/* Block for upload progress */
typedef void(^uploadProgress)(float progress);

/* Block for dowload progress */
typedef void(^downloadProgress)(float progress);




@interface AFNetworkingTools : AFHTTPSessionManager

/* Create singleton instance */
+(instancetype) sharedManager;

+(void) requestWithType:(HttpRequestType) type withUrlString:(NSString *) urlStr withParameters:(id) parameters withSuccessBlock:(requestSuccess) successBlock withFailureBlock:(requestFailure) failureBlock progress:(downloadProgress) progress;


@end
