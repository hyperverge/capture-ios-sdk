//
//  ViewController.m
//  HyperSnapDemoApp_ObjC
//
//  Created by Srinija on 12/07/18.
//  Copyright © 2018 hyperverge. All rights reserved.
//

#import "ViewController.h"
@import HyperSnapSDK;


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation ViewController


NSString* appId = @"";
NSString* appKey = @"";


- (void)viewDidLoad {
    [super viewDidLoad];
    //Initializes the SDK. Please set the 'appId' and 'appKey' provided by HyperVerge
    [HyperSnapSDK initializeWithAppId:appId appKey:appKey region:RegionAsiaPacific product:ProductFaceID];

}


- (IBAction)faceCaptureTapped:(UIButton *)sender {
    //Instantiate the ViewController
    NSBundle *bundle  = [NSBundle bundleForClass:[HyperSnapSDK self]];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:HyperSnapSDK.StoryBoardName bundle: bundle];
    __weak HVFaceViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"HVFaceViewController"];
    
    //Set ViewController properties (described later)
    [vc setLivenessMode:LivenessModeTextureLiveness];
    vc.completionHandler = ^(NSError* error,NSDictionary<NSString *,id> * _Nonnull result, UIViewController* newVC){
        if(error != nil){
            NSLog(@"Error Received: %@",  error);
            self->_resultLabel.text = error.localizedDescription;
        }else{
            NSLog(@"Results: %@", result);
            self->_resultLabel.text = result.debugDescription;
        }
        [newVC dismissViewControllerAnimated:true completion:nil];
    };
    
    //Present the ViewController
    [self presentViewController:vc animated:YES completion:nil];
}


- (IBAction)documentCaptureTapped:(UIButton *)sender {
    //Instantiate the ViewController
    NSBundle *bundle  = [NSBundle bundleForClass:[HyperSnapSDK self]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:HyperSnapSDK.StoryBoardName bundle: bundle];
    __weak HVDocsViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"HVDocsViewController"];
    
    //Set ViewController properties (described later)
    vc.document = [[Document alloc] initWithType:DocumentTypeCard];
    vc.topText = @"ID Card";
    vc.bottomText = @"Please place your document inside the box";
    vc.completionHandler = ^(NSError* error,NSDictionary<NSString *,id> * _Nonnull result){
        if(error != nil){
            NSLog(@"Error Received: %@",  error);
            self->_resultLabel.text = error.localizedDescription;
        }else{
            NSLog(@"Results: %@", result);
            self->_resultLabel.text = result.debugDescription;
        }
        [vc dismissViewControllerAnimated:true completion:nil];
    };
    
    //Present the ViewController
    [self presentViewController:vc animated:YES completion:nil];
}

@end
