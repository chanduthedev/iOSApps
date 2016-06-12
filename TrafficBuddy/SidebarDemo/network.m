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

+ (id)sharedManager {
    static network *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}


#pragma mark NSURLConnection Delegate Methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
//    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    

}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (NSDictionary *)parseNetworkResponse {
    NSLog(@"In parseNetworkResponse");
//    NSError *error;
//    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:_responseData options:0 error:&error];
//    if (error != NULL){
//        NSLog(@"got some error");
//    }
    //NSLog(@"Network response is %@", jsonDict);
    NSLog(@"leaving parseNetworkResponse");
    return nil;
}

- (id)getNetworkResponse: (NSData *)receivedData{
    NSLog(@"In getNetworkResponseAsArray");
    NSError *error;
    id jsonDict = [NSJSONSerialization JSONObjectWithData:receivedData options:0 error:&error];
    if (error != NULL){
        NSLog(@"got some error");
    }
    //NSLog(@"Network response is %@", jsonDict);
    NSLog(@"leaving getNetworkResponseAsArray");
    return jsonDict;
}

- (NSArray *)getNetworkResponseAsArray: (NSData *)receivedData{
    NSLog(@"In getNetworkResponseAsArray data is %@", receivedData);
    NSError *error;
    NSArray *jsonDict = [NSJSONSerialization JSONObjectWithData:receivedData options:0 error:&error];
    if (error != NULL){
        NSLog(@"got some error");
    }
    //NSLog(@"Network response is %@", jsonDict);
    NSLog(@"leaving getNetworkResponseAsArray %@",jsonDict);
    return jsonDict;
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
    //NSLog(@"testing --- 3");
    networkResponse = [self parseNetworkResponse];
    NSLog(@"Network response is %@", networkResponse);
    
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    //NSLog(@"testing --- 4 %@",error);
    networkResponse = (NSDictionary *)error;
    NSLog(@"testing --- 4 %@",networkResponse);    
    //    NSLog(@"error is %@",error);
}

- (NSMutableURLRequest *)createPostRequest:(NSString *)url vehicleNo:(NSString *)vehicleNo policeID:(NSString *)pID deviceNo:(NSString*)deviceNo imeiNo:(NSString*)imeiNO
{
    NSLog(@"In createPostRequest");
    // Create the request.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    NSString *post = [NSString stringWithFormat:@"vehicle_no=%@&police_id_no=%@&device_no=%@&imei_no=%@",vehicleNo, pID, deviceNo, imeiNO];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSLog(@"leaving createPostRequest");
    return request;
}

-(id)getCabDetails:(NSString *)url vehicleN:(NSString *)vehicleNo policeID:(NSString *)pID deviceNo:(NSString *)deviceNo imeiNo:(NSString *)imeiNo completionHandle:(void (^)(id))handler{
    
    NSLog(@"in getChallansFortheVehicle");
    NSMutableURLRequest *request = [self createPostRequest:url vehicleNo:vehicleNo policeID:pID deviceNo:deviceNo imeiNo:imeiNo];
    
    // Create url connection and fire request
    //    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    NSLog(@"request.URL is %@", request.URL);
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if(data !=nil){
                                   networkResponse =[self getNetworkResponseAsArray:data];
                                   handler(networkResponse);
                                   //                               NSLog(@"Async call response is %@",networkResponse);
                                   //                               NSLog(@"total chalans %lu",(unsigned long)[networkResponse count]);
                               }
                               else{
                                   NSLog(@"Response is nil");
                               }
                           }];
    NSLog(@"leaving getChallansFortheVehicle %@", networkResponse);
    return networkResponse;
    
}
-(NSArray *)getChallansFortheVehicle:(NSString*)url vehicleN:(NSString *)vehicleNo deviceNo:(NSString*)deviceNo imeiNo:(NSString*)imeiNo completionHandle:(void(^)(NSArray*))handler
{
    NSLog(@"in getChallansFortheVehicle");
    NSMutableURLRequest *request = [self createPostRequest:url vehicleNo:vehicleNo policeID:@"C8387" deviceNo:deviceNo imeiNo:imeiNo];
    
    // Create url connection and fire request
//    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if(data !=nil){
                               networkResponse =[self getNetworkResponse:data];
                                   handler(networkResponse);
//                               NSLog(@"Async call response is %@",networkResponse);
//                               NSLog(@"total chalans %lu",(unsigned long)[networkResponse count]);
                               }
                               else{
                               NSLog(@"Response is nil");    
                               }
                           }];
    NSLog(@"leaving getChallansFortheVehicle");
    return networkResponse;
}

- (BOOL)isNetworkAvailable
{
    CFNetDiagnosticRef dReference;
    dReference = CFNetDiagnosticCreateWithURL (NULL, (__bridge CFURLRef)[NSURL URLWithString:@"www.apple.com"]);
    
    CFNetDiagnosticStatus status;
    status = CFNetDiagnosticCopyNetworkStatusPassively (dReference, NULL);
    
    CFRelease (dReference);
    
    if ( status == kCFNetDiagnosticConnectionUp )
    {
        NSLog (@"Connection is Available");
        return YES;
    }
    else
    {
        NSLog (@"Connection is down");
        return NO;
    }
}


-(BOOL) isCabDetailsValid:(id)response{
    
    NSString *errMessage = [response objectForKey:@"message"];
    NSLog(@"In isCabDetailsValid error is %@", [response objectForKey:@"error"]);
    if (errMessage ) {
        NSLog(@"returning false");
        return false;
    }
    NSLog(@"returning true");
    return true;
}
@end
