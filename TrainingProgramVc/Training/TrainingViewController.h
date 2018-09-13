//
//  TrainingViewController.h
//  CityToSurf
//
//  Created by Mubasher on 21/04/2015.
//  Copyright (c) 2015 Connect Techno. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Result.h"
#import "sqlFunction.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface TrainingViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate>{
    AppDelegate *delegate;
    
    IBOutlet UIButton *trainingBtn;
    IBOutlet UIButton *resultBtn;
    IBOutlet UIButton *btnSetting;
    
    IBOutlet UILabel *lbltraining;
    IBOutlet UILabel *lblResult;

    
    IBOutlet UIScrollView *contionarScrollview;
    
    /************ Training View **************/
    
    BOOL startBtnClick;
    
    
    IBOutlet UIView *trainingView;
    IBOutlet UILabel *lblStartTime;
    IBOutlet UILabel *lblBtnText;
    IBOutlet UILabel *lblElapsedTime;
    IBOutlet UILabel *lblAltitude;
    IBOutlet UILabel *lblDistanceCovered;
    IBOutlet UILabel *lblSpeed;
    IBOutlet UILabel *lblSignalLabel;
    IBOutlet UILabel *lblMaxSpeed;
    IBOutlet UILabel *lblAvgSpeed;
    IBOutlet UILabel *lblTrainingSpeedUnit;
    IBOutlet UILabel *lblTrainingDistUnit;
    IBOutlet UIButton *btnStart;
    
    
    float distaneCovered;
    float totalSpeed;
    float maxSpeed;
    
    BOOL distInKm;
    BOOL speedKph;
    
    /*********** End Training View ***********/
    
    /************ Result View ****************/
    
    NSMutableArray *resultData;
    Result *storeData,*data;
    NSMutableArray *storePointsValue;
    float deleteRecord;
    
    /************* End Result View ***********/
    
    /************* Map View ****************/
    
    IBOutlet UIView *mapView;
    IBOutlet UIView *practiceModeView;
    IBOutlet UIView *mapViewContionar;
    IBOutlet UIImageView *mapArrow;
    BOOL isArrowBlink;
    IBOutlet UILabel *lblMapElapsedTime;
    IBOutlet UILabel *lblMapSpeed;
    IBOutlet UILabel *lblMapSpeedUnit;
    IBOutlet UILabel *lblMapDistance;
    IBOutlet UILabel *lblMapDistanceUnit;
    IBOutlet UILabel *lblMapBtnText;
    int zoomValue;
    float zoomDistCompare;
    
        /****** start Result View Mode ********/
    IBOutlet UIView *resultMapModeView;
    IBOutlet UILabel *lblResultMapModeSpeed;
    IBOutlet UILabel *lblResultMapModeSpeedUnit;
    IBOutlet UILabel *lblResultMapModeElapsedTime;
    IBOutlet UILabel *lblResultMapModeDistance;
    
       /****** End start Result View Mode ********/
    
    /*************End Map View ****************/
    
    
    /************* Shared View *****************/
    IBOutlet UIView *contionarImgView;
    IBOutlet UIImageView *sharedMapView;
    IBOutlet UIView *mapViewImg;
    IBOutlet UIView *mapViewImgContionar;
    
    IBOutlet UILabel *lblSharedSpeed;
    IBOutlet UILabel *lblSharedSpeedUnit;
    IBOutlet UILabel *lblSharedDistance;
    IBOutlet UILabel *lblSharedDistUnit;
    IBOutlet UILabel *lblSharedElapsedTime;
    IBOutlet UILabel *lblSharedStartTime;
    IBOutlet UILabel *lblSharedAvgSpeed;
    IBOutlet UILabel *lblSharedAltitude;
    IBOutlet UILabel *lblSharedMaxSpeed;
    
    /************* End Shared view ******************/
    
    
    /************* PopUp View ***********************/
    
    IBOutlet UIButton *cancelBtn;
    IBOutlet UIView *popUpView;
    
    IBOutlet UIButton *btnSpeedChecked;
    IBOutlet UIButton *btnSpeedUnChecked;
    IBOutlet UIButton *btnDistanceChecked;
    IBOutlet UIButton *btnDistanceUnChecked;
    float distForZoom;
    
    BOOL popUpSpeedKph;
    BOOL popUpDistKm;
    
    /************* End PopUp View *******************/
    
}

    /************ Training View **************/

@property(nonatomic,retain)NSDate *startTime;
@property(nonatomic,retain)NSTimer *RecordTimer,*arrowBlinkTimer;
@property(nonatomic,retain)CLLocationManager *locationManager;
@property(nonatomic, retain)NSMutableArray *speedValues;
@property(nonatomic, retain)UIAlertView *saveAlertView;


    /*********** End Training View ***********/


    /************* Map View ****************/

@property(nonatomic, retain) NSMutableArray *points;
@property(nonatomic, retain) CLLocation *firstLocation;

    /*************End Map View ****************/

@end
