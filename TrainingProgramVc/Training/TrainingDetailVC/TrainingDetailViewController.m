//
//  TrainingDetailViewController.m
//  CityToSurf
//
//  Created by Mubasher on 22/04/2015.
//  Copyright (c) 2015 Connect Techno. All rights reserved.
//

#import "TrainingDetailViewController.h"
#import "Result.h"

@interface TrainingDetailViewController ()

@end

@implementation TrainingDetailViewController{
    GMSMapView *mapViewGoogle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    delegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setLabelsValue];
    [mapView setFrame:CGRectMake(0, 570, 320, 568)];
    [self.view addSubview:mapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backMoveBtnAction:(UIButton *)sender{
    [delegate.navViewController popViewControllerAnimated:YES];
}
-(void)setLabelsValue{
    data=delegate.detailResultData;
    
    if ([data.distCovered rangeOfString:@"Km"].location == NSNotFound)
        lblDistUnit.text=@"m";
    
    lblDistance.text=[[data.distCovered stringByReplacingOccurrencesOfString:@"Km" withString:@""] stringByReplacingOccurrencesOfString:@"m" withString:@""];
    lblElapsedTime.text=data.elapsedTime;
    lblStartTime.text=data.startTime;
    lblAltitude.text=data.altitude;
    lblAvgSpeed.text=data.avgSpeed;
    lblMaxSpeed.text=data.maxSpeed;
    
}
-(IBAction)mapViewShow :(id)sender{
    if ([data.speed rangeOfString:@"Kph"].location == NSNotFound)
        lblMapViewAvgSpeedUnit.text=@"Mph";
    
    lblMapViewAvgSpeed.text=data.speed;
    lblMapViewStartTime.text=data.startTime;
    lblMapViewDistance.text=data.distCovered;
    
    [delegate jumpAnimationForViewToggle:mapView toPoint:CGPointMake(160, 284)];
    
    NSArray *latlongArray =[[data.googlePathPoints objectAtIndex:0]componentsSeparatedByString:@","];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[[latlongArray objectAtIndex:0] doubleValue] longitude:[[latlongArray objectAtIndex:1] doubleValue] zoom:17];
    mapViewGoogle = [GMSMapView mapWithFrame:mapViewContionar.bounds camera:camera];
    
    GMSMutablePath *path=[[GMSMutablePath alloc]init];
    for (int i=1; i<data.googlePathPoints.count; i++)
    {
        NSArray *latlongArray =[[data.googlePathPoints objectAtIndex:i]componentsSeparatedByString:@","];
        [path addLatitude:[[latlongArray objectAtIndex:0] doubleValue] longitude:[[latlongArray objectAtIndex:1] doubleValue]];
    }
    if (data.googlePathPoints.count>2)
    {
        GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
        polyline.strokeColor = [UIColor colorWithRed:66.0/255.0 green:171.0/255.0 blue:252.0/255.0 alpha:1.0];
        polyline.strokeWidth = 3.f;
        polyline.map = mapViewGoogle;
        [mapViewContionar addSubview:mapViewGoogle];
    }
}
-(IBAction)mapViewDisAppear:(UIButton *)sender{
    [delegate jumpAnimationForViewToggle:mapView toPoint:CGPointMake(160, 854)];
}
#pragma mark -
#pragma mark Shared Data
-(IBAction)sharedBtnAction:(id)sender{
    
    ///////// Google Map image /////////////////////
    
    NSString*(^getPathValue)(NSString *)=^(NSString *fileNameExist){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
        NSString *documentsDir = [paths objectAtIndex:0];
        return [documentsDir stringByAppendingPathComponent:fileNameExist];
    };
    
    
    NSString *fileName = [NSString stringWithFormat:@"%@",data.imgPath];
    NSString *imgPath = getPathValue(fileName);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = [fileManager fileExistsAtPath:imgPath];
    if (success) {
        UIImage *img = [UIImage imageWithContentsOfFile:imgPath];
        sharedMapView.contentMode=UIViewContentModeScaleAspectFit;
        sharedMapView.layer.cornerRadius=30;
        sharedMapView.image=img;
    }
    
    /////////End Google Map image /////////////////////
    
    if ([data.speed rangeOfString:@"Kph"].location == NSNotFound)
        lblSharedSpeedUnit.text=@"Mph";
    lblSharedSpeed.text=[[data.speed stringByReplacingOccurrencesOfString:@"Kph" withString:@""] stringByReplacingOccurrencesOfString:@"Mph" withString:@""];
    
    if ([data.distCovered rangeOfString:@"Km"].location == NSNotFound)
        lblSharedDistUnit.text=@"m";
    lblSharedDistance.text=[[data.distCovered stringByReplacingOccurrencesOfString:@"Km" withString:@""] stringByReplacingOccurrencesOfString:@"m" withString:@""];
    
    lblSharedElapsedTime.text=data.elapsedTime;
    lblSharedStartTime.text=data.startTime;
    lblSharedAvgSpeed.text=data.avgSpeed;
    lblSharedAltitude.text=data.altitude;
    lblSharedMaxSpeed.text=data.maxSpeed;
    
    UIGraphicsBeginImageContextWithOptions(contionarImgView.bounds.size, NO, 0);
    [contionarImgView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *fullImgCopied=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //[self.view addSubview:contionarImgView];
    
    NSString *message =[NSString stringWithFormat:@"Maximum Speed was %@ Km/h with CityToSurf",lblSharedMaxSpeed.text];
    [delegate sendFbPost:message sharedPicture:fullImgCopied];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
