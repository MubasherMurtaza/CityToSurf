//
//  HomeViewController.h
//  CityToSurf
//
//  Created by Mubasher on 13/04/2015.
//  Copyright (c) 2015 Connect Techno. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface HomeViewController : UIViewController{
    
    AppDelegate *delegate;
    int hide;
    float speed;
    
    /********** Animation View *********/
    
    IBOutlet UIView *profileView;
    IBOutlet UIView *trainingView;
    IBOutlet UIView *registerView;
    IBOutlet UIView *eventView;
    IBOutlet UIView *fundView;
    IBOutlet UIView *eventPartners;
    
    /*********** End Animation View ********/
    
    IBOutlet UIImageView *imgPlusSign;
    IBOutlet UILabel *lblRemainingDays;
    
}


@end
