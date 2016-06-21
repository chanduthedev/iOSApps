//
//  PublicEyeViewController.m
//  TrafficBuddy
//
//  Created by Chandrasekhar Pasumarthi on 18/05/16.
//  Copyright © 2016 Testing. All rights reserved.
//

#import "PublicEyeViewController.h"
#import "SWRevealViewController.h"
#import "Utils.h"
#import "Annotations.h"
#import "AppDelegate.h"
#import <AWSCore/AWSCore.h>
#import <AWSS3/AWSS3.h>
#import <AWSDynamoDB/AWSDynamoDB.h>
#import <AWSSQS/AWSSQS.h>
#import <AWSSNS/AWSSNS.h>
#import <AWSCognito/AWSCognito.h>

@interface PublicEyeViewController ()

@end

@implementation PublicEyeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // initialize Account Kit
    if (_accountKit == nil) {
        // may also specify AKFResponseTypeAccessToken
        _accountKit = [[AKFAccountKit alloc] initWithResponseType:AKFResponseTypeAuthorizationCode];
    }
    
    // view controller for resuming login
    _pendingLoginViewController = [_accountKit viewControllerForLoginResume];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.categories.delegate = self;
    self.categories.dataSource = self;
    self.comments.delegate = self;
    self.selectedImage = nil;
    self.categoryTypes = [[NSArray alloc] initWithObjects:@"Traffic Voilation",@"Report Traffic Accident",@"Refusal by Taxi/Auto/Public Bus",@"Over charging by Taxi/Auto/Public Bus", @"Misbehaviour by Taxi/Auto/Public Bus", @"Other", nil];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    self.categories.hidden = YES;
    // Do any additional setup after loading the view.
    AppDelegate *sharedApp = ((AppDelegate*)[[UIApplication sharedApplication]delegate]);
    NSLog(@"isLoggedIn is %d", [sharedApp isFaceBookLoggedIn]);
    //TODO need to uncomment this for facebook SMS validation
//    if (![sharedApp isFaceBookLoggedIn]){
//        NSString *preFillPhoneNumber = nil;
//        NSString *inputState = [[NSUUID UUID] UUIDString];
//        UIViewController<AKFViewController> *viewController = [_accountKit viewControllerForPhoneLoginWithPhoneNumber:preFillPhoneNumber
//                                                                                                                state:inputState];
//        viewController.enableSendToFacebook = YES; // defaults to NO
//        [self _prepareLoginViewController:viewController]; // see below
//        [self presentViewController:viewController animated:YES completion:NULL];
//    }else{
//        NSLog(@"is already LoggedIn no need to login %d", [sharedApp isFaceBookLoggedIn]);
//    }
    
//    AWSCognitoCredentialsProvider *credentialsProvider = [[AWSCognitoCredentialsProvider alloc]
//                                                          initWithRegionType:AWSRegionUSEast1
//                                                          identityPoolId:@"us-east-1:dd42b002-e9c7-4920-a190-d2d42fe05095"];
//
//    
//    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUSEast1 credentialsProvider:credentialsProvider];
//    
//    [AWSServiceManager defaultServiceManager].defaultServiceConfiguration = configuration;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"in viewWillAppear");
    
    
    if (_pendingLoginViewController != nil) {
        // resume pending login (if any)
        [self _prepareLoginViewController:_pendingLoginViewController];
        [self presentViewController:_pendingLoginViewController
                           animated:animated
                         completion:NULL];
        _pendingLoginViewController = nil;
    }
}

- (void)viewController:(UIViewController<AKFViewController> *)viewController didCompleteLoginWithAuthorizationCode:(NSString *)code state:(NSString *)state{
    //need to send this to server
    NSLog(@"Code is : %@", code);
    AppDelegate *sharedApp = ((AppDelegate*)[[UIApplication sharedApplication]delegate]);
    [sharedApp setIsFaceBookLoggedIn:true];
}


- (void)_prepareLoginViewController:(UIViewController<AKFViewController> *)loginViewController
{
    loginViewController.delegate = self;
    loginViewController.defaultCountryCode = @"IN";
    // Optionally, you may use the Advanced UI Manager or set a theme to customize the UI.
    //    loginViewController.advancedUIManager = _advancedUIManager;
    //    loginViewController.theme = [Themes bicycleTheme];
}


- (void)viewController:(UIViewController<AKFViewController> *)viewController didFailWithError:(NSError *)error{
    NSLog(@"got FB validation error %@", error.description);
}
- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"Testing: pinning selected address");
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    Annotations *annot = [[Annotations alloc] init];
    annot.coordinate = touchMapCoordinate;
    [self.mapView addAnnotation:annot];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_categoryTypes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    // Reuse and create cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [_categoryTypes objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"In didSelectRowAtIndexPath %d", indexPath.row);
    UITableViewCell *cell = [self.categoryTypes objectAtIndex:indexPath.row];
    [_selectedCategory setTitle:cell forState:UIControlStateNormal];
    self.categories.hidden = YES;
    NSLog(@"In didSelectRowAtIndexPath %@", cell);
}


- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [textView resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)selectCategory:(id)sender {
    
    if(self.categories.hidden == YES){
        NSLog(@"making invisible");
        self.categories.hidden = NO;
    }else{
        NSLog(@"making visible");
        self.categories.hidden = YES;
    }
}
- (IBAction)upLoadImage:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    
    UIAlertController * view=   [UIAlertController alertControllerWithTitle:@"Select you Choice" message:@""
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             NSLog(@"Clicked camera option");
                             picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                             [self presentViewController:picker animated:YES completion:NULL];
                             
                         }];
    
    UIAlertAction* gallery = [UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 NSLog(@"Clicked gallery option");
                                 picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                 [self presentViewController:picker animated:YES completion:NULL];
//                                 [self dismissViewControllerAnimated:YES completion:^{
//                                    //nothing
//                                 }];
                                 
                             }];
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action)
                             {
                                 NSLog(@"Clicked camera option");
                                [self dismissViewControllerAnimated:YES completion:^{
                                                                     //nothing
                                }];
                             }];
    
    
    [view addAction:camera];
    [view addAction:gallery];
    [view addAction:cancel];
    
    [self presentViewController:view animated:YES completion:nil];
    NSLog(@"leaving upLoadImage");
    
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//    }
//    else
//    {
//        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    }
//    
//    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    

}

- (IBAction)submitIncident:(id)sender {
    
    NSLog(@"selected image is %@", _selectedImage);
    //UIImage *img = [UIImage imageNamed:@"ps.png"];;
    
    if(_selectedImage == nil){
        [Utils displayAlert:@"Ooops!!!" displayText:@"Please select a image to upload!!"];
        return;
    }
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"image.png"];
    NSData *imageData = UIImagePNGRepresentation(_selectedImage);
    [imageData writeToFile:path atomically:YES];
    
    AWSS3TransferManager *transferManager = [AWSS3TransferManager defaultS3TransferManager];
    AWSS3TransferManagerUploadRequest *uploadRequest = [AWSS3TransferManagerUploadRequest new];
    uploadRequest.bucket = @"bonthapadu1";
    
    NSString* currentTime = [[[NSString stringWithFormat:@"%@",[Utils getCurrentTime]]
                           stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@":"]] stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    uploadRequest.key = [currentTime stringByAppendingString:@".png"];
    
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"abids" ofType:@"txt"];
    NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
    uploadRequest.body = url;
    
    [[transferManager upload:uploadRequest] continueWithExecutor:[AWSExecutor mainThreadExecutor]
                                                       withBlock:^id(AWSTask *task) {
                                                           if (task.error) {
                                                               if ([task.error.domain isEqualToString:AWSS3TransferManagerErrorDomain]) {
                                                                   switch (task.error.code) {
                                                                       case AWSS3TransferManagerErrorCancelled:
                                                                       case AWSS3TransferManagerErrorPaused:
                                                                           break;
                                                                           
                                                                       default:
                                                                           [Utils displayAlert:@"Ooops!!!" displayText:task.error.localizedDescription];
                                                                           NSLog(@"known Error: %@", task.error.description);
                                                                           break;
                                                                   }
                                                               } else {
                                                                   // Unknown error.
                                                                   [Utils displayAlert:@"Ooops!!!" displayText:task.error.localizedDescription];
                                                                   NSLog(@"unknown Error: %@", task.error.localizedDescription);
                                                               }
                                                           }
                                                           
                                                           if (task.result) {
                                                               
                                                               AWSS3TransferManagerUploadOutput *uploadOutput = task.result;
                                                               NSLog(@"Submitted successfully!! %@", _selectedImage.debugDescription);
                                                               [Utils displayAlert:@"Image Upload success" displayText:@"Congratulations!!"];
//                                                               [self.navigationController popToRootViewControllerAnimated:YES];
                                                               [self dismissViewControllerAnimated:YES completion:^{
                                                                   //nothing
                                                               }];
                                                               // The file uploaded successfully.
                                                               _selectedImage = nil;
                                                           }
                                                           return nil;
                                                       }];
    
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    _selectedImage= [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    NSLog(@"uploaded image name is %@", _selectedImage);
    //[Utils displayAlert:@"Image Upload success" displayText:@"Congratulations!!"];
    //[self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}



- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    self.view.frame =CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y-60), self.view.frame.size.width, self.view.frame.size.height);
//    self.selectedCategory.hidden = YES;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    //[UIView setAnimationDuration:1.0];
    [UIView setAnimationBeginsFromCurrentState:YES];
    //textView.frame = CGRectMake(textView.frame.origin.x, (70), textView.frame.size.width, textView.frame.size.height);
    [UIView commitAnimations];
    
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    self.view.frame =CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y+60), self.view.frame.size.width, self.view.frame.size.height);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    //[UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    //textView.frame = CGRectMake(textView.frame.origin.x, (334), textView.frame.size.width, textView.frame.size.height);
    [UIView commitAnimations];
//    self.selectedCategory.hidden = NO;
    
}

@end
