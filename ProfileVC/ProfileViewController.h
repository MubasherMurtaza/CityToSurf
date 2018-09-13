//
//  ProfileViewController.h
//  CityToSurf
//
//  Created by Mubasher on 14/04/2015.
//  Copyright (c) 2015 Connect Techno. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ProfileViewController : UIViewController<UITextFieldDelegate>{
    AppDelegate *delegate;
    
    /************ Input Fields ****************/
    
    IBOutlet UITextField *txtName;
    IBOutlet UILabel *lblSelectedDate;
    IBOutlet UITextField *txtAgeValue;
    IBOutlet UILabel *lblAgeValue;
    IBOutlet UITextField *txtWeightValue;
    IBOutlet UITextField *txtHeightValue;
    IBOutlet UIScrollView *contionarScrollView;
    
    /*********** End Input Fields ***************/
    
    /*********** Date Picker view ***************/
    
    IBOutlet UIView *datePickerView;
    IBOutlet UIDatePicker *datePicker;
    
    /************ End Date picker View **************/
    
    
    /********* Drop Down Menu **********/
    IBOutlet UIView *dropDownView;
    NSMutableArray *dropDownData;
    IBOutlet UIScrollView *dropDownScrollView;
    BOOL showDropDown;
    IBOutlet UILabel *lblCountry;
    /********** End Drop down Menu *******/
}

@end
