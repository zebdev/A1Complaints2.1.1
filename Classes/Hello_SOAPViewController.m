//
//  Hello_SOAPAppDelegate.m
//  Hello_SOAP
//
//  Created by Dave McAnall on 11/2/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "Hello_SOAPViewController.h"
#import "FileIO.h"
#import "Hello_SOAPAppDelegate.h"

@implementation Hello_SOAPViewController

@synthesize parser, pinView,indicatorView, fCanceled;

-(IBAction)buttonClick:(id)sender
{
//    if(!parser)
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    [spinner startAnimating];
    del.userUrl = txtUrl.text;
    del.userName = txtUsername.text;
    del.passWd = txtPasswd.text;
    if(flag == TRUE) return;
    fShowLogo = FALSE;
    flag = TRUE;
    parser = [[MyParserViewController alloc]init:self];
    [parser login:txtUsername.text pwd:txtPasswd.text];
//	[txtUsername resignFirstResponder];

}
-(void)doneAction{
    FileIO *m_pFileIO = [[FileIO alloc]initFileIO];
    int i = 0;
    NSMutableDictionary *parsed;
    for(parsed in parser.allData){
        i = i + 1;
        NSLog(@"-----%d------",i);
        if(parsed.count>0){
            if(fShowLogo == TRUE){
                fShowLogo = FALSE;
                NSString *urll = [parsed objectForKey:@"GetLogoURLResult"];
                NSLog(@"URL---%@",urll);
    NSURL *url = [NSURL URLWithString:urll];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
//                UIImage *image = [UIImage imageNamed:@"setting.png"];
//    imgLogo = [[UIImageView alloc] initWithImage:image];
                [imgLogo setImage:image];
                flag = FALSE;
                return;
            }
            flag = FALSE;
            if(([parsed objectForKey:@"ExpertLoginResult"] == nil) || [[parsed objectForKey:@"ExpertLoginResult"]isEqual:@"0"]){
//                NSLog(@"Input correct username or password!");
                [self showAlertWithTitle:@"Input correct Username and Password!"];
            }else{
                strUserId = [parsed objectForKey:@"ExpertLoginResult"];
                parser1 = [[MyParserViewController alloc]init];
                    [parser1 InsertDeviceToken:[[NSUserDefaults standardUserDefaults]valueForKey:@"DeviceToken"] andUserid:strUserId];
                if(!pinView)
                    pinView = [[pinInputViewController alloc]init];
                Hello_SOAPAppDelegate* del = [UIApplication sharedApplication].delegate;
                pinView.expertID = [parsed objectForKey:@"ExpertLoginResult"];
                pinView.strUserId = strUserId;
                del.expertID = [parsed objectForKey:@"ExpertLoginResult"];
                del.userName = txtUsername.text;
                del.passWd = txtPasswd.text;
                if(btnCheck.selected){
                    [m_pFileIO openFile:NO];//write mode
                    [m_pFileIO writeInt:20 :(int)del.userName.length];
                    [m_pFileIO writeString:24 Data:del.userName];
                    
                    [m_pFileIO writeInt:60 :(int)del.passWd.length];
                    [m_pFileIO writeString:64 Data:del.passWd];
                    
                    [m_pFileIO writeInt:100 :(int)txtUrl.text.length];
                    [m_pFileIO writeString:104 Data:txtUrl.text];

                    [m_pFileIO closeFile];
                }else{
                    [m_pFileIO openFile:NO];//write mode
                    [m_pFileIO writeInt:20 :0];
//                    [m_pFileIO writeString:24 Data:0];
                    
                    [m_pFileIO writeInt:60 :0];
//                    [m_pFileIO writeString:64 Data:del.passWd];
                    
                    [m_pFileIO writeInt:100 :0];
//                    [m_pFileIO writeString:104 Data:txtUrl.text];
                    
                    [m_pFileIO closeFile];
                }
                //pavan fix
//                if([btnCheck isSelected])
//                {
//                    pinView.direct = 0;
//                }else{
//                    pinView.direct = 2;
//                }
                //pavan fix
                [self performSegueWithIdentifier:@"show_pin" sender:self];
 
                break;
            }
        }
    }
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

//    [parser release];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    glbAppdel.parentvc=self;
    if([segue.identifier isEqualToString:@"show_pin"])
    {
        pinInputViewController *newpinview =segue.destinationViewController;
        newpinview.expertID =pinView.expertID;
        newpinview.strUserId =pinView.strUserId;
        newpinview.direct =pinView.direct;
          //Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
//        del.viewController=self;
    }
}
- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    //        if(flag == FALSE){
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [scrollView setContentOffset:CGPointMake(0,0)];
    [UIView commitAnimations];
