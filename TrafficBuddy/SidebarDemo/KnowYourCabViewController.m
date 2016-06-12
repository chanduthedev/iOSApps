//
//  KnowYourCabViewController.m
//  TrafficBuddy
//
//  Created by Chandrasekhar Pasumarthi on 21/04/16.
//  Copyright © 2016 Testing. All rights reserved.
//

#import "KnowYourCabViewController.h"
#import "CabDetailsViewController.h"
#import "SWRevealViewController.h"

@interface KnowYourCabViewController ()
{
    NSString *data;
}
@end

@implementation KnowYourCabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    _isReading = NO;
    _captureSession = nil;
    [self startReading];
    NSLog(@"in KnowYourCabViewController");
    [self.navigationItem setHidesBackButton:YES];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"QRCodeResult"]) {
        CabDetailsViewController * cabDetailsVC = segue.destinationViewController;
        cabDetailsVC.cabDetails  = data;
        NSLog(@"testing: in prepareForSegue cabDetails are %@", cabDetailsVC.cabDetails);
    }
    NSLog(@"testing: in prepareForSegue");
}


-(BOOL)startReading{
    NSError *error;
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession addInput:input];
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:_viewPreview.layer.bounds];
    [_viewPreview.layer addSublayer:_videoPreviewLayer];
    
    [_captureSession startRunning];
    return YES;
}

-(BOOL)stopReading{
    [_captureSession stopRunning];
    _captureSession = nil;
    
    [_videoPreviewLayer removeFromSuperlayer];
    return YES;
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            NSString * result =[metadataObj stringValue];
            //NSLog(@"[metadataObj stringValue] is %@", [metadataObj stringValue]);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self stopReading];
                [self performSegueWithIdentifier:@"QRCodeResult" sender:nil];
            });
            
            //NSLog(@"metadataObj is %@", foo);
            data = result;
            NSLog(@"testing : in data is %@", data);
        }
    }
}

@end
