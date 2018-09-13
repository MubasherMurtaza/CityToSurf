//
//  ProfileViewController.m
//  CityToSurf
//
//  Created by Mubasher on 14/04/2015.
//  Copyright (c) 2015 Connect Techno. All rights reserved.
//

#import "ProfileViewController.h"
#import "sqlFunction.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    [datePickerView setFrame:CGRectMake(0, 568, 320, 200)];
    [self.view addSubview:datePickerView];
    
    [contionarScrollView setContentSize:CGSizeMake(contionarScrollView.frame.size.width, 700)];
    contionarScrollView.scrollEnabled=FALSE;
    
    [dropDownView setFrame:CGRectMake(103, 266, 210, 190)];
    [self.view addSubview:dropDownView];
    showDropDown=FALSE;
    dropDownData=[[NSMutableArray alloc]initWithObjects:@"Karratha",@"Geraldton",@"Albany",@"Busselton",@"Perth", nil];
    [self fillDropDownMenu];
    
    if (delegate.countryLabel.length>1)
        lblCountry.text=delegate.countryLabel;
    
    [self getProfileData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)homeMoveBtn:(UIButton*)sender{
    [delegate.navViewController popViewControllerAnimated:YES];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self resignResponder];
    showDropDown=FALSE;
    dropDownView.hidden=TRUE;
    
}
-(IBAction)resignBtnaction:(UIButton *)sender{
    [self resignResponder];
}
-(void)resignResponder{
    [txtName resignFirstResponder];
    [txtAgeValue resignFirstResponder];
    [txtWeightValue resignFirstResponder];
    [txtHeightValue resignFirstResponder];
}
-(IBAction)showDatePicker:(id)sender{
    [self resignResponder];
    [delegate jumpAnimationForViewToggle:datePickerView toPoint:CGPointMake(160, 468)];
}
-(IBAction)disappearDataPicker:(id)sender{
    [delegate jumpAnimationForViewToggle:datePickerView toPoint:CGPointMake(160, 668)];
}
-(IBAction)pickerDoneBtnAction:(UIButton*)button
{
    [self resignResponder];
    [delegate jumpAnimationForViewToggle:datePickerView toPoint:CGPointMake(160, 668)];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    
    NSDate *pickedTime = [datePicker date];
    NSString *date = [dateFormatter stringFromDate:pickedTime];
    
    lblSelectedDate.text=date;
    
    NSTimeInterval ageInterval = [pickedTime timeIntervalSinceDate:[NSDate date]];
    NSInteger age = ABS(ageInterval / (60 * 60 * 24 * 365));
    lblAgeValue.text=[NSString stringWithFormat:@"%ld %@",(long)age,@"years"];
    NSLog(@"%@",lblAgeValue.text);
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    contionarScrollView.scrollEnabled=TRUE;
    
    showDropDown=FALSE;
    dropDownView.hidden=TRUE;
    
    if ([textField tag]==151) {
        [contionarScrollView setContentOffset:CGPointMake(0, 50)];
    } else if ([textField tag]==152) {
        [contionarScrollView setContentOffset:CGPointMake(0, 145)];
        
        NSString *formatV=[textField.text stringByReplacingOccurrencesOfString:@"Kg" withString:@""];
        textField.text=formatV;
        
    } else if ([textField tag]==153) {
        [contionarScrollView setContentOffset:CGPointMake(0, 210)];
        
        NSString *formatV=[textField.text stringByReplacingOccurrencesOfString:@"cm" withString:@""];
        textField.text=formatV;
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [contionarScrollView setContentOffset:CGPointMake(0, 0)];
    contionarScrollView.scrollEnabled=FALSE;
    
    if ([textField tag]==152) {
        NSString *formatV=[NSString stringWithFormat:@"%@%@",textField.text,@"Kg"];
        textField.text=formatV;
    } else if([textField tag]==153) {
        NSString *formatV=[NSString stringWithFormat:@"%@%@",textField.text,@"cm"];
        textField.text=formatV;
    }
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSLog(@"%lu",(unsigned long)textField.text.length);
    if (textField.tag==50) {
        if (textField.text.length==0) {
            NSLog(@"%lu",(unsigned long)textField.text.length);
            newString=[newString stringByReplacingOccurrencesOfString:@" " withString:@""];
            textField.text=[newString uppercaseString];
            return NO;
            
        }
    }
    textField.text=newString;
    
    return NO;
}
#pragma mark -
#pragma mark Drop Down menu
-(void)fillDropDownMenu{
    
    for (UIView *view in dropDownScrollView.subviews)
        [view removeFromSuperview];
    
    float yAxis=0.0;
    for (int i=0; i<dropDownData.count; i++) {
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, yAxis, 210, 38)];
        
        
        UILabel *lblData=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 200, 37)];
        [lblData setBackgroundColor:[UIColor clearColor]];
        [lblData setTextColor:[UIColor blackColor]];
        [lblData setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
        [lblData setText:[dropDownData objectAtIndex:i]];
        [lblData setAlpha:0.7];
        
        UIImageView *borderImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 37, 210, 0.5)];
        [borderImg setImage:[UIImage imageNamed:@"reg_line.png"]];
        
        
        UIButton *selectedButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 210, 38)];
        [selectedButton setTag:i+400];
        [selectedButton addTarget:self action:@selector(changeCountryLabel:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [view addSubview:lblData];
        if (i<(dropDownData.count-1))
        [view addSubview:borderImg];
        [view addSubview:selectedButton];
        
        [dropDownScrollView addSubview:view];
        yAxis+=38;
    }
    [dropDownScrollView setContentSize:CGSizeMake(dropDownScrollView.frame.size.width, yAxis)];
}
-(IBAction)changeCountryLabel:(UIButton*)sender{
    lblCountry.text=[dropDownData objectAtIndex:([sender tag]-400)];
    dropDownView.hidden=TRUE;
    showDropDown=FALSE;
    delegate.countryLabel=lblCountry.text;
}
-(IBAction)showDropDown:(UIButton *)sender{
    [self resignResponder];
    [delegate jumpAnimationForViewToggle:datePickerView toPoint:CGPointMake(160, 668)];
    if (showDropDown) {
        showDropDown=FALSE;
        dropDownView.hidden=TRUE;
    } else {
        showDropDown=TRUE;
        dropDownView.hidden=FALSE;
    }
}
#pragma mark -
#pragma mark Store Profile Data
-(IBAction)storeProfileData:(UIButton *)sender{
    
    if (txtName.text.length<1) {
        UIAlertView *mandatory=[[UIAlertView alloc]initWithTitle:@"Enter the name" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [mandatory show];
        return;
    }
    
    
    BOOL exist=[sqlFunction itemExistsInDatabase:@"ProfileData" FieldName:@"ProfileDataid" Value:@"1"];
    if (exist){
        NSString *queryString=[NSString stringWithFormat:@"update ProfileData Set UserName='%@',Location='%@',DateOfBirth='%@',Age='%@',Weight='%@',Height='%@' where ProfileDataid=1;",txtName.text,lblCountry.text,lblSelectedDate.text,lblAgeValue.text,txtWeightValue.text,txtHeightValue.text];
        BOOL success=[sqlFunction InsUpdateDelData:queryString];
        if (success) {
            NSLog(@"Operation Perform Succesfully!");
            
            UIAlertView *saveAlertView=[[UIAlertView alloc]initWithTitle:@"Profile data update successfully" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:Nil, nil];
            [saveAlertView show];
        }
    }else{
        NSString *queryString=[NSString stringWithFormat:@"insert into ProfileData (UserName,Location,DateOfBirth,Age,Weight,Height) values('%@','%@','%@','%@','%@','%@');",txtName.text,lblCountry.text,lblSelectedDate.text,lblAgeValue.text,txtWeightValue.text,txtHeightValue.text];
        BOOL success=[sqlFunction InsUpdateDelData:queryString];
        if (success) {
            NSLog(@"Operation Perform Succesfully!");
            
            UIAlertView *saveAlertView=[[UIAlertView alloc]initWithTitle:@"Profile data store successfully" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:Nil, nil];
            [saveAlertView show];
        }
    }
}
-(void)getProfileData{
    
    NSString  *storeResult=@"select * from ProfileData";
    sqlite3_stmt *ReturnStatement = (sqlite3_stmt *) [sqlFunction getStatement:storeResult];
    {
        while(sqlite3_step(ReturnStatement) == SQLITE_ROW)
        {
            NSString *userName = ((char *)sqlite3_column_text(ReturnStatement, 1)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(ReturnStatement, 1)] : @"";
            NSString *location=  ((char *)sqlite3_column_text(ReturnStatement, 2)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(ReturnStatement, 2)] : @"";
            NSString *dateOfBirth=  ((char *)sqlite3_column_text(ReturnStatement, 3)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(ReturnStatement, 3)] : @"";
            NSString *age=  ((char *)sqlite3_column_text(ReturnStatement, 4)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(ReturnStatement, 4)] : @"";
            NSString *weight=  ((char *)sqlite3_column_text(ReturnStatement, 5)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(ReturnStatement, 5)] : @"";
            NSString *height=  ((char *)sqlite3_column_text(ReturnStatement, 6)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(ReturnStatement, 6)] : @"";
            
            
            txtName.text=userName;
            lblCountry.text=location;
            delegate.countryLabel=location;
            lblSelectedDate.text=dateOfBirth;
            lblAgeValue.text=age;
            txtWeightValue.text=weight;
            txtHeightValue.text=height;
        }
    }
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
