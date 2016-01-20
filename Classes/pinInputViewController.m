//
//  pinInputViewController.m
//  Hello_SOAP
//
//  Created by TaeIl Kim on 6/19/13.
//
//

#import "pinInputViewController.h"
#import "ticketGridViewController.h"
#import "Hello_SOAPViewController.h"
#import "Hello_SOAPAppDelegate.h"
#import "FileIO.h"
#import <QuartzCore/QuartzCore.h>
@interface pinInputViewController ()

@end

@implementation pinInputViewController
@synthesize expertID,tGVC,btnCancel, btnOK, direct;
@synthesize strUserId;
NSString *expID;
-(void)viewDidAppear:(BOOL)animated{
        Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    if(direct == 1)
    {
        direct = 0;
        [del.viewController dismissViewControllerAnimated:NO completion:nil];
        return;
    }
    if(direct == 2)
    {
        [imgCover setHidden:NO];
        
        direct = 1;
        [parser1 getTicketID:expertID];
        return;
    }
    [imgCover setHidden:YES];
}
-(void)resignrespondersforall{
for (UIView *vw in sV.subviews)
{
if([vw isKindOfClass:[UITextField class]])
{
    [vw resignFirstResponder];
}
}
}
-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"%s",__FUNCTION__);
    [self authenicateButtonTapped];
    [self resignrespondersforall];
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    [spinner setHidden:YES];
    [spinner stopAnimating];
    [self.view setUserInteractionEnabled:YES];
    if(!pins){
        pins = [[NSMutableDictionary alloc]init];
    }else{
        [pins removeAllObjects];
    }
    char1.text =char2.text =char3.text =char4.text = @"";
     char5.text =char6.text =char7.text =char8.text = @"";

    FileIO *m_pFileIO = [[FileIO alloc]initFileIO];
    
//    [m_pFileIO openFile:NO];
//    [m_pFileIO writeInt:150 :0];
//    [m_pFileIO closeFile];
//    return;

    [m_pFileIO openFile:YES];//READ MODE
    userCount = [m_pFileIO readInt:150];
    int loc = 154;
    int length;
    NSString *strTempUsername, *strTempPin;
    loc = 154;
    length = 0;
    for(int i = 0; i < userCount; i++){
        length = [m_pFileIO readInt:loc];
        loc = loc + 4;
        strTempUsername = [m_pFileIO readString:loc Length:length];
        loc = loc + length;
        strTempPin = [m_pFileIO readString:loc Length:4];
        loc = loc + 4;
        [pins setObject:strTempPin forKey:strTempUsername];
    }
    [m_pFileIO closeFile];

    if([pins objectForKey:del.userName]==nil){
//        [imgBack setImage:[UIImage imageNamed:@"pinChooseBack.png"]];
        char1.hidden=char2.hidden=char3.hidden=char4.hidden=NO;
        title1.hidden=NO;
        NSLog(@"-------Set Pin-------");
//        NSLog(@"PIN1: (%f, %f, %f, %f)", pin1.frame.origin.x, pin1.frame.origin.y, pin1.frame.size.width, pin1.frame.size.height);
//        NSLog(@"PIN2: (%f, %f, %f, %f)", pin2.frame.origin.x, pin2.frame.origin.y, pin2.frame.size.width, pin2.frame.size.height);
    }else{
//        [imgBack setImage:[UIImage imageNamed:@"pinInputBack.png"]];
        
        char1.hidden=char2.hidden=char3.hidden=char4.hidden=YES;
        title1.hidden=YES;
//        if([UIScreen mainScreen].bounds.size.height==480){
//            pin1.center = CGPointMake(pin1.center.x, pin1.center.y+33);
//        }

//         pin1.center = CGPointMake(pin1.center.x, pin1.center.y+pin1.frame.size.height*1.3);
//        NSLog(@"-------Confirm Pin-------");
//        NSLog(@"PIN1: (%f, %f, %f, %f)", pin1.frame.origin.x, pin1.frame.origin.y, pin1.frame.size.width, pin1.frame.size.height);
//        NSLog(@"PIN2: (%f, %f, %f, %f)", pin2.frame.origin.x, pin2.frame.origin.y, pin2.frame.size.width, pin2.frame.size.height);
    }
}
-(IBAction)onClickedCancel:(id)sender{
    if(f == TRUE) return;

    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    del.viewController.fCanceled = TRUE;

    NSString *strTempUsername;
    int loc;
    int length;
    
    loc = 150;
    FileIO *m_pFileIO = [[FileIO alloc]initFileIO];
//    [pins setObject:strPin forKey:del.userName];
    [pins removeObjectForKey:del.userName];
    [m_pFileIO openFile:NO];
    userCount = (int)pins.count;
    [m_pFileIO writeInt:loc :userCount];
    loc = 154;
    length = 0;
    [m_pFileIO writeInt:20 :0];
    [m_pFileIO writeInt:60 :0];
    [m_pFileIO writeInt:100 :0];
    for(strTempUsername in [pins allKeys]){
        //                    length = [m_pFileIO readInt:loc];
        length = (int)strTempUsername.length;
        [m_pFileIO writeInt:loc :length];
        loc = loc + 4;
        
        //                    strTempUsername = [m_pFileIO readString:loc Length:length];
        [m_pFileIO writeString:loc Data:strTempUsername];
        loc = loc + length;
        
        //                    strTempPin = [m_pFileIO readString:loc Length:4];
        [m_pFileIO writeString:loc Data:[pins objectForKey:strTempUsername]];
        loc = loc + 4;
        //                    [pins setObject:strTempUsername forKey:strTempPin];
    }
    [m_pFileIO closeFile];
    [self showAlertWithTitle:@"Reset PIN code!"];
    [del.viewController dismissViewControllerAnimated:YES completion:nil];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    flag = TRUE;
    f = FALSE;
    // Do any additional setup after loading the view from its nib.

    parser1 = [[MyParserViewController alloc]init:self];
   }

