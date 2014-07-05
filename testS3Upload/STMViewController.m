//
//  STMViewController.m
//  testS3Upload
//
//  Created by Maxim Grigoriev on 04/07/14.
//  Copyright (c) 2014 Sistemium UAB. All rights reserved.
//

#import "STMViewController.h"
#import "S3.h"


@interface STMViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *takePhotoButton;
@property (weak, nonatomic) IBOutlet UIButton *uploadPhotoButton;
@property (nonatomic, strong) NSData *photoData;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@end

@implementation STMViewController

- (IBAction)takePhotoButtonPressed:(id)sender {
    
    [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
    
}

- (IBAction)uploadPhotoButtonPressed:(id)sender {
    
    NSLog(@"uploadPhotoButtonPressed");

    AWSS3 *transferManager = [[AWSS3 alloc] initWithConfiguration:[AWSServiceManager defaultServiceManager].defaultServiceConfiguration];
    AWSS3PutObjectRequest *photo = [[AWSS3PutObjectRequest alloc] init];
    photo.bucket = @"gkgradus";
    photo.key = @"test.jpg";
    photo.contentType = @"image/jpeg";
    photo.body = self.photoData;
    photo.contentLength = [NSNumber numberWithInteger:self.photoData.length];
    
    [[transferManager putObject:photo] continueWithBlock:^id(BFTask *task) {
        
        if(task.error) {
            
            NSLog(@"Error: %@",task.error);
            
        } else {
            
            NSLog(@"Got here: %@", task.result);
            
        }
        
        return nil;
        
    }];
    
}

- (void)setPhotoData:(NSData *)photoData {
    
    if (photoData != _photoData) {
        
        if (photoData) {
            
            self.uploadPhotoButton.enabled = YES;
            
        }
        
        _photoData = photoData;
        
    }
    
}

- (UIImagePickerController *)imagePickerController {
    
    if (!_imagePickerController) {
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        _imagePickerController = imagePickerController;
        
    }
    
    return _imagePickerController;
    
}


- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)imageSourceType {
    
    if ([UIImagePickerController isSourceTypeAvailable:imageSourceType]) {
        
        [self presentViewController:self.imagePickerController animated:YES completion:^{
            
            
        }];
        
    }
    
}


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    //    NSLog(@"picker didFinishPickingMediaWithInfo");
    
    [picker dismissViewControllerAnimated:NO completion:^{
        
//        self.photoData = UIImagePNGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage]);
        self.photoData = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 0.0);
        self.imagePickerController = nil;
        //        NSLog(@"dismiss UIImagePickerController");
        
    }];
    
}

//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//
//    [picker dismissViewControllerAnimated:NO completion:^{
//
//        NSLog(@"imagePickerControllerDidCancel");
//
//    }];
//    
//}





- (void)customInit {
    
    if (!_photoData) {
        
        self.uploadPhotoButton.enabled = NO;
        
    }
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self customInit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
