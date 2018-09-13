//
//  TrainingDetailViewController.h
//  CityToSurf
//
//  Created by Mubasher on 22/04/2015.
//  Copyright (c) 2015 Connect Techno. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface TrainingDetailViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate>{
    AppDelegate *delegate;
    
    IBOutlet UILabel *lblDistance;
    IBOutlet UILabel *lblElapsedTime;
    IBOutlet UILabel *lblStartTime;
    IBOutlet UILabel *lblAltitude;
    IBOutlet UILabel *lblAvgSpeed;
    IBOutlet UILabel *lblMaxSpeed;
    IBOutlet UILabel *lblDistUnit;
    IBOutlet UIView *mapViewContionar;
    IBOutlet UIView *mapView;
    
    
    /************* Shared View *****************/
    
    IBOutlet UIView *contionarImgView;
    IBOutlet UIImageView *sharedMapView;
    
    IBOutlet UILabel *lblSharedSpeed;
    IBOutlet UILabel *lblSharedSpeedUnit;
    IBOutlet UILabel *lblSharedDistUnit;
    IBOutlet UILabel *lblSharedDistance;
    IBOutlet UILabel *lblSharedElapsedTime;
    IBOutlet UILabel *lblSharedStartTime;
    IBOutlet UILabel *lblSharedAvgSpeed;
    IBOutlet UILabel *lblSharedAltitude;
    IBOutlet UILabel *lblSharedMaxSpeed;
    
    /************* End Shared view ******************/
    
    
    /************** Map View ************************/
    
    IBOutlet UILabel *lblMapViewAvgSpeed;
    IBOutlet UILabel *lblMapViewAvgSpeedUnit;
    IBOutlet UILabel *lblMapViewStartTime;
    IBOutlet UILabel *lblMapViewDistance;
    
    /************** End Map View *********************/
    
    Result *data;
}

@end
