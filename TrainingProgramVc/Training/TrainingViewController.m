//
//  TrainingViewController.m
//  CityToSurf
//
//  Created by Mubasher on 21/04/2015.
//  Copyright (c) 2015 Connect Techno. All rights reserved.
//

#import "TrainingViewController.h"
#import "TrainingDetailViewController.h"
#import "Result.h"

@interface TrainingViewController (){
    GMSMapView *mapViewGoogle;
}

@end

@implementation TrainingViewController;
@synthesize locationManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [contionarScrollview addSubview:trainingView];
    
    
    [self getLocation];
    distaneCovered=0.0;
    totalSpeed=0.0;
    maxSpeed=0.0;
    lblSignalLabel.hidden=YES;
    startBtnClick=FALSE;
    storeData=[[Result alloc]init];
    isArrowBlink=NO;
    
    [mapView setFrame:CGRectMake(0, 570, 320, 568)];
    [self.view addSubview:mapView];
    
    distInKm=TRUE;
    speedKph=TRUE;
    
    popUpSpeedKph=TRUE;
    popUpDistKm=TRUE;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)homeMoveBtn:(UIButton*)sender{
    [delegate.navViewController popViewControllerAnimated:YES];
}

-(IBAction)trainingBtnAction:(id)sender{
    btnSetting.hidden=FALSE;
    lblMapBtnText.hidden=FALSE;
    
    [sender setImage:[UIImage imageNamed:@"onTrainingBg.png"] forState:UIControlStateNormal];
    [resultBtn setImage:[UIImage imageNamed:@"offResultBg.png"] forState:UIControlStateNormal];
    
    [lbltraining setTextColor:[UIColor whiteColor]];
    [lblResult setTextColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"onTrainingBg.png"]]];
    
    [contionarScrollview setContentOffset:CGPointMake(0, 0)];
    [self fillTrainingData];
    
    contionarScrollview.scrollEnabled=FALSE;
}
-(IBAction)resultBtnAction:(id)sender{
    practiceModeView.hidden=TRUE;
    resultMapModeView.hidden=FALSE;
    lblMapBtnText.hidden=TRUE;
    
    btnSetting.hidden=TRUE;
    [sender setImage:[UIImage imageNamed:@"onResultBg.png"] forState:UIControlStateNormal];
    [trainingBtn setImage:[UIImage imageNamed:@"offTrainingBg.png"] forState:UIControlStateNormal];
    
    [lblResult setTextColor:[UIColor whiteColor]];
    [lbltraining setTextColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"onTrainingBg.png"]]];
    
    [self fillResultData];
    
    contionarScrollview.scrollEnabled=TRUE;
}
#pragma mark -
#pragma mark Fill Result Data

