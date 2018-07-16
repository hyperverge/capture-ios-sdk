//
//  OpenCVWrapper.h
//  GestureApp
//
//  Created by Srinija on 28/05/18.
//  Copyright © 2018 hyperverge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OpenCVWrapper : NSObject

- (UIImage *)processImageWithOpenCV:(UIImage*)inputImage :(int)newWidth : (int)newHeight;


@end
