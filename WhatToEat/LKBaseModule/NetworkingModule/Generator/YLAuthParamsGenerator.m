//
//  YLAuthParamsGenerator.m
//  YLNetworking
//
//  Created by Yunpeng on 16/7/1.
//  Copyright © 2016年 Yunpeng. All rights reserved.
//

#import "YLAuthParamsGenerator.h"
//#import "OUser.h"
#import "Constants.h"
#import "Foundation+LKTools.h"

NSString * const kYLAuthParamsKeyUserId = @"user_id"; //在此修改为userId对应的key
NSString * const kYLAuthParamsKeyUserToken = @"user_token";
NSString * const kYLAuthParamsKeyNewUserToken = @"new_user_token";
@implementation YLAuthParamsGenerator
+ (NSDictionary *)authParams {
  
    NSMutableDictionary *authParams = [[NSMutableDictionary alloc] init];

    return [authParams copy];
}
@end



@implementation NSDictionary (YLAuthParams)

- (NSDictionary *)dictionaryExceptToken {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:self];
//    NSArray<NSString *> *keys = [YLAuthParamsGenerator authParams].allKeys;
    // 这里保留UserId以防止不同用户的脏数据
//    [keys enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if (![obj isEqualToString:kYLAuthParamsKeyUserId]) {
//            [dict removeObjectForKey:obj];
//        }
//    }];
//
    [dict removeObjectsForKeys:@[kYLAuthParamsKeyUserToken,
                                 kYLAuthParamsKeyNewUserToken,
                                 @"lib_password"]];
    return [dict copy];
}
@end