-(void)fillResultData{
    [self GetStoreData];
    
    for (UIView *view in contionarScrollview.subviews)
        [view removeFromSuperview];
    
    float yAxis=0.0;
    for (int i=0; i<resultData.count; i++) {
        Result *data=[resultData objectAtIndex:i];
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(7, yAxis, 306, 190)];
        
        UIImageView *viewBorder=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 306, 190)];
        [viewBorder setImage:[UIImage imageNamed:@"resultViewBorder.png"]];
        
        /****************** UILabels ****************************/
        
        UILabel *lblMaxSpeedResult=[[UILabel alloc]initWithFrame:CGRectMake(9, 10, 120, 20)];
        [lblMaxSpeedResult setBackgroundColor:[UIColor clearColor]];
        [lblMaxSpeedResult setTextColor:[UIColor blackColor]];
        [lblMaxSpeedResult setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
        [lblMaxSpeedResult setText:@"Max. Speed"];
        
        UILabel *lblDistance=[[UILabel alloc]initWithFrame:CGRectMake(9, 44, 120, 20)];
        [lblDistance setBackgroundColor:[UIColor clearColor]];
        [lblDistance setTextColor:[UIColor blackColor]];
        [lblDistance setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
        [lblDistance setText:@"Distance Covered"];
        
        UILabel *lblTime=[[UILabel alloc]initWithFrame:CGRectMake(9, 80, 120, 20)];
        [lblTime setBackgroundColor:[UIColor clearColor]];
        [lblTime setTextColor:[UIColor blackColor]];
        [lblTime setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
        [lblTime setText:@"Time Elapsed"];
        
        UILabel *lblDate=[[UILabel alloc]initWithFrame:CGRectMake(9, 115, 120, 20)];
        [lblDate setBackgroundColor:[UIColor clearColor]];
        [lblDate setTextColor:[UIColor blackColor]];
        [lblDate setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
        [lblDate setText:@"Date"];
        
        /*************** End UILabels **************************/
        
        /*************** UILabels For Values ******************/
        
        UILabel *lblMaxSpeedValue=[[UILabel alloc]initWithFrame:CGRectMake(165, 10, 80, 20)];
        [lblMaxSpeedValue setBackgroundColor:[UIColor clearColor]];
        [lblMaxSpeedValue setTextColor:[UIColor blackColor]];
        [lblMaxSpeedValue setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
        [lblMaxSpeedValue setTextAlignment:NSTextAlignmentLeft];
        if ([data.speed rangeOfString:@"Kph"].location == NSNotFound)
            [lblMaxSpeedValue setText:[NSString stringWithFormat:@"%@%@",data.maxSpeed,@"Mph"]];
        else
            [lblMaxSpeedValue setText:[NSString stringWithFormat:@"%@%@",data.maxSpeed,@"Kph"]];
    
        UILabel *lblDistanceValue=[[UILabel alloc]initWithFrame:CGRectMake(165, 44, 80, 20)];
        [lblDistanceValue setBackgroundColor:[UIColor clearColor]];
        [lblDistanceValue setTextColor:[UIColor blackColor]];
        [lblDistanceValue setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
        [lblDistanceValue setTextAlignment:NSTextAlignmentLeft];
        [lblDistanceValue setText:data.distCovered];
        
        UILabel *lblTimeValue=[[UILabel alloc]initWithFrame:CGRectMake(165, 80, 80, 20)];
        [lblTimeValue setBackgroundColor:[UIColor clearColor]];
        [lblTimeValue setTextColor:[UIColor blackColor]];
        [lblTimeValue setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
        [lblTimeValue setTextAlignment:NSTextAlignmentLeft];
        [lblTimeValue setText:data.elapsedTime];
        
        UILabel *lblDateValue=[[UILabel alloc]initWithFrame:CGRectMake(165, 115, 90, 20)];
        [lblDateValue setBackgroundColor:[UIColor clearColor]];
        [lblDateValue setTextColor:[UIColor blackColor]];
        [lblDateValue setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
        [lblDateValue setTextAlignment:NSTextAlignmentLeft];
        [lblDateValue setText:data.dateCalc];
        
        /*************** UILabels For Values ******************/
        
        [view addSubview:viewBorder];
        
        [view addSubview:lblMaxSpeedResult];
        [view addSubview:lblDistance];
        [view addSubview:lblTime];
        [view addSubview:lblDate];
        
        [view addSubview:lblMaxSpeedValue];
        [view addSubview:lblDistanceValue];
        [view addSubview:lblTimeValue];
        [view addSubview:lblDateValue];
        
        UIButton *btndelete=[[UIButton alloc]initWithFrame:CGRectMake(32, 157, 30, 30)];
        [btndelete setImage:[UIImage imageNamed:@"resultDelete.png"] forState:UIControlStateNormal];
        [btndelete setTag:i+500];
        [btndelete addTarget:self action:@selector(deleteRecoed:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btnMap=[[UIButton alloc]initWithFrame:CGRectMake(126, 157, 30, 30)];
        [btnMap setImage:[UIImage imageNamed:@"resultMap.png"] forState:UIControlStateNormal];
        [btnMap setTag:i+600];
        [btnMap addTarget:self action:@selector(showStoreResultMap:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *btnShare=[[UIButton alloc]initWithFrame:CGRectMake(222, 157, 30, 30)];
        [btnShare setImage:[UIImage imageNamed:@"resultShare"] forState:UIControlStateNormal];
        [btnShare setTag:i+255];
        [btnShare addTarget:self action:@selector(sharedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *detailBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 306, 160)];
        [detailBtn setTag:i+250];
        [detailBtn addTarget:self action:@selector(trainingDetailMoveBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [view addSubview:detailBtn];
        [view addSubview:btndelete];
        [view addSubview:btnMap];
        [view addSubview:btnShare];
        
        [contionarScrollview addSubview:view];
        yAxis+=204;
    }
    [contionarScrollview setContentSize:CGSizeMake(contionarScrollview.frame.size.width, yAxis)];
}
#pragma mark -
#pragma mark getStoreData
-(void)GetStoreData{
    
    resultData=[[NSMutableArray alloc] init];
    
    NSString  *storeResult=@"select * from TrackResult";
    sqlite3_stmt *ReturnStatement = (sqlite3_stmt *) [sqlFunction getStatement:storeResult];
    {
        while(sqlite3_step(ReturnStatement) == SQLITE_ROW)
        {
            storePointsValue=[[NSMutableArray alloc]init];
            void(^getMapPoint)(NSString *)=^(NSString *value){
                NSArray *latlongArray =[value componentsSeparatedByString:@"|"];
                storePointsValue=[[NSMutableArray alloc]initWithArray:latlongArray];
            };
            
            NSString *trackResultid = ((char *)sqlite3_column_text(ReturnStatement, 0)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(ReturnStatement, 0)] : @"";
            NSString *startTimeValue = ((char *)sqlite3_column_text(ReturnStatement, 1)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(ReturnStatement, 1)] : @"";
            NSString *elapsedTimeValue = ((char *)sqlite3_column_text(ReturnStatement, 2)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(ReturnStatement, 2)] : @"";
            NSString *altitudeValue = ((char *)sqlite3_column_text(ReturnStatement, 3)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(ReturnStatement, 3)] : @"";
            NSString *distCoveredValue = ((char *)sqlite3_column_text(ReturnStatement, 4)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(ReturnStatement, 4)] : @"" ;
            NSString *speedValue=((char *)sqlite3_column_text(ReturnStatement, 5)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(ReturnStatement, 5)]:@"";
            NSString *avgSpeedValue=((char *)sqlite3_column_text(ReturnStatement, 6)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(ReturnStatement, 6)]:@"";
            NSString *maxSpeedValue=((char *)sqlite3_column_text(ReturnStatement, 7)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(ReturnStatement, 7)]:@"";
            NSString *dateCalcValue=((char *)sqlite3_column_text(ReturnStatement, 8)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(ReturnStatement, 8)]:@"";
            NSString *googlePathPointsValue=((char *)sqlite3_column_text(ReturnStatement, 9)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(ReturnStatement, 9)]:@"";
            NSString *imgPathValue=((char *)sqlite3_column_text(ReturnStatement, 10)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(ReturnStatement, 10)]:@"";
            getMapPoint(googlePathPointsValue);
            
            storeData=[[Result alloc] init];
            storeData.trackResultid=trackResultid;
            storeData.startTime=startTimeValue;
            storeData.elapsedTime=elapsedTimeValue;
            storeData.altitude=altitudeValue;
            storeData.distCovered=distCoveredValue;
            storeData.speed=speedValue;
            storeData.avgSpeed=avgSpeedValue;
            storeData.maxSpeed=maxSpeedValue;
            storeData.dateCalc=dateCalcValue;
            storeData.googlePathPoints=storePointsValue;
            storeData.imgPath=imgPathValue;
            
            [resultData addObject:storeData];
            
            
        }
    }
}

#pragma mark -
#pragma mark Show Store Data Map
-(IBAction)showStoreResultMap:(id)sender{
    storeData=[resultData objectAtIndex:([sender tag]-600)];
    
    
    lblResultMapModeSpeed.text=storeData.avgSpeed;
    if ([storeData.speed rangeOfString:@"Kph"].location == NSNotFound)
        lblResultMapModeSpeedUnit.text=@"Mph";
    lblResultMapModeElapsedTime.text=storeData.elapsedTime;
    lblResultMapModeDistance.text=storeData.distCovered;
    
    [delegate jumpAnimationForViewToggle:mapView toPoint:CGPointMake(160, 284)];

    NSArray *latlongArray =[[storeData.googlePathPoints objectAtIndex:0]componentsSeparatedByString:@","];
    
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[[latlongArray objectAtIndex:0] doubleValue] longitude:[[latlongArray objectAtIndex:1] doubleValue] zoom:16];
    [mapViewGoogle setMinZoom:10 maxZoom:16];
    mapViewGoogle = [GMSMapView mapWithFrame:mapViewContionar.bounds camera:camera];
    
    GMSMutablePath *path=[[GMSMutablePath alloc]init];
    
    if (storeData.googlePathPoints.count>1){
        for (int i=1; i<storeData.googlePathPoints.count; i++)
        {
            // NSArray *latlongArray = [[self.points   objectAtIndex:i]componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
            NSArray *latlongArray =[[storeData.googlePathPoints objectAtIndex:i]componentsSeparatedByString:@","];
            [path addLatitude:[[latlongArray objectAtIndex:0] doubleValue] longitude:[[latlongArray objectAtIndex:1] doubleValue]];
        }
        GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
        polyline.strokeColor = [UIColor colorWithRed:66.0/255.0 green:171.0/255.0 blue:252.0/255.0 alpha:1.0];
        polyline.strokeWidth = 3.f;
        polyline.map = mapViewGoogle;
        [mapViewContionar addSubview:mapViewGoogle];
    }
}

#pragma mark -
#pragma mark Delete Record
-(IBAction)deleteRecoed:(UIButton *)sender{
    
    deleteRecord=([sender tag]-500);
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Are you sure you want to delete this record?" delegate:self cancelButtonTitle:@"No" destructiveButtonTitle:nil otherButtonTitles:@"Yes" ,  nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:delegate.window];
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0){
        Result *deleteSpecificData=[resultData objectAtIndex:deleteRecord];
        NSString *queryString=[NSString stringWithFormat:@"delete from TrackResult where TrackResultid == '%@';",deleteSpecificData.trackResultid];
        BOOL success=[sqlFunction InsUpdateDelData:queryString];
        if (success) {
            NSLog(@"Operation Perform Succesfully!");
        }
        [self fillResultData];
    }
    else
        actionSheet.hidden=YES;
    
}
#pragma mark -
#pragma mark Fill Training Data
-(void)fillTrainingData{
    
    for (UIView *view in contionarScrollview.subviews)
        [view removeFromSuperview];
    
    [contionarScrollview addSubview:trainingView];
    
}
#pragma mark -
#pragma mark Shared Data
-(IBAction)sharedBtnAction:(id)sender{
    data=[resultData objectAtIndex:([sender tag]-255)];
    
    
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
    
    NSString *userNameProfile;
    NSString  *storeResult=@"select * from ProfileData";
    sqlite3_stmt *ReturnStatement = (sqlite3_stmt *) [sqlFunction getStatement:storeResult];
    {
        while(sqlite3_step(ReturnStatement) == SQLITE_ROW)
        {
            userNameProfile = ((char *)sqlite3_column_text(ReturnStatement, 1)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(ReturnStatement, 1)] : @"";
        }
    }
    
    NSString *message =[NSString stringWithFormat:@"%@ has been training for CitytoSurf. #myCitytoSurf - %@",userNameProfile,@"http://perth.perthcitytosurf.com/"];
    [delegate sendFbPost:message sharedPicture:fullImgCopied];
    
}
#pragma mark -
#pragma mark Training Detail Move
-(IBAction)trainingDetailMoveBtnAction:(UIButton *)sender{
    delegate.detailResultData=[resultData objectAtIndex:([sender tag]-250)];
    [delegate.navViewController pushViewController:[[TrainingDetailViewController alloc] initWithNibName:@"TrainingDetailViewController" bundle:[NSBundle mainBundle]] animated:YES];
}

#pragma mark -
#pragma mark Timer Btn Action
-(IBAction)starterBtnClick:(UIButton *)sender{
    if (!startBtnClick) {
        [locationManager startUpdatingLocation];
        [btnStart setImage:[UIImage imageNamed:@"stopBtn.png"] forState:UIControlStateNormal];
        [lblBtnText setText:@"Stop"];
        [lblMapBtnText setText:@"Stop"];
        
        self.startTime=[NSDate date];
        self.points=[[NSMutableArray alloc]init];
        self.speedValues=[[NSMutableArray alloc]init];
        
        /************** Start Time ***************/
        NSDateFormatter *formate=[[NSDateFormatter alloc] init];
        formate.dateFormat=@"hh:mm:ss";
        [formate setTimeZone:[NSTimeZone systemTimeZone]];
        lblStartTime.text=[formate stringFromDate:self.startTime];
        
        
        /************ Elapsed Time ****************/
        self.RecordTimer=[NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(timerTick) userInfo:nil repeats:YES];
        self.arrowBlinkTimer=[NSTimer scheduledTimerWithTimeInterval:0.7 target:self selector:@selector(arrowBlink) userInfo:nil repeats:YES];
        
        startBtnClick=TRUE;
        
        zoomValue=16;
        zoomDistCompare=400.0;
        
    } else {
        [locationManager stopUpdatingLocation];
        [btnStart setImage:[UIImage imageNamed:@"trainingStartBtn.png"] forState:UIControlStateNormal];
        [lblBtnText setText:@"Start"];
        [lblMapBtnText setText:@"Start"];
        [self.RecordTimer invalidate];
        [self.arrowBlinkTimer invalidate];
        startBtnClick=FALSE;
        
        self.saveAlertView=[[UIAlertView alloc]initWithTitle:@"Would you like to save Track details?" message:nil delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        [self.saveAlertView show];
        
        storeData.startTime=lblStartTime.text;
        storeData.elapsedTime=lblElapsedTime.text;
        storeData.altitude=lblAltitude.text;
        storeData.distCovered=[NSString stringWithFormat:@"%@%@",lblDistanceCovered.text,lblTrainingDistUnit.text];
        storeData.speed=[NSString stringWithFormat:@"%@%@",lblSpeed.text,lblTrainingSpeedUnit.text];
        storeData.avgSpeed=lblAvgSpeed.text;
        storeData.maxSpeed=lblMaxSpeed.text;
        mapArrow.image=[UIImage imageNamed:@"locIndicator.png"];
        
    }
    
}
-(void)arrowBlink
{
    if(isArrowBlink==NO)
    {
        isArrowBlink=YES;
        
        UIColor *color = [UIColor greenColor];
        mapArrow.layer.shadowColor = [color CGColor];
        mapArrow.layer.shadowRadius = 4.0f;
        mapArrow.layer.shadowOpacity = .9;
        mapArrow.layer.shadowOffset = CGSizeZero;
        mapArrow.layer.masksToBounds = NO;
        mapArrow.image=[UIImage imageNamed:@"locIndicator.png"];
        
    }
    else
    {
        isArrowBlink=NO;
        
        UIColor *color = [UIColor grayColor];
        mapArrow.layer.shadowColor = [color CGColor];
        mapArrow.layer.shadowRadius = 4.0f;
        mapArrow.layer.shadowOpacity = .9;
        mapArrow.layer.shadowOffset = CGSizeZero;
        mapArrow.layer.masksToBounds = NO;
        mapArrow.image=[UIImage imageNamed:@"locIndicatorGreen.png"];
        
    }
    
}

-(void)timerTick{
    NSTimeInterval timeInterval = fabs([self.startTime timeIntervalSinceNow]);
    int duration = (int)timeInterval;
    int milisec=( (int)(floor( fabs( timeInterval ) * 100 ) ) ) % 100;
    int minutes = duration / 60;
    int seconds = duration % 60;
    NSString *elapsedTime = [NSString stringWithFormat:@"%02d:%02d:%02d",minutes,seconds,milisec];
    lblElapsedTime.adjustsFontSizeToFitWidth=YES;
    lblMapElapsedTime.adjustsFontSizeToFitWidth=YES;
    lblMapElapsedTime.adjustsFontSizeToFitWidth=YES;
    lblElapsedTime.text=elapsedTime;
    lblMapElapsedTime.text=elapsedTime;
}
-(void)getLocation{
    
    
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBestForNavigation];
    
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
        NSLog(@"yes");
    }
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    self.firstLocation=location;
    CLLocationCoordinate2D myLocation = [location coordinate];
    NSString *pointString=[NSString stringWithFormat:@"%f,%f",myLocation.latitude,myLocation.longitude];
    [self.points addObject:pointString];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:myLocation.latitude longitude:myLocation.longitude zoom:17];
    [mapViewGoogle setMinZoom:10 maxZoom:17];
    mapViewGoogle = [GMSMapView mapWithFrame:mapViewContionar.bounds camera:camera];
    [mapViewContionar addSubview:mapViewGoogle];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    if (startBtnClick) {
        
        NSString *pointString=[NSString stringWithFormat:@"%f,%f",newLocation.coordinate.latitude,newLocation.coordinate.longitude];
        [self.points addObject:pointString];
        
        
        float zoomDist=[self.firstLocation distanceFromLocation:newLocation];
        if (zoomDist>zoomDistCompare)
            zoomDistCompare=zoomDist;
        
        if (zoomDistCompare>500)
            zoomValue=15;
        else if (zoomDistCompare>1200)
            zoomValue=14;
        else if (zoomDistCompare>3000)
            zoomValue=13;
        
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude zoom:zoomValue];
        mapViewGoogle.camera=camera;
        GMSMutablePath *path=[GMSMutablePath path];
        for (int i=0; i<self.points.count; i++)
        {
            NSArray *latlongArray =[[self.points objectAtIndex:i]componentsSeparatedByString:@","];
           [path addLatitude:[[latlongArray objectAtIndex:0] doubleValue] longitude:[[latlongArray objectAtIndex:1] doubleValue]];
        }
        if (self.points.count>2)
        {
            GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
            polyline.strokeColor = [UIColor colorWithRed:66.0/255.0 green:171.0/255.0 blue:252.0/255.0 alpha:1.0];
            polyline.strokeWidth = 3.f;
            polyline.map = mapViewGoogle;
            [mapViewContionar addSubview:mapViewGoogle];
        }
        
        
        
        /******** LabelsValue ********/
        
        float altitude = newLocation.altitude;
        lblAltitude.text=[NSString stringWithFormat:@"%.2f",altitude];
        
        float meters = [oldLocation distanceFromLocation:newLocation];
        distaneCovered=distaneCovered+meters;
        if (distInKm)
            lblDistanceCovered.text=[NSString stringWithFormat:@"%.2f",(distaneCovered/1000)];
        else
            lblDistanceCovered.text=[NSString stringWithFormat:@"%.2f",distaneCovered];
        
        lblMapDistance.text=lblDistanceCovered.text;
        CLLocationAccuracy theAccuracy = newLocation.horizontalAccuracy;
        if (theAccuracy<55)
        {
            double speed = newLocation.speed;
            if (speed<0)
                speed=0.0;
            else{
                speed=speed*3.6;
                if (speed>11)
                    speed+=4;
                if (!speedKph)
                    speed=speed* 0.6213711916666667;

                lblSpeed.text=[NSString stringWithFormat:@"%.2f",speed];
                lblMapSpeed.text=[NSString stringWithFormat:@"%.2f",speed];
                lblSignalLabel.hidden=YES;
                [self.speedValues addObject:[NSString stringWithFormat:@"%f",speed]];
                
                totalSpeed=0.0;
                for (int i=0; i<self.speedValues.count; i++) {
                    totalSpeed+=[[self.speedValues objectAtIndex:i] floatValue];
                    
                    if (maxSpeed<[[self.speedValues objectAtIndex:i] floatValue])
                        maxSpeed=[[self.speedValues objectAtIndex:i] floatValue];
                }
                
                lblMaxSpeed.text=[NSString stringWithFormat:@"%.2f",maxSpeed];
                lblAvgSpeed.text=[NSString stringWithFormat:@"%.2f",(totalSpeed/self.speedValues.count)];
            }
        }
        else{
            //lblSignalLabel.hidden=NO;
        }

    } else {
       // <#statements#>
    }
    
}
- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered{
    
}
#pragma mark -
#pragma mark Save Data
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        [NSThread detachNewThreadSelector:@selector(storeData) toTarget:self withObject:nil];
    }
}
-(void)storeData{
    NSString *geoLocation;
    NSLog(@"%lu",(unsigned long)self.points.count);
    if (self.points.count<2) {
        UIAlertView *storeAlertView=[[UIAlertView alloc]initWithTitle:@"Empty data no need to store" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [storeAlertView show];
    }else{
        if (self.points.count>2) {
            geoLocation=[NSString stringWithFormat:@"%@|%@",[self.points objectAtIndex:0],[self.points objectAtIndex:0]];
            for (int i=1; i<self.points.count; i++)
                geoLocation=[NSString stringWithFormat:@"%@|%@",geoLocation,[self.points objectAtIndex:i]];
        } else
            geoLocation=Nil;
        NSDate *imgName=[NSDate date];
        NSString *fileName = [NSString stringWithFormat:@"%@.png",imgName];
        NSString *savedImagePath = [sqlFunction documentDirectoryFilePath:fileName];
        
        UIGraphicsBeginImageContextWithOptions(mapViewContionar.bounds.size, NO, 0);
        [mapViewContionar.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        UIImage *copied = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        UIImage *image = copied;
        NSData *imageData = UIImagePNGRepresentation(image);
        [imageData writeToFile:savedImagePath atomically:NO];
        
        NSString *queryString=[NSString stringWithFormat:@"insert into TrackResult(StartTime,ElapsedTime,Altitude,DistCovered,Speed,AvgSpeed,MaxSpeed,DateCalc,GooglePathPoints,ImgPath) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@');",storeData.startTime,storeData.elapsedTime,storeData.altitude,storeData.distCovered,storeData.speed,storeData.avgSpeed,storeData.maxSpeed,[self setFormatDate],geoLocation,fileName];
        BOOL success=[sqlFunction InsUpdateDelData:queryString];
        if (success) {
            NSLog(@"Operation Perform Succesfully!");
        }
    }
}
-(NSString *)setFormatDate{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger units = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
    NSDateComponents *components = [calendar components:units fromDate:self.startTime];
    NSInteger year = [components year];
    NSInteger month=[components month];       // if necessary
    NSInteger day = [components day];
    
    NSString *monthTime=[NSString stringWithFormat:@"%ld",(long)month];
    
    if([monthTime isEqualToString:@"1"])
    {
        monthTime=@"JAN";
    }
    else if([monthTime isEqualToString:@"2"])
    {
        monthTime=@"FEB";
    }
    else if([monthTime isEqualToString:@"3"])
    {
        monthTime=@"MAR";
    }
    else if([monthTime isEqualToString:@"4"])
    {
        monthTime=@"APR";
    }
    else if([monthTime isEqualToString:@"5"])
    {
        monthTime=@"MAY";
    }
    else if([monthTime isEqualToString:@"6"])
    {
        monthTime=@"JUNE";
    }
    else if([monthTime isEqualToString:@"7"])
    {
        monthTime=@"JULY";
    }
    else if([monthTime isEqualToString:@"8"])
    {
        monthTime=@"AUG";
    }
    else if([monthTime isEqualToString:@"9"])
    {
        monthTime=@"SEPT";
    }
    else if([monthTime isEqualToString:@"10"])
    {
        monthTime=@"OCT";
    }
    else if([monthTime isEqualToString:@"11"])
    {
        monthTime=@"NOV";
    }
    else if([monthTime isEqualToString:@"12"])
    {
        monthTime=@"DEC";
    }
    
    NSString *formatDate=[NSString stringWithFormat:@"%@ %ld,%ld",monthTime,(long)day,(long)year];
    
    return formatDate;
}

#pragma mak -
#pragma mark ReSet
-(IBAction)resetBtnAction:(UIButton *)sender{
    [btnStart setImage:[UIImage imageNamed:@"trainingStartBtn.png"] forState:UIControlStateNormal];
    [lblBtnText setText:@"Start"];
    [lblMapBtnText setText:@"Start"];
    [self.RecordTimer invalidate];
    startBtnClick=FALSE;
    distaneCovered=0.0;
    
    lblStartTime.text=@"00:00:00";
    lblElapsedTime.text=@"00:00:00";
    lblMapElapsedTime.text=@"00:00:00";
    lblAltitude.text=@"0.0";
    lblDistanceCovered.text=@"00";
    lblSpeed.text=@"00";
    lblMapSpeed.text=@"00";
    lblSignalLabel.hidden=YES;
    lblMaxSpeed.text=@"0.0";
    lblAvgSpeed.text=@"0.0";
    lblAltitude.text=@"0.0";
    
    self.points=[[NSMutableArray alloc]init];
    self.speedValues=[[NSMutableArray alloc]init];
    maxSpeed=0.0;
    
    NSString *pointString=[NSString stringWithFormat:@"%f,%f",locationManager.location.coordinate.latitude,locationManager.location.coordinate.longitude];
    [self.points addObject:pointString];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude zoom:17];
    mapViewGoogle = [GMSMapView mapWithFrame:mapViewContionar.bounds camera:camera];
    [mapViewContionar addSubview:mapViewGoogle];
}

#pragma mark -
#pragma mark Show Map View

-(IBAction)mapViewShow:(UIButton *)sender{
    [delegate jumpAnimationForViewToggle:mapView toPoint:CGPointMake(160, 284)];
    practiceModeView.hidden=FALSE;
    resultMapModeView.hidden=TRUE;
    lblMapSpeedUnit.text=lblTrainingSpeedUnit.text;
    lblMapDistanceUnit.text=lblTrainingDistUnit.text;
    
}
-(IBAction)mapViewDisAppear:(UIButton *)sender{
    [delegate jumpAnimationForViewToggle:mapView toPoint:CGPointMake(160, 854)];
    
    NSString *pointString=[NSString stringWithFormat:@"%f,%f",locationManager.location.coordinate.latitude,locationManager.location.coordinate.longitude];
    [self.points addObject:pointString];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude zoom:17];
    mapViewGoogle = [GMSMapView mapWithFrame:mapViewContionar.bounds camera:camera];
    [mapViewContionar addSubview:mapViewGoogle];
}

#pragma mark -
#pragma mark PopUp Btn Click
-(IBAction)popBtnClickAction:(UIButton *)sender{
    
    if ([lblTrainingSpeedUnit.text isEqualToString:@"Kph"]) {
        [btnSpeedUnChecked setImage:[UIImage imageNamed:@"uncheck_box.png"] forState:UIControlStateNormal];
        [btnSpeedChecked setImage:[UIImage imageNamed:@"check_box.png"] forState:UIControlStateNormal];
        popUpSpeedKph=TRUE;
    } else {
        [btnSpeedUnChecked setImage:[UIImage imageNamed:@"check_box.png"] forState:UIControlStateNormal];
        [btnSpeedChecked setImage:[UIImage imageNamed:@"uncheck_box.png"] forState:UIControlStateNormal];
        popUpSpeedKph=FALSE;
    }
    if ([lblTrainingDistUnit.text isEqualToString:@"Km"]) {
        [btnDistanceUnChecked setImage:[UIImage imageNamed:@"uncheck_box.png"] forState:UIControlStateNormal];
        [btnDistanceChecked setImage:[UIImage imageNamed:@"check_box.png"] forState:UIControlStateNormal];
        popUpDistKm=TRUE;
    } else {
        [btnDistanceChecked setImage:[UIImage imageNamed:@"uncheck_box.png"] forState:UIControlStateNormal];
        [btnDistanceUnChecked setImage:[UIImage imageNamed:@"check_box.png"] forState:UIControlStateNormal];
        popUpDistKm=FALSE;
    }
    
    cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    [cancelBtn setBackgroundColor:[UIColor clearColor]];
    [cancelBtn addTarget:self action:@selector(popUpCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:cancelBtn];
    [self.view addSubview:popUpView];
    
    [popUpView setCenter:CGPointMake(160, 284)];
}
-(IBAction)popUpCancelBtn:(id)sender{
    [cancelBtn removeFromSuperview];
    [popUpView removeFromSuperview];
    popUpDistKm=TRUE;
    popUpSpeedKph=TRUE;
}
-(IBAction)checkedBoxesBtnAction:(UIButton*)sender{
    switch ([sender tag]) {
        case 126:{
            [btnSpeedUnChecked setImage:[UIImage imageNamed:@"check_box.png"] forState:UIControlStateNormal];
            [btnSpeedChecked setImage:[UIImage imageNamed:@"uncheck_box.png"] forState:UIControlStateNormal];
            popUpSpeedKph=FALSE;
            
            break;
        }
        case 125:{
            [btnSpeedUnChecked setImage:[UIImage imageNamed:@"uncheck_box.png"] forState:UIControlStateNormal];
            [btnSpeedChecked setImage:[UIImage imageNamed:@"check_box.png"] forState:UIControlStateNormal];
            popUpSpeedKph=TRUE;
            
            break;
        }
        case 128:{
            [btnDistanceChecked setImage:[UIImage imageNamed:@"uncheck_box.png"] forState:UIControlStateNormal];
            [btnDistanceUnChecked setImage:[UIImage imageNamed:@"check_box.png"] forState:UIControlStateNormal];
            popUpDistKm=FALSE;
            
            break;
        }
        case 127:{
            [btnDistanceUnChecked setImage:[UIImage imageNamed:@"uncheck_box.png"] forState:UIControlStateNormal];
            [btnDistanceChecked setImage:[UIImage imageNamed:@"check_box.png"] forState:UIControlStateNormal];
            popUpDistKm=TRUE;
            
            break;
        }
        default:
            break;
    }

}
-(IBAction)popUpOkBtnClick:(UIButton*)sender{
    if (popUpSpeedKph) {
        speedKph=TRUE;
        lblTrainingSpeedUnit.text=@"Kph";
    } else {
        speedKph=FALSE;
        lblTrainingSpeedUnit.text=@"Mph";
    }
    if (popUpDistKm) {
        distInKm=TRUE;
        lblTrainingDistUnit.text=@"Km";
    } else {
        distInKm=FALSE;
        lblTrainingDistUnit.text=@"m";
    }
    [cancelBtn removeFromSuperview];
    [popUpView removeFromSuperview];
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
