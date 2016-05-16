//
//  Utils.m
//  trafficBuddySample
//
//  Created by Chandrasekhar Pasumarthi on 08/04/16.
//  Copyright © 2016 com.chanduthedev. All rights reserved.
//

#import "Utils.h"
#import "Annotations.h"

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


+(NSArray *)getPSGeoDetails{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"psGeoCSV" ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSMutableArray *entries = [[NSMutableArray alloc] init];
    for (NSString *line in [content componentsSeparatedByString:@"\n"]) {
        NSArray *rows = [line componentsSeparatedByString:@","];
        
        CLLocationCoordinate2D center;
        center.latitude = [[rows objectAtIndex:2] doubleValue];
        center.longitude =[[rows objectAtIndex:3] doubleValue];
        Annotations *myAnn = [[Annotations alloc] init];
        myAnn.coordinate = center;
        myAnn.title = [rows objectAtIndex:1];
        //myAnn.subtitle = [rows objectAtIndex:0];
        myAnn.psID = [rows objectAtIndex:0];
        
        [entries addObject:myAnn];
    }
    return entries;
//    NSMutableArray *annotations = [[NSMutableArray alloc] init];
//    Annotations *myAnn = [[Annotations alloc] init];
//    [annotations addObject:myAnn];
//    return annotations;
}

+(NSAttributedString*)getHtmlString:(NSString*) str{
    return [[NSAttributedString alloc]
                                            initWithData: [str dataUsingEncoding:NSUnicodeStringEncoding]
                                            options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                            documentAttributes: nil
                                            error: nil
                                            ];

}

+(BOOL) isEmptyString:(NSString *)str{
    return [str length]?true:false;
}

//TODO need to refactor it later
+(BOOL) checkVehiclNoNPoliceID:(NSString*)vehicleNo policeID:(NSString*)policeID{
    
//    if(![Utils checkVehicleNoValid:vehicleNo] && ![Utils checkVehicleNoValid:policeID]){
//        return false;
//    }
//    return true;
    
    BOOL isVechilNoValid = [Utils isEmptyString:vehicleNo];
    BOOL isPoliceIdValid = [Utils isEmptyString:policeID];
    if (!isVechilNoValid && !isPoliceIdValid)
    {
        NSLog(@"VehicleNo or PoliceID should not be empty");
        [Utils displayAlert:@"Invalid input Values" displayText:@"VehicleNo or PoliceID should not be empty"];
        return false;
    }else if(!isPoliceIdValid && [vehicleNo length]<10){
        NSLog(@"VehicleNo is not Valid");
        [Utils displayAlert:@"Invalid input Values" displayText:@"VehicleNo is not Valid"];
        return false;
    }else if(!isVechilNoValid && [policeID length]<5){
        NSLog(@"PoliceID is not Valid");
        [Utils displayAlert:@"Invalid input Values" displayText:@"PoliceID is not Valid"];
        return false;
    }else if([vehicleNo length]<10 && [policeID length]<5){
        NSLog(@"VehicleNo is not Valid");
        [Utils displayAlert:@"Invalid input Values" displayText:@"VehicleNo is not Valid"];
        return false;
    }
    return true;
}

+(BOOL)checkVehicleNoValid:(NSString*)vehicleNo {
    if(![Utils isEmptyString:vehicleNo] || [vehicleNo length]<10)
        return false;
    return true;
}

+(void) displayAlert:(NSString *) title displayText:(NSString *)text{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:text delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    return;
}
+(NSString*) getCabDetailsToDisplay:(NSDictionary*)vehicleDetails{
    id cabDetails = [vehicleDetails objectForKey:@"cab_details"];
    id ratings = [vehicleDetails objectForKey:@"ratings"];
    NSString *avgRating = [ratings objectForKey:@"avg_rating"];
    NSLog(@"avgRating  %@", avgRating);
    return [NSString stringWithFormat:@"Police ID No    :	%@\nOwner Name		:	%@\nVehicle No		:	%@\nOwner Contact	:	%@\nVehicle Make    :	%@\nVehicle Color	:	%@\nVehicle MFR		:	%@\nVehicle Permit	:	%@\nPermit Validity	:	%@\nVehicle Fitness	:	%@\nFitness Validity    :	%@\n", [cabDetails objectForKey:@"prnumber"],
            [cabDetails objectForKey:@"ownername"],
            [cabDetails objectForKey:@"rtanumber"],
            [cabDetails objectForKey:@"ownercontactnumber"],
            [cabDetails objectForKey:@"make"],
            [cabDetails objectForKey:@"color"],
            [cabDetails objectForKey:@"mfgdate"],
            [cabDetails objectForKey:@"permitnumber"],
            [cabDetails objectForKey:@"permitvalidity"],
            [cabDetails objectForKey:@"fitnesscertificatenumber"],
            [cabDetails objectForKey:@"fitnessvalidity"]];
    
}

+(NSString *)getCurrentTime{
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy MMM dd HH:mm:ss"];
    NSString    *strTime = [objDateformat stringFromDate:[NSDate date]];
    return strTime;
}
@end
