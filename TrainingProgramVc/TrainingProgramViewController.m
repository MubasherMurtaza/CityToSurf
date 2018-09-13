//
//  TrainingProgramViewController.m
//  CityToSurf
//
//  Created by Mubasher on 21/04/2015.
//  Copyright (c) 2015 Connect Techno. All rights reserved.
//

#import "TrainingProgramViewController.h"
#import "TrainingViewController.h"

@interface TrainingProgramViewController ()

@end

@implementation TrainingProgramViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    delegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    trainingScrollData=[[NSMutableArray alloc]initWithObjects:@"Training - Beginners",@"Training - Intermdiate",@"Training - Advance", nil];
    dropDownData=[[NSMutableArray alloc]initWithObjects:@"Karratha",@"Geraldton",@"Albany",@"Busselton",@"Perth",@"WA Series", nil];
    
    [self fillDropDownMenu];
    showDropDown=FALSE;
    [dropDownView setFrame:CGRectMake(0, 114, 320, 250)];
    [self.view addSubview:dropDownView];
    
    if (delegate.countryLabel.length>1)
        lblCountry.text=delegate.countryLabel;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self fillTrainingProgramScrollView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)homeMoveBtn:(UIButton*)sender{
    [delegate.navViewController popViewControllerAnimated:YES];
}
-(void)fillTrainingProgramScrollView{
    
    
    
    for (UIView *view in contionarScrollView.subviews)
        [view removeFromSuperview];
    
    float yAxis=0.0;
    for (int i=0; i<trainingScrollData.count; i++) {
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, yAxis, 320, 48)];
        
        UILabel *lblData=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 250, 47)];
        [lblData setBackgroundColor:[UIColor clearColor]];
        [lblData setTextColor:[UIColor blackColor]];
        [lblData setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
        [lblData setText:[trainingScrollData objectAtIndex:i]];
        [lblData setAlpha:0.7];
        [lblData setTag:i+200];
        
        UIImageView *borderImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 47, 320, 1)];
        [borderImg setImage:[UIImage imageNamed:@"reg_line.png"]];
        
        UIImageView *arrowImg=[[UIImageView alloc]initWithFrame:CGRectMake(300, 17, 8, 14)];
        [arrowImg setImage:[UIImage imageNamed:@"register-arrow.png"]];
        //[arrowImg setTag:i];
        
        UIButton *selectedButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 48)];
        [selectedButton setTag:i+100];
    
        //[selectedButton addTarget:self action:@selector(highlightBtn:) forControlEvents:UIControlStateSelected];
        [selectedButton addTarget:self action:@selector(highlightBtn:) forControlEvents:UIControlStateHighlighted];
        
        [selectedButton addTarget:self action:@selector(openPDFile:) forControlEvents:UIControlEventTouchUpInside];
        
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
    //[sender setImage:[UIImage imageNamed:@"blackBack.png"] forState:UIControlStateSelected];
    
    UILabel *label = (UILabel *)[self.view viewWithTag:([sender tag]+100)];
    [label setTextColor:[UIColor whiteColor]];
    
}
-(IBAction)moveForword:(UIButton *)sender{
    TrainingViewController *trainingVC=[[TrainingViewController alloc] initWithNibName:@"TrainingViewController" bundle:[NSBundle mainBundle]];
    [delegate.navViewController pushViewController:trainingVC animated:YES];
    
}
-(IBAction)openPDFile:(id)sender{
    switch ([sender tag]) {
        case 100:
            nameFile=@"Training-Beginner.pdf";
            break;
        case 101:
            nameFile=@"Training-Intermediate.pdf";
            break;
        case 102:
            nameFile=@"Training-Advanced.pdf";
            break;
        default:
            break;
    }
    QLPreviewController* preview = [[QLPreviewController alloc] init];
    preview.dataSource = self;
    preview.delegate = self;
    [self presentViewController:preview animated:YES completion:nil];
}

#pragma mark - QLPreviewControllerDataSource
- (NSInteger) numberOfPreviewItemsInPreviewController: (QLPreviewController *) controller
{
    return 1;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    [self copyPDFFile:nameFile];
    return [NSURL fileURLWithPath:pdfFilePath];
}