-(void)viewDidLayoutSubviews{
    CGRect rt = [UIScreen mainScreen].bounds;
//    sV.center = CGPointMake(rt.size.width/2, rt.size.height/2);
    sV.frame = rt;
//    float rate;
//        CGRect sz = [UIScreen mainScreen].bounds;
//        rate = sz.size.height/480.0f;
//    self.
//    self.btnOK.frame = CGRectMake(btnOK.frame.origin.x, btnOK.frame.origin.y*rate, btnOK.frame.size.width, btnOK.frame.size.height);
//    self.btnCancel.frame = CGRectMake(btnCancel.frame.origin.x, btnCancel.frame.origin.y*rate, btnCancel.frame.size.width, btnCancel.frame.size.height);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)okClicked:(id)sender{
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    NSString *pinone =[NSString stringWithFormat:@"%@%@%@%@",char1.text,char2.text,char3.text,char4.text];
        NSString *pintwo =[NSString stringWithFormat:@"%@%@%@%@",char5.text,char6.text,char7.text,char8.text];
    if(f == TRUE) return;
    f = TRUE;
    NSString *strPin;
    if(pintwo.length!=4 )
    {
//        NSLog(@"PIN code input error!");
        [self showAlertWithTitle:@"PIN code input Error"];
        f = FALSE;
        return;
    }
    if(char1.hidden == NO && (![pinone isEqualToString:pintwo])){
        [self showAlertWithTitle:@"PIN code input Error"];
        f = FALSE;
        return;
    }
    strPin = pintwo;
    FileIO *m_pFileIO = [[FileIO alloc] initFileIO];
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge];
    //

    spinner.center =self.view.center;
    [self.view setUserInteractionEnabled:NO];
    [self.view addSubview: spinner];
    [spinner startAnimating];
    
        if([pins objectForKey:del.userName]==nil){
            NSLog(@"PIN code is saving!");
            if([strPin length]==4){
                [pins setObject:strPin forKey:del.userName];
                
                [m_pFileIO openFile:NO];
                int loc = 150;
                int length;
                NSString *strTempUsername;
//                userCount = [m_pFileIO readInt:150];
                userCount = (int)pins.count;
                [m_pFileIO writeInt:loc :userCount];
                loc = 154;
                length = 0;
                
                for(strTempUsername in [pins allKeys]){
//                    length = [m_pFileIO readInt:loc];
                    length = (int)strTempUsername.length;
                    [m_pFileIO writeInt:loc :length];
                    loc = loc + 4;
                    
//                    strTempUsername = [m_pFileIO readString:loc Length:length];
                    [m_pFileIO writeString:loc Data:strTempUsername];
                    loc = loc + length;
                    
//                    strTempPin = [m_pFileIO readString:loc Length:4];
                    [m_pFileIO writeString:loc Data:[pins objectForKey:strTempUsername]];
                    loc = loc + 4;
//                    [pins setObject:strTempUsername forKey:strTempPin];
                }
                [m_pFileIO closeFile];
                [self showAlertWithTitle:@"PIN code saved!"];
                [parser1 getTicketID:expertID];
                
            }else{
                [self showAlertWithTitle:@"PIN code input must be 4 letters!"];
                f = FALSE;
                [spinner stopAnimating];
                [self.view setUserInteractionEnabled:YES];
            }
            return;
        }
        if(([[pins objectForKey:del.userName] isEqualToString:strPin]) && (strPin.length==4)){
            NSLog(@"PIN code input OK!");
//
            [parser1 getTicketID:expertID];
        }else{
            [spinner stopAnimating];
            [self.view setUserInteractionEnabled:YES];
            NSLog(@"PIN code input error!");
            [self showAlertWithTitle:@"PIN code input error!"];
            f = FALSE;
        }
