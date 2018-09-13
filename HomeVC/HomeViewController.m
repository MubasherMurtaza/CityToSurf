//
//  HomeViewController.m
//  CityToSurf
//
//  Created by Mubasher on 13/04/2015.
//  Copyright (c) 2015 Connect Techno. All rights reserved.
//

#import "HomeViewController.h"
#import "ProfileViewController.h"
#import "RegisterViewController.h"
#import "TrainingProgramViewController.h"
#import "TicketViewController.h"
#import "EventPartnersViewController.h"
#import "FundRisingViewController.h"
#import "sqlFunction.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    delegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)viewWillDisappear:(BOOL)animated{
    hide=100;
    speed=0.0f;
    [self performSelector:@selector(slideProfileView) withObject:nil afterDelay:speed];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self setRemainingDays];
    [self checkForImage];
    
    hide=0;
    speed=0.2f;
    [self performSelector:@selector(slideProfileView) withObject:nil afterDelay:speed];
    
    if (delegate.ticketImg!=Nil)
        imgPlusSign.hidden=TRUE;
    else
        imgPlusSign.hidden=FALSE;
}
-(void)slideProfileView{
    [delegate jumpAnimationForViewToggle:profileView toPoint:CGPointMake(243+hide, 125)];
    [self performSelector:@selector(slideTrainingView) withObject:nil afterDelay:speed];
}
-(void)slideTrainingView{
    [delegate jumpAnimationForViewToggle:trainingView toPoint:CGPointMake(243+2*hide, 188)];
    [self performSelector:@selector(slideRegisterView) withObject:nil afterDelay:speed];
}
-(void)slideRegisterView{
    [delegate jumpAnimationForViewToggle:registerView toPoint:CGPointMake(243+3*hide, 249)];
    [self performSelector:@selector(slideEventView) withObject:nil afterDelay:speed];
}
-(void)slideEventView{
    [delegate jumpAnimationForViewToggle:eventView toPoint:CGPointMake(243+4*hide, 311)];
    [self performSelector:@selector(slideFundView) withObject:nil afterDelay:speed];
}
-(void)slideFundView{
    [delegate jumpAnimationForViewToggle:fundView toPoint:CGPointMake(243+5*hide, 374)];
    [self performSelector:@selector(slideEventPartnersView) withObject:nil afterDelay:speed];
}
-(void)slideEventPartnersView{
    [delegate jumpAnimationForViewToggle:eventPartners toPoint:CGPointMake(243+6*hide, 436)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Btn Actions
-(IBAction)slideBtnAction:(UIButton *)sender{
    switch ([sender tag]) {
        case 200:{
            ProfileViewController *profileVC=[[ProfileViewController alloc]initWithNibName:@"ProfileViewController" bundle:[NSBundle mainBundle]];
            [delegate.navViewController pushViewController:profileVC animated:YES];
            break;
        }
        case 201:{
            TrainingProgramViewController *tainingProgramVC=[[TrainingProgramViewController alloc]initWithNibName:@"TrainingProgramViewController" bundle:[NSBundle mainBundle]];
            [delegate.navViewController pushViewController:tainingProgramVC animated:YES];
            break;
        }
        case 202:{
            RegisterViewController *registerVC=[[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:[NSBundle mainBundle]];
            [delegate.navViewController pushViewController:registerVC animated:YES];
            break;
        }
        case 203:{
            delegate.webTitle=@"Event Info";
            delegate.url=@"http://perth.perthcitytosurf.com/";
            delegate.topPosition=@"-430";
            delegate.loadCount=@"1";
            [delegate.navViewController pushViewController:[[FundRisingViewController alloc] initWithNibName:@"FundRisingViewController" bundle:[NSBundle mainBundle]] animated:YES];
            break;
        }
        case 204:{
            delegate.webTitle=@"Fundraising";
            delegate.url=@"http://perth.perthcitytosurf.com/fundraising/";
            delegate.topPosition=@"-650";
            delegate.loadCount=@"4";
            [delegate.navViewController pushViewController:[[FundRisingViewController alloc] initWithNibName:@"FundRisingViewController" bundle:[NSBundle mainBundle]] animated:YES];
            break;
        }
        case 205:{
            [delegate.navViewController pushViewController:[[EventPartnersViewController alloc] initWithNibName:@"EventPartnersViewController" bundle:[NSBundle mainBundle]] animated:YES];
            break;
        }
        default:
            break;
    }
}
#pragma mark -
#pragma mark Take Iamge
-(IBAction)takeImgBtnAction:(UIButton *)sender{
    [delegate.navViewController pushViewController:[[TicketViewController alloc] initWithNibName:@"TicketViewController" bundle:[NSBundle mainBundle]] animated:YES];
}
-(IBAction)webLinkAction:(UIButton *)sender{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.teklabs.com.au"]];
}
#pragma mark -
#pragma mark Check for Image
-(void)checkForImage{
    NSString*(^getPathValue)(NSString *)=^(NSString *fileNameExist){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
        NSString *documentsDir = [paths objectAtIndex:0];
        return [documentsDir stringByAppendingPathComponent:fileNameExist];
    };
    
    
    NSString *fileName = [NSString stringWithFormat:@"%@.png",@"ticketImg"];
    NSString *imgPath = getPathValue(fileName);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = [fileManager fileExistsAtPath:imgPath];
    if (success) {
        UIImage *img = [UIImage imageWithContentsOfFile:imgPath];
        delegate.ticketImg=(NSString*)img;
    }
}
-(void)setRemainingDays{
    
    NSString *location=@"";
    NSString  *storeResult=@"select * from ProfileData";
    sqlite3_stmt *ReturnStatement = (sqlite3_stmt *) [sqlFunction getStatement:storeResult];
    {
        while(sqlite3_step(ReturnStatement) == SQLITE_ROW)
        {
          location=  ((char *)sqlite3_column_text(ReturnStatement, 2)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(ReturnStatement, 2)] : @"";
        }
    }
    
    if (location.length<2)
        location=@"Karratha";
    if([location isEqualToString:@"Karratha"]){
        int days = [delegate calculateDays:[delegate formatCurrentDate:@"dd/MM/yyyy"] SecondDate:@"26/07/2015" Format:@"dd/MM/yyyy"];
        lblRemainingDays.text=[NSString stringWithFormat:@"%d",days];
        return;
    }
    if([location isEqualToString:@"Geraldton"]){
        int days = [delegate calculateDays:[delegate formatCurrentDate:@"dd/MM/yyyy"] SecondDate:@"02/8/2015" Format:@"dd/MM/yyyy"];
        lblRemainingDays.text=[NSString stringWithFormat:@"%d",days];
        return;
    }
    if([location isEqualToString:@"Albany"]){
        int days = [delegate calculateDays:[delegate formatCurrentDate:@"dd/MM/yyyy"] SecondDate:@"09/8/2015" Format:@"dd/MM/yyyy"];
        lblRemainingDays.text=[NSString stringWithFormat:@"%d",days];
        return;
    }
    if([location isEqualToString:@"Busselton"]){
        int days = [delegate calculateDays:[delegate formatCurrentDate:@"dd/MM/yyyy"] SecondDate:@"16/8/2015" Format:@"dd/MM/yyyy"];
        lblRemainingDays.text=[NSString stringWithFormat:@"%d",days];
        return;
    }
    if([location isEqualToString:@"Perth"]){
        int days = [delegate calculateDays:[delegate formatCurrentDate:@"dd/MM/yyyy"] SecondDate:@"30/8/2015" Format:@"dd/MM/yyyy"];
        lblRemainingDays.text=[NSString stringWithFormat:@"%d",days];
        return;
    }
    if([location isEqualToString:@"WA Series"]){
        int days = [delegate calculateDays:[delegate formatCurrentDate:@"dd/MM/yyyy"] SecondDate:@"25/8/2015" Format:@"dd/MM/yyyy"];
        lblRemainingDays.text=[NSString stringWithFormat:@"%d",days];
        return;
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
