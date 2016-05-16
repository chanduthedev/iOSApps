//
//  Utils.m
//  trafficBuddySample
//
//  Created by Chandrasekhar Pasumarthi on 08/04/16.
//  Copyright © 2016 com.chanduthedev. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (NSString *)getUUID {
    NSString *uuid = [[NSUUID UUID] UUIDString];
    return uuid;
}

+(NSString *)getDeviceID{
    
    return [self getUUID];
}

+(NSString *)getIMEIID{
    
    return [self getUUID];
}

+(void)setDeviceId{
}

@end
