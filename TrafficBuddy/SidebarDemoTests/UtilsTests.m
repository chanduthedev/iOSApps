//
//  UtilsTests.m
//  TrafficBuddy
//
//  Created by Chandrasekhar Pasumarthi on 11/05/16.
//  Copyright © 2016 Testing. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Utils.h"

@interface UtilsTests : XCTestCase

@end

@implementation UtilsTests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
//    [[[XCUIApplication alloc] init] launch];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testpsGeolistCount {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
//    NSArray *geoData = [Utils getPSGeoDetails];
//    int count = [geoData count];
//    NSLog(@"Testing count is %d", count);
    XCTAssertEqual(1, 1);
    
    
}

- (void)testisEmptyStrShouldReturnFalse {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    
    XCTAssertEqual(false, [Utils isEmptyString:@""]);
    
    
}

- (void)testisEmptyStrShouldReturnTrue {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    
    XCTAssertEqual(true, [Utils isEmptyString:@"test"]);
    
    
}


- (void)testcheckVehiclNoNPoliceIDShouldReturnFalseForEmptyVehicleNoAndPoliceID {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    //[Utils checkVehiclNoNPoliceID:@"tn09bh7105" policeID:@""];
    XCTAssertEqual(false, [Utils checkVehiclNoNPoliceID:@"" policeID:@""]);
    
    
}

- (void)testcheckVehiclNoNPoliceIDShouldReturnTrueForValidVehicleNoAndPoliceID {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    //[Utils checkVehiclNoNPoliceID:@"tn09bh7105" policeID:@""];
    XCTAssertEqual(true, [Utils checkVehiclNoNPoliceID:@"tn09bh7105" policeID:@"tn09bh7105"]);
    
    
}

- (void)testcheckVehiclNoNPoliceIDShouldReturnFalseForInValidVehicleNoAndPoliceID {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    //[Utils checkVehiclNoNPoliceID:@"tn09bh7105" policeID:@""];
    XCTAssertEqual(false, [Utils checkVehiclNoNPoliceID:@"testing" policeID:@"test"]);
    
    
}
- (void)testcheckVehiclNoNPoliceIDShouldReturnFalseForInValidVehicleNo {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    //[Utils checkVehiclNoNPoliceID:@"tn09bh7105" policeID:@""];
    XCTAssertEqual(false, [Utils checkVehiclNoNPoliceID:@"testing" policeID:@""]);
    
    
}

- (void)testcheckVehiclNoNPoliceIDShouldReturnTrueForValidVehicleNo {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    //[Utils checkVehiclNoNPoliceID:@"tn09bh7105" policeID:@""];
    XCTAssertEqual(true, [Utils checkVehiclNoNPoliceID:@"tn09bh7105" policeID:@""]);
    
    
}


- (void)testcheckVehiclNoNPoliceIDShouldReturnFalseForInValidPoliceID {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    //[Utils checkVehiclNoNPoliceID:@"tn09bh7105" policeID:@""];
    XCTAssertEqual(false, [Utils checkVehiclNoNPoliceID:@"" policeID:@"test"]);
    
    
}

- (void)testcheckVehiclNoNPoliceIDShouldReturnTrueForValidPoliceID {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    //[Utils checkVehiclNoNPoliceID:@"tn09bh7105" policeID:@""];
    XCTAssertEqual(true, [Utils checkVehiclNoNPoliceID:@"" policeID:@"tn09bh7105"]);
    
    
}

-(void)testGetCurrentTimeStamp{
    NSLog(@"time is is %@", [Utils getCurrentTime]);
}

-(void)testgetParameterisedStrShouldReturnParameterisedStr{
    NSDictionary * dict = [NSDictionary
                           dictionaryWithObjects:@[@"king",@"33",@"India",@"India"]
                           forKeys:@[@"name",@"age",@"location",@"country"]];
    NSString *expected = @"name=king&age=33&country=India&location=India";
    XCTAssertEqualObjects(expected, [Utils getParameterisedStr:dict]);
}

-(void)testgetParameterisedStrShouldReturnEmptyStrIfEmptyDict{
    NSDictionary * dict = [[NSDictionary alloc]init];
                           
    NSString *expected = @"";
    
    XCTAssertEqualObjects(expected, [Utils getParameterisedStr:dict]);
}


@end
