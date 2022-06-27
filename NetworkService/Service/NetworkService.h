//
//  NetworkService.h
//  UpgradeModule
//
//  Created by Kevin on 2022/6/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkService : NSObject


- (void)POST:(NSString *)URLString paramater:(NSDictionary *)parameter success:(void(^)(NSData *data))success failure:(void(^)(NSError *error, NSURLResponse *response))failure;


@end

NS_ASSUME_NONNULL_END
