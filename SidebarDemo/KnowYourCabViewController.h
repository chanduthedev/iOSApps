//
//  KnowYourCabViewController.h
//  TrafficBuddy
//
//  Created by Chandrasekhar Pasumarthi on 21/04/16.
//  Copyright © 2016 Testing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface KnowYourCabViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;

@property (nonatomic) BOOL isReading;
@property (weak, nonatomic) IBOutlet UIView *viewPreview;
-(BOOL)startReading;
-(BOOL)stopReading;


@end
