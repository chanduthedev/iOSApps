//
//  network.m
//  trafficBuddySample
//
//  Created by Chandrasekhar Pasumarthi on 01/04/16.
//  Copyright © 2016 com.chanduthedev. All rights reserved.
//

#import "network.h"

#define SERVICE_URL @"http://police.nayalabs.com/api/testchallanwebservice.php"
@implementation network

- (void)viewDidLoad {
    
}

- (void)didReceiveMemoryWarning {
    
}


#pragma mark NSURLConnection Delegate Methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)parseNetworkResponse {
    NSLog(@"In parseNetworkResponse");
    NSError *error;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:_responseData options:0 error:&error];
    if (error != NULL){
        NSLog(@"got some error");
    }
    NSLog(@"Network response is %@", jsonDict);
    NSLog(@"leaving parseNetworkResponse");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
    NSLog(@"testing --- 3");
    [self parseNetworkResponse];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    NSLog(@"testing --- 4 %@",error);
    //    NSLog(@"error is %@",error);
}

- (NSMutableURLRequest *)createPostRequest:(NSString *)vehicleNo deviceNo:(NSString*)deviceNo imeiNo:(NSString*)imeiNO
{
    NSLog(@"In createPostRequest");
    // Create the request.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:SERVICE_URL]];
    
    [request setHTTPMethod:@"POST"];
    NSString *post = [NSString stringWithFormat:@"vehicle_no=%@&device_no=%@&imei_no=%@",vehicleNo, deviceNo, imeiNO];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSLog(@"leaving createPostRequest");
    return request;
}

-(void)getChallansFortheVehicle:(NSString*)url vehicleN:(NSString *)vehicleNo deviceNo:(NSString*)deviceNo imeiNo:(NSString*)imeiNo
{
    NSLog(@"in getChallansFortheVehicle");
    NSMutableURLRequest *request = [self createPostRequest:vehicleNo deviceNo:deviceNo imeiNo:imeiNo];
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSLog(@"leaving getChallansFortheVehicle");
}
@end