//    flag = TRUE;
    //        }
	return YES;
//	[textField resignFirstResponder];
//	return YES;
}

/*
 Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView {
}
 */

/*
 Implement viewDidLoad if you need to do additional setup after loading the view.*/
-(void)viewDidAppear:(BOOL)animated{
    if(!fCanceled && ![txtUsername.text isEqualToString:@""] && ![txtPasswd.text isEqualToString:@""]){
        [self buttonClick:nil];
    }
    else if(![txtUrl.text isEqualToString:@""]){
        fShowLogo = TRUE;
        [self showLogoImage];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    
//    NSLog(@"isRemeberMe %@ and default %@ ",isRememberMe?@"YES":@"NO",[[NSUserDefaults standardUserDefaults] valueForKey:@"isRememberMe"]);
    
    FileIO *m_pFileIO = [[FileIO alloc]initFileIO];

    int len;
    [m_pFileIO openFile:YES];//read mode
    len = [m_pFileIO readInt:20];
    
    txtPasswd.text = @"";

    if(len == 0){
//        txtUrl.text = @"";
//        txtPasswd.text = @"";
//        txtUsername.text = @"";
    } else {
        txtUsername.text = [m_pFileIO readString:24 Length:len];
        
        len = [m_pFileIO readInt:60];
        txtPasswd.text = [m_pFileIO readString:64 Length:len];
        
        len = [m_pFileIO readInt:100];
        txtUrl.text = [m_pFileIO readString:104 Length:len];
        [btnCheck setSelected:YES];
    }
    [m_pFileIO closeFile];
    CGRect rt;
    
    rt = [UIScreen mainScreen].bounds;
    CGRect r = scrollView.frame;
    r.origin.y = 0;//(rt.size.height-480)/2;//-20;
    scrollView.frame = r;
}
-(void)viewDidDisappear:(BOOL)animated {
//    txtPasswd.text = @"";
//    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isRememberMe"] isEqualToString:@"NO"]) {
//        txtUrl.text = @"";
//        txtUsername.text = @"";
//    }
}
- (void)viewDidLoad {
	[super viewDidLoad];
    flag = FALSE;
       Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    del.viewController =self;
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    if(!pinView)
        pinView = [[pinInputViewController alloc]init];
    fCanceled = FALSE;

    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhite];

    CGRect  rect = [UIScreen mainScreen].bounds;
    NSLog(@"%f,%f",rect.size.width, rect.size.height);
	spinner.center = CGPointMake(rect.size.width / 2, -rect.size.height / 2);
    [self.view addSubview:spinner];
    [spinner setHidesWhenStopped:YES];
	[spinner stopAnimating];
}
-(void)nextScreen{

    if(!pinView)
        pinView = [[pinInputViewController alloc]init];
    [self performSegueWithIdentifier:@"show_pin" sender:self];
 
}
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//	// Return YES for supported orientations
//	return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField == txtUrl)
        fShowLogo = FALSE;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1.0];
        [scrollView setContentOffset:CGPointMake(0, 100)];
        [UIView commitAnimations];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(textField == txtUrl && fShowLogo==FALSE){
        fShowLogo = TRUE;

        [self showLogoImage];
    }
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(textField.text.length+string.length > 100){
        return NO;
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}
-(IBAction)checkClick:(id)sender{

    UIButton *temp = sender;
    if(temp.selected){
        isRememberMe = NO;
//        [[NSUserDefaults standardUserDefaults]setValue:@"NO" forKey:@"isRememberMe"];
        [temp setSelected:NO];
    }
    else{
        isRememberMe = YES;
//        [[NSUserDefaults standardUserDefaults]setValue:@"YES" forKey:@"isRememberMe"];

        [temp setSelected:YES];
    }
}
- (void)dealloc 
{
	[super dealloc];
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
-(void)showLogoImage{
//    [parser getLogoURL:txtUrl.text];

}
-(void)errorAction{
    
}
@end