-(void) copyPDFFile:(NSString*)fileName
{
    //Using NSFileManager we can perform many file system operations.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSString *filePath = [self getFliePath:fileName];
    BOOL success = [fileManager fileExistsAtPath:filePath];
    //NSLog(@"File Path: %@", filePath);
    
    if(!success) {
        pdfFilePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
        success = [fileManager copyItemAtPath:pdfFilePath toPath:filePath error:&error];
        if (!success)
            NSAssert1(0, @"Failed to create writable file with message '%@'.", [error localizedDescription]);
    }
    else
     pdfFilePath=filePath;
}

-(NSString *) getFliePath:(NSString*)file {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:file];
}
#pragma mark -
#pragma mark Drop Down menu
-(void)fillDropDownMenu{
    
    for (UIView *view in dropDownScrollView.subviews)
        [view removeFromSuperview];
    
    float yAxis=0.0;
    for (int i=0; i<dropDownData.count; i++) {
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, yAxis, 320, 50)];
        
        UIImageView *backImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 49)];
        [backImg setImage:[UIImage imageNamed:@"countryTab.png"]];
        
        UILabel *lblData=[[UILabel alloc]initWithFrame:CGRectMake(35, 0, 200, 49)];
        [lblData setBackgroundColor:[UIColor clearColor]];
        [lblData setTextColor:[UIColor whiteColor]];
        [lblData setFont:[UIFont fontWithName:@"HelveticaNeue-Regular" size:15]];
        [lblData setText:[dropDownData objectAtIndex:i]];
        [lblData setAlpha:0.7];
        
        UIImageView *borderImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 49, 320, 1)];
        [borderImg setImage:[UIImage imageNamed:@"reg_line.png"]];
        
        UIImageView *arrowImg=[[UIImageView alloc]initWithFrame:CGRectMake(8, 12, 18, 26)];
        [arrowImg setImage:[UIImage imageNamed:@"training-icon.png"]];
        
        UIButton *selectedButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 49)];
        [selectedButton setTag:i+400];
        [selectedButton addTarget:self action:@selector(changeCountryLabel:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [view addSubview:backImg];
        [view addSubview:lblData];
        [view addSubview:borderImg];
        [view addSubview:arrowImg];
        [view addSubview:selectedButton];
        
        [dropDownScrollView addSubview:view];
        yAxis+=50;
    }
    [dropDownScrollView setContentSize:CGSizeMake(dropDownScrollView.frame.size.width, yAxis)];
}
-(IBAction)showDropDown:(UIButton *)sender{
    if (showDropDown) {
        showDropDown=FALSE;
        dropDownView.hidden=TRUE;
    } else {
        showDropDown=TRUE;
        dropDownView.hidden=FALSE;
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    showDropDown=FALSE;
    dropDownView.hidden=TRUE;
}
-(IBAction)changeCountryLabel:(UIButton*)sender{
    lblCountry.text=[dropDownData objectAtIndex:([sender tag]-400)];
    dropDownView.hidden=TRUE;
    showDropDown=FALSE;
    
    delegate.countryLabel=lblCountry.text;
    
    BOOL exist=[sqlFunction itemExistsInDatabase:@"ProfileData" FieldName:@"ProfileDataid" Value:@"1"];
    if (exist){
        NSString *queryString=[NSString stringWithFormat:@"update ProfileData Set Location='%@' where ProfileDataid=1;",lblCountry.text];
        BOOL success=[sqlFunction InsUpdateDelData:queryString];
        if (success) {
            NSLog(@"Operation Perform Succesfully!");
        }
    }else{
        NSString *queryString=[NSString stringWithFormat:@"insert into ProfileData (UserName,Location,DateOfBirth,Age,Weight,Height) values('%@','%@','%@','%@','%@','%@');",@"",lblCountry.text,@"",@"",@"",@""];
        BOOL success=[sqlFunction InsUpdateDelData:queryString];
        if (success) {
            NSLog(@"Operation Perform Succesfully!");
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
