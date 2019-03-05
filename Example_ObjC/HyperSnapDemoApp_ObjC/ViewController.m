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
    
    
        HVFaceConfig *faceConfig = [HVFaceConfig new];
        [faceConfig setLivenessMode:LivenessModeTextureLiveness];
    [faceConfig setShouldShowInstructionsPage:true];
    
        [HVFaceViewController start:self hvFaceConfig:faceConfig completionHandler:^(HVError* error,NSDictionary<NSString *,id> * _Nonnull result, NSDictionary<NSString *,NSString *> * _Nonnull headers,UIViewController* vcNew){
            if(error != nil){
                NSLog(@"Error Received: %@",  error.getErrorMessage);
            }else{
                NSLog(@"Results: %@", result);
            }
            [vcNew dismissViewControllerAnimated:true  completion:nil];
    
        }];
}


- (IBAction)documentCaptureTapped:(UIButton *)sender {
    HVDocConfig *docConfig = [HVDocConfig new];
    [docConfig setDocumentType:DocumentTypeCard];
    [docConfig setShouldShowReviewPage:true];
    [docConfig setShouldShowInstructionsPage:true];
    
    [HVDocsViewController start:self hvDocConfig:docConfig completionHandler:^(HVError* error,NSDictionary<NSString *,id> * _Nonnull result, UIViewController* vcNew){
        if(error != nil){
            NSLog(@"Error Received: %@",  error);
        }else{
            NSLog(@"Results: %@", result);
        }
        [vcNew dismissViewControllerAnimated:true  completion:nil];
        
    }];
}

@end
