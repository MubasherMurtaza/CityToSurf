//
//  RegisterViewController.m
//  CityToSurf
//
//  Created by Mubasher on 14/04/2015.
//  Copyright (c) 2015 Connect Techno. All rights reserved.
//

#import "RegisterViewController.h"
#import "FundRisingViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    delegate=[[UIApplication sharedApplication] delegate];
    registerScrollData=[[NSMutableArray alloc]initWithObjects:@"Register - Karratha",@"Register - Garaldton",@"Register - Albany",@"Register - Busselton",@"Register - Perth",@"Register - WA Series", nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [self fillContionarScrollView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)homeMoveBtn:(UIButton*)sender{
    [delegate.navViewController popViewControllerAnimated:YES];
}
-(void)fillContionarScrollView{
    for (UIView *view in contionarScrollView.subviews)
        [view removeFromSuperview];
    
    float yAxis=0.0;
    for (int i=0; i<registerScrollData.count; i++) {
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, yAxis, 320, 48)];
        
        UILabel *lblData=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 250, 47)];
        [lblData setBackgroundColor:[UIColor clearColor]];
        [lblData setTextColor:[UIColor blackColor]];
        [lblData setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
        [lblData setAlpha:0.7];
        [lblData setTag:i+200];
        [lblData setText:[registerScrollData objectAtIndex:i]];
        
        
        
        UIImageView *borderImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 47, 320, 1)];
        [borderImg setImage:[UIImage imageNamed:@"reg_line.png"]];
        
        UIImageView *arrowImg=[[UIImageView alloc]initWithFrame:CGRectMake(300, 17, 8, 14)];
        [arrowImg setImage:[UIImage imageNamed:@"register-arrow.png"]];
        
        UIButton *selectedButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 48)];
        [selectedButton setTag:i+100];
        
        
        //[selectedButton addTarget:self action:@selector(highlightBtn:) forControlEvents:UIControlStateSelected];
        [selectedButton addTarget:self action:@selector(highlightBtn:) forControlEvents:UIControlStateHighlighted];
        
        [selectedButton addTarget:self action:@selector(moveForword:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:selectedButton];
        [view addSubview:lblData];
        [view addSubview:borderImg];
        [view addSubview:arrowImg];
        
        
        [contionarScrollView addSubview:view];
        
        yAxis+=48;
    }
    [contionarScrollView setContentSize:CGSizeMake(contionarScrollView.frame.size.width, yAxis)];
    
}
-(IBAction)highlightBtn:(UIButton *)sender{
    
    [sender setImage:[UIImage imageNamed:@"blackBack.png"] forState:UIControlStateNormal];
    
    UILabel *label = (UILabel *)[self.view viewWithTag:([sender tag]+100)];
    [label setTextColor:[UIColor whiteColor]];
}
-(IBAction)moveForword:(UIButton *)sender{
    UILabel *label = (UILabel *)[self.view viewWithTag:([sender tag]+100)];
    delegate.webTitle=label.text;
    
    switch ([sender tag]) {
        case 100:{
            delegate.url=@"https://secure.tiktok.biz/register/default.aspx?EventID=ctsseries&Edition=2015r1";
            delegate.topPosition=@"-50";
            delegate.loadCount=@"1";
            break;
        }
        case 101:{
            delegate.url=@"https://secure.tiktok.biz/register/default.aspx?EventID=ctsseries&Edition=2015r2";
            delegate.topPosition=@"-50";
            delegate.loadCount=@"1";
            break;
        }
        case 102:{
            delegate.url=@"https://secure.tiktok.biz/register/default.aspx?EventID=ctsseries&Edition=2015r3";
            delegate.topPosition=@"-50";
            delegate.loadCount=@"1";

            break;
        }
        case 103:{
            delegate.url=@"https://secure.tiktok.biz/register/default.aspx?EventID=ctsseries&Edition=2015r4";
            delegate.topPosition=@"-50";
            delegate.loadCount=@"1";

            break;
        }
        case 104:{
            delegate.url=@"https://secure.tiktok.biz/register/default.aspx?EventID=perthcitytosurf&Edition=2015";
            delegate.topPosition=@"-50";
            delegate.loadCount=@"1";

            break;
        }
        case 105:{
            delegate.url=@"http://perth.perthcitytosurf.com/wa-series/";
            delegate.topPosition=@"-130";
            delegate.loadCount=@"4";

            break;
        }
        default:
            break;
    }
    
    [delegate.navViewController pushViewController:[[FundRisingViewController alloc] initWithNibName:@"FundRisingViewController" bundle:[NSBundle mainBundle]] animated:YES];
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