//    if(ret > 0){//PIN CODE SAVED
//        if([strPin isEqualToString:strSavedPin]){//PIN CODE INPUTED CORRECTLY.
//            NSLog(@"PIN code input OK!");
//            expertID = [NSString stringWithFormat:@"%d",expID];
//            Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
//            del.expertID = expertID;
//            [parser1 getTicketID:expertID];
//        }else{
////            NSLog(@"PIN code input error!");
//            [self showAlertWithTitle:@"PIN code input error!"];
//            f = FALSE;
//        }
//    }else{//save pin code
//        NSLog(@"PIN code Saving!");
//        if([strPin length]== 4){
//            [m_pFileIO openFile:NO];//write mode
//            [m_pFileIO writeInt:4 :strPin.length];
//            [m_pFileIO writeInt:8 :expertID.intValue];
//            [m_pFileIO writeString:12 Data:strPin];
//            [m_pFileIO closeFile];
//            
//
//            del.expertID = expertID;
//            
//            [parser1 getTicketID:expertID];
//
//        }else{
////            NSLog(@"PIN code input must be 4 letters!");
//            [self showAlertWithTitle:@"PIN code input must be 4 letters!"];
//            f = FALSE;
//        }
//    }
}
- (BOOL) textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
        if(flag == FALSE){
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [sV setContentOffset:CGPointMake(0,0)];
    [UIView commitAnimations];
    flag = TRUE;
        }
	return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    #define MAX_LENGTH 1
    if (textField.text.length >= MAX_LENGTH && range.length == 0)
    {
        
        return NO; // return NO to not change text
    }
    if(textField == char8)
    {
        if ([string length] == 0 && range.length > 0)
        {
            [char7 becomeFirstResponder];
        }
    }
    if(textField == char7)
    {
        if ([string length] == 0 && range.length > 0)
        {
            [char6 becomeFirstResponder];
        }
    }
    if(textField == char6)
    {
        if ([string length] == 0 && range.length > 0)
        {
            [char5 becomeFirstResponder];
        }
    }
    if(textField == char4)
    {
        if ([string length] == 0 && range.length > 0)
        {
            [char3 becomeFirstResponder];
        }
    }
    if(textField == char3)
    {
        if ([string length] == 0 && range.length > 0)
        {
            [char2 becomeFirstResponder];
        }
    }
    if(textField == char2)
    {
        if ([string length] == 0 && range.length > 0)
        {
            [char1 becomeFirstResponder];
        }
    }


    if(string.length==1)
    {
        UITextField *next =(UITextField*)[sV viewWithTag:textField.tag+1];
        if(next)
            [next performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.1     ];
        return YES;
    }
    if(string.length>1)
    {
        UITextField *next =(UITextField*)[sV viewWithTag:textField.tag+1];
        if(next)
            [next performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.1     ];
        return NO;
    }
    
    return YES;
    
    
}
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
////    NSLog(@"%@,%@",textField.text,string);
//    int v;
//    v = textField.text.length + string.length;
//
//    if(v >= 1){
//        
//        UIResponder* nextResponder = [textField.superview viewWithTag:(textField.tag + 1)];
//        if(v == 1)
//            textField.text = string;
//        if(string.length==1)
//            [nextResponder becomeFirstResponder];
//        return NO;
//    }
//
//    return YES;
//}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.text=@"";
    if(flag == TRUE){
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1.0];
        [sV setContentOffset:CGPointMake(0, 100)];
        [UIView commitAnimations];
        flag = FALSE;
    }
    if (textField.tag  >104) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1.0];
        [sV setContentOffset:CGPointMake(0, 100)];
        [UIView commitAnimations];
    }
}

