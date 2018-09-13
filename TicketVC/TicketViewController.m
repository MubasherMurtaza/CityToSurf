//
//  TicketViewController.m
//  CityToSurf
//
//  Created by Mubasher on 22/04/2015.
//  Copyright (c) 2015 Connect Techno. All rights reserved.
//

#import "TicketViewController.h"
#import "sqlFunction.h"

@interface TicketViewController ()

@end

@implementation TicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    delegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (delegate.ticketImg!=Nil) {
        ticketImg.contentMode=UIViewContentModeScaleAspectFit;
        [ticketImg setImage:(UIImage *)delegate.ticketImg];
        addTicket.hidden=TRUE;
        btnCapture.userInteractionEnabled=FALSE;
        viewConvertBtn.userInteractionEnabled=YES;
    }
    //    }else
    //       [self setStoreImg];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)homeMoveBtn:(UIButton*)sender{
    [delegate.navViewController popViewControllerAnimated:YES];
}
-(IBAction)deleteBtnAction:(UIButton *)sender{
    ticketImg.contentMode=UIViewContentModeScaleAspectFit;
    [ticketImg setImage:[UIImage imageNamed:@"cameraImgBord.png"]];
    delegate.ticketImg=Nil;
    btnCapture.userInteractionEnabled=TRUE;
    addTicket.hidden=FALSE;
    viewConvertBtn.userInteractionEnabled=FALSE;
    
    NSString*(^getPathValue)(NSString *)=^(NSString *fileNameExist){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
        NSString *documentsDir = [paths objectAtIndex:0];
        return [documentsDir stringByAppendingPathComponent:fileNameExist];
    };
    NSString *fileName = [NSString stringWithFormat:@"%@.png",@"ticketImg"];
    NSString *imgPath = getPathValue(fileName);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = [fileManager fileExistsAtPath:imgPath];
    if (success)
        [[NSFileManager defaultManager] removeItemAtPath:imgPath error: nil];
}
-(IBAction)captureImgBtnAction:(UIButton *)sender{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo", @"Choose Existing",  nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:delegate.window];
    
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 || buttonIndex == 1)
    {
        [self imagePickingAction:(int)buttonIndex];
    }
    else
    {
        actionSheet.hidden = YES;
    }
}
#pragma Image/Photos
#pragma --------------
- (IBAction)imagePickingAction:(int)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if (sender==0)
    {
        imagePicker.sourceType = UIImagePickerControllerCameraDeviceFront;
    }
    else
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.allowsEditing = FALSE;
    
    imagePicker.delegate = self;
    [delegate.navViewController presentViewController:imagePicker animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (picker.sourceType == UIImagePickerControllerCameraDeviceFront)
        UIImageWriteToSavedPhotosAlbum([info objectForKey:@"UIImagePickerControllerOriginalImage"], nil, nil, nil);
    ticketImg.contentMode=UIViewContentModeScaleAspectFit;
    [ticketImg setImage:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
    
    delegate.ticketImg=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    
    NSString *fileName = [NSString stringWithFormat:@"%@.png",@"ticketImg"];
    NSString *savedImagePath = [sqlFunction documentDirectoryFilePath:fileName];
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:savedImagePath atomically:NO];
    
    
    addTicket.hidden=TRUE;
    btnCapture.userInteractionEnabled=FALSE;
    viewConvertBtn.userInteractionEnabled=TRUE;
    
    [delegate.navViewController dismissViewControllerAnimated:YES completion:nil];
    
}
//#pragma mark -
//#pragma mark Set Image
//
//-(void)setStoreImg{
//
//    NSString*(^getPathValue)(NSString *)=^(NSString *fileNameExist){
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
//        NSString *documentsDir = [paths objectAtIndex:0];
//        return [documentsDir stringByAppendingPathComponent:fileNameExist];
//    };
//
//
//    NSString *fileName = [NSString stringWithFormat:@"%@.png",@"ticketImg"];
//    NSString *imgPath = getPathValue(fileName);
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    BOOL success = [fileManager fileExistsAtPath:imgPath];
//    if (success) {
//        UIImage *img = [UIImage imageWithContentsOfFile:imgPath];
//        addTicket.hidden=TRUE;
//        btnCapture.userInteractionEnabled=FALSE;
//        viewConvertBtn.userInteractionEnabled=TRUE;
//        [imgView setImage:img];
//        delegate.ticketImg=(NSString *)imgView.image;
//
//    }
//
//
//}



#pragma mark -
#pragma mark FullView
-(IBAction)showFullView:(UIButton *)sender{
    [self.view addSubview:fullView];
    [fullImgView setImage:(UIImage *)delegate.ticketImg];
}
-(IBAction)cancellBtnAction:(UIButton *)sender{
    [fullView removeFromSuperview];
    
}

//
//-(IBAction)share:(id)sender{
//
//    NSString *message =@"SpeedoMetrics";
//
//
//    NSArray *arrayOfActivityItems = [NSArray arrayWithObjects:message, nil];
//
//    UIActivityViewController *ActivityView;
//    ActivityView =
//    [[UIActivityViewController alloc]
//     initWithActivityItems:arrayOfActivityItems applicationActivities:nil];
//
//    [self presentViewController:ActivityView animated:YES completion:^{
//    }];
//}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
/*
 NSString *imagePath = [MyCommonFunctions documentDirectoryFilePath:imgName];
 
 UIImage *img = [UIImage imageWithContentsOfFile:imagePath];
 
 [[NSFileManager defaultManager] removeItemAtPath:imagePath error: nil];
 
 */

@end
