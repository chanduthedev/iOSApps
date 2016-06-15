//
//  network.h
//  trafficBuddySample
//
//  Created by Chandrasekhar Pasumarthi on 01/04/16.
//  Copyright © 2016 com.chanduthedev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface network : NSObject<NSURLConnectionDelegate>
{    
    id networkResponse;
}
+ (id)sharedManager;
-(NSArray *)getChallansFortheVehicle:(NSString*)url vehicleN:(NSString *)vehicleNo deviceNo:(NSString*)deviceNo imeiNo:(NSString*)imeiNo completionHandle:(void(^)(NSArray*))handler;
- (NSArray *)getNetworkResponseAsArray: (NSData *)receivedData;
- (id)getNetworkResponse: (NSData *)receivedData;

-(id)getCabDetails:(NSString*)url vehicleN:(NSString *)vehicleNo policeID:(NSString *)pID deviceNo:(NSString*)deviceNo imeiNo:(NSString*)imeiNo completionHandle:(void(^)(id))handler;
-(id)getCabDetails:(NSString *)url params:(NSDictionary *)params completionHandle:(void (^)(id))handler;
-(BOOL) isCabDetailsValid:(id)response;
- (BOOL)isNetworkAvailable;
@end