-(void)errorAction{
    FileIO *m_pFileIO = [[FileIO alloc]initFileIO];
    [m_pFileIO openFile:NO];
    
    [m_pFileIO closeFile];
    [self performSegueWithIdentifier:@"show_login" sender:self];
 
}
-(IBAction)forgotClicked:(id)sender{
    FileIO *m_pFileIO = [[FileIO alloc]initFileIO];
    [m_pFileIO openFile:NO];

    [m_pFileIO closeFile];
    [self performSegueWithIdentifier:@"show_login" sender:self];
 
}
-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;//This is a part of orientation.
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    glbAppdel.parentvc=self;

}
-(void)doneAction
{
    static int b = 0;
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    NSMutableDictionary *parsed;
    NSDictionary *tempParsed;
    NSString *temp;

    NSLog(@"value of b=%d",b);
    
    if(b == 0)
    {
        del.data1 = [NSMutableArray arrayWithArray:parser1.allData];
        
        NSLog(@"del data1 value=%@",del.data1);
        
//        NSMutableArray *marrData = [NSMutableArray arrayWithArray:parser1.allData];
//        if([marrData valueForKey:@"InsertDeviceToken"] == nil || [[marrData valueForKey:@"InsertDeviceToken"] isEqual:@"0"]){
//            [self showAlertWithTitle:@"Device Token not Inserted"];
//        } else  if([marrData valueForKey:@"InsertDeviceToken"]){
////            [self showAlertWithTitle:@"Device Token Added Successfully"];
//            NSLog(@"response data %@",marrData);
//        }
        
        do
        {
            temp = [[del.data1 objectAtIndex:b]objectForKey:@"PKTicketId"];
            b++;
            if(temp==nil) temp = @"";
        }while(([temp isEqualToString:@""]) && (del.data1.count>b));
        [parser1 getLocationName:temp];
    }
    else if(del.data1.count>b)
    {
        parsed = [del.data1 objectAtIndex:b-1];
        tempParsed = [parser1.allData objectAtIndex:0];
        if([tempParsed objectForKey:@"GetLocationNameResult"]==nil)
            [parsed setObject:@"" forKey:@"Store"];
        else
            [parsed setObject:[tempParsed objectForKey:@"GetLocationNameResult"] forKey:@"Store"];
        do{
            temp = [[del.data1 objectAtIndex:b]objectForKey:@"PKTicketId"];
            b++;
            if(temp==nil) temp = @"";
        }while(([temp isEqualToString:@""]) && (del.data1.count>b));
        
        [parser1 getLocationName:temp];
    }
    else
    {
        parsed = [del.data1 objectAtIndex:b-1];
        tempParsed = [parser1.allData objectAtIndex:0];
        if([tempParsed objectForKey:@"GetLocationNameResult"]==nil)
            [parsed setObject:@"" forKey:@"Store"];
        else
            [parsed setObject:[tempParsed objectForKey:@"GetLocationNameResult"] forKey:@"Store"];
        b = 0;
        if(!tGVC)
            tGVC = [[ticketGridViewController alloc]init];
            f = FALSE;
        [self performSegueWithIdentifier:@"show_list" sender:self];
        [char8 resignFirstResponder];
 
    }

}
- (void)showAlertWithTitle:(NSString *)t
{
    [[[[UIAlertView alloc] initWithTitle:t
                                 message:nil
                                delegate:nil
                       cancelButtonTitle:@"OK"
                       otherButtonTitles:nil
       ] autorelease] show];
}
//pavan fixed touchid

- (void)authenicateButtonTapped {
    
    
    LAContext *context = [[LAContext alloc] init];
    
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:@"Are you the device owner?"
                          reply:^(BOOL success, NSError *error) {
                              
                              if (error) {
                                  
                                  UIAlertController * alert=   [UIAlertController
                                                                alertControllerWithTitle:@"Touch ID for ApoyarA1"
                                                                message:@"There was a problem verifying your identity.."
                                                                preferredStyle:UIAlertControllerStyleAlert];
                                  
                                  
                                  UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                                      
                                      //do something when click button
                                  }];
                                  [alert addAction:okAction];
                                  
                                  return;
                                  
                              }
                              
                              
                              
                              
                              
                              if (success) {
                                  UIAlertController * alert=   [UIAlertController
                                                                alertControllerWithTitle:@"Touch ID for ApoyarA1"
                                                                message:@"You are the device owner."
                                                                preferredStyle:UIAlertControllerStyleAlert];
                                  
                                  
                                  UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                                      
                                      //do something when click button
                                  }];
                                  [alert addAction:okAction];
                                  [self performSegueWithIdentifier:@"show_list" sender:self];
                                  
                              } else {
                                  UIAlertController * alert=   [UIAlertController
                                                                alertControllerWithTitle:@"Touch ID for ApoyarA1"
                                                                message:@"You are not the device owner."
                                                                preferredStyle:UIAlertControllerStyleAlert];
                                  
                                  
                                  UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                                      
                                      //do something when click button
                                  }];
                                  [alert addAction:okAction];                              }
                              
                          }];
        
    } else {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Touch ID for ApoyarA1"
                                      message:@"You device can't authenticate touch Id."
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            //do something when click button
        }];
        [alert addAction:okAction];
    }
}
- (IBAction)authenticateButtonTapped:(id)sender {
   
    [self authenicateButtonTapped];
    
}


@end
