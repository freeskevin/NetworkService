//
//  NetworkService.m
//  UpgradeModule
//
//  Created by Kevin on 2022/6/27.
//

#import "NetworkService.h"

@interface NetworkService ()

@property (strong, nonatomic) NSURLSession *session;




@end


@implementation NetworkService


- (instancetype)init
{
    self = [super init];
    if (self) {
        _session = [NSURLSession sharedSession];
    }
    return self;
}


- (void)POST:(NSString *)URLString paramater:(NSDictionary *)parameter success:(void(^)(NSData *data))success failure:(void(^)(NSError *error, NSURLResponse *response))failure
{
    NSURLRequest *request = [self requestWithURL:URLString parameter:parameter];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            failure(error, response);
        } else {
            success(data);
        }
        
    }] resume];
}

- (NSMutableURLRequest *)requestWithURL:(NSString *)URLString parameter:(NSDictionary *)parameter
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    request.HTTPMethod = @"POST";
    if (parameter.allKeys.count) {
        request.HTTPBody = [self dataWithDictionary:parameter];
    }
    return request;
}

- (NSData *)dataWithDictionary:(NSDictionary *)parameter
{
    NSMutableArray *mutableQueryArr = [[NSMutableArray alloc] init];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES selector:@selector(compare:)];
    
    for (NSString *key in [parameter.allKeys sortedArrayUsingDescriptors: @[sortDescriptor]]) {
        id value = parameter[key];
        if (value) {
            [mutableQueryArr addObject:[NSString stringWithFormat:@"%@=%@", key, value]];
        }
    }
    
    return [[mutableQueryArr componentsJoinedByString:@"&"] dataUsingEncoding:NSUTF8StringEncoding];
}

@end
