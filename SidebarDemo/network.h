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
    NSMutableData *_responseData;
}
-(void)getChallansFortheVehicle:(NSString*)url vehicleN:(NSString *)vehicleNo deviceNo:(NSString*)deviceNo imeiNo:(NSString*)imeiNo;
@end
