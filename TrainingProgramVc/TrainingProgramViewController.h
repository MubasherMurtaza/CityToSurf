//
//  TrainingProgramViewController.h
//  CityToSurf
//
//  Created by Mubasher on 21/04/2015.
//  Copyright (c) 2015 Connect Techno. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <QuickLook/QuickLook.h>

@interface TrainingProgramViewController : UIViewController<QLPreviewControllerDelegate,QLPreviewControllerDataSource>{
    AppDelegate *delegate;
    IBOutlet UIScrollView *contionarScrollView;
    
    NSMutableArray *trainingScrollData;
    NSString *pdfFilePath;
    NSString *nameFile;
    
    /********* Drop Down Menu **********/
    IBOutlet UIView *dropDownView;
    NSMutableArray *dropDownData;
    IBOutlet UIScrollView *dropDownScrollView;
    BOOL showDropDown;
    IBOutlet UILabel *lblCountry;
    /********** End Drop down Menu *******/

}

@end
