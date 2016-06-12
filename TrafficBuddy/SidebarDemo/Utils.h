//
//  Utils.h
//  trafficBuddySample
//
//  Created by Chandrasekhar Pasumarthi on 08/04/16.
//  Copyright © 2016 com.chanduthedev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+(NSString *)getDeviceID;
+(NSString *)getIMEIID;
+(NSArray *)getPSGeoDetails;
+(NSAttributedString*)getHtmlString:(NSString*) str;
+(BOOL) isEmptyString:(NSString *)str;
+(BOOL) checkVehiclNoNPoliceID:(NSString*)vehicleNo policeID:(NSString*)policeID;
+(BOOL)checkVehicleNoValid:(NSString*)vehicleNo;
//+(void) displayAlert:(NSString *) str;
+(void) displayAlert:(NSString *) title displayText:(NSString *)text;
+(NSString*) getCabDetailsToDisplay:(NSDictionary*)vehicleDetails;
+(NSString *)getCurrentTime;
@end
