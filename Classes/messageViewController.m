//
//  messageViewController.m
//  Hello_SOAP
//
//  Created by TaeIl Kim on 7/9/13.
//
//

#import "messageViewController.h"
#import "Hello_SOAPAppDelegate.h"
#import "Hello_SOAPViewController.h"
#import "UIView+Toast.h"
#import "MBProgressHUD.h"

@interface messageViewController ()
{
    MBProgressHUD *_theHud;
}

@end

@implementation messageViewController
@synthesize desc,delegate,strMessage;

//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    if([text isEqualToString:@"\n"]){
//        [textView resignFirstResponder];
//        return FALSE;
//    }
//    return TRUE;
//}
-(IBAction)btnBackClicked:(id)sender{
    
    if(flag == TRUE) return;
    flag = FALSE;
    

//    [del.viewController.pinView.tGVC.concernInfo dismissViewControllerAnimated:YES completion:nil];
    self.desc =@"";
     [glbAppdel.parentvc dismissViewControllerAnimated:YES completion:nil];
}
-(void)textViewDidChange:(UITextView *)textView{
    if(![textView hasText]){
        lblPlaceholder.hidden = NO;
    }else{
        lblPlaceholder.hidden = YES;
    }
}
/*-(void)textViewDidEndEditing:(UITextView *)textView{
    if(![textView hasText])
        lblPlaceholder.hidden = NO;
    //    else
    //        lblPlaceholder.hidden = YES;
}*/
-(IBAction)btnSendClicked:(id)sender{
    if ([txtvCont.text isEqualToString:@"" ]) {
        [self.view makeToast:@"Please enter message"];
        return;
    }
    else
    {
        [self showHud:@"Loading.."];
    if(flag == TRUE) return;
    isSubmitted = YES;
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    flag = TRUE;
    [parser messageTicket:del.expertID TicketID:del.ticID Description:txtvCont.text];
    [self.view makeToast:@"Message sent to head office"];
    [self hideHud];
}
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
    [self prefersStatusBarHidden];
    isSubmitted = NO;
    if (strMessage) {
        txtvCont.text = strMessage;
    }
    // Do any additional setup after loading the view from its nib.
//    CGRect rt;
    CGSize sz = [UIScreen mainScreen].bounds.size;
    [txtvCont.layer setCornerRadius:10];
    [txtvCont.layer setBorderWidth:1];
    [txtvCont.layer setBorderColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0].CGColor];
    [txtvCont setTextColor:[UIColor grayColor]];
    [txtvCont setFrame:CGRectMake(txtvCont.frame.origin.x,txtvCont.frame.origin.y, txtvCont.frame.size.width, sz.height - txtvCont.frame.origin.y - 35 - 70)];
//    [lblTitle setText:[NSString stringWithFormat:@"ID %@", [[NSUserDefaults standardUserDefaults]objectForKey:@"PKTicketId"]]];
    
    lblPlaceholder = [[UILabel alloc]initWithFrame:CGRectMake(4, 3, 300, 30)];
    [lblPlaceholder setBackgroundColor:[UIColor clearColor]];
    [lblPlaceholder setTextColor:[UIColor lightGrayColor]];
    
    [lblPlaceholder setText:@"Enter response here..."];
    [txtvCont addSubview:lblPlaceholder];
    [lblPlaceholder release];
    
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    txtvCont.inputAccessoryView = numberToolbar;
    
//    rt = sV.frame;
//    rt.origin.y = (sz.height - 480)/2;
//    sV.frame = rt;
//    rt = txtvCont.frame;
//    rt.size.height = sz.height/480*208;
//    txtvCont.frame = rt;
//    
//    rt = btnBack.frame;
//    if(sz.height>480)
//        rt.origin.y = sz.height - 100;
//    else
//        rt.origin.y = sz.height - 50;
//    btnBack.frame = rt;
//    
//    rt = btnSend.frame;
//    if(sz.height>480)
//        rt.origin.y = sz.height - 100;
//    else
//        rt.origin.y = sz.height - 50;
//    btnSend.frame = rt;
    flag = FALSE;
    if(!parser)
        parser = [[MyParserViewController alloc]init:self];
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    if( textView == txtvCont){
        CGSize sz = [UIScreen mainScreen].bounds.size;
        [txtvCont.layer setCornerRadius:10];
        [txtvCont.layer setBorderWidth:1];
        [txtvCont.layer setBorderColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0].CGColor];
        [txtvCont setTextColor:[UIColor grayColor]];
        [txtvCont setFrame:CGRectMake(txtvCont.frame.origin.x,txtvCont.frame.origin.y, txtvCont.frame.size.width, sz.height - txtvCont.frame.origin.y - 235 - 70)];
        //    [lblTitle setText:[NSString stringWithFormat:@"ID %@", [[NSUserDefaults standardUserDefaults]objectForKey:@"PKTicketId"]]];
        
        /*lblPlaceholder = [[UILabel alloc]initWithFrame:CGRectMake(4, 3, 300, 30)];
        [lblPlaceholder setBackgroundColor:[UIColor clearColor]];
        [lblPlaceholder setTextColor:[UIColor lightGrayColor]];
        [lblPlaceholder setText:@""];
        [txtvCont addSubview:lblPlaceholder];
        [lblPlaceholder release];*/

    }
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if( textView == txtvCont){
        CGSize sz = [UIScreen mainScreen].bounds.size;
        [txtvCont.layer setCornerRadius:10];
        [txtvCont.layer setBorderWidth:1];
        [txtvCont.layer setBorderColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0].CGColor];
        [txtvCont setTextColor:[UIColor grayColor]];
        [txtvCont setFrame:CGRectMake(txtvCont.frame.origin.x,txtvCont.frame.origin.y, txtvCont.frame.size.width, sz.height - txtvCont.frame.origin.y - 35 - 70)];
        //    [lblTitle setText:[NSString stringWithFormat:@"ID %@", [[NSUserDefaults standardUserDefaults]objectForKey:@"PKTicketId"]]];
        
        lblPlaceholder = [[UILabel alloc]initWithFrame:CGRectMake(4, 3, 300, 30)];
        [lblPlaceholder setBackgroundColor:[UIColor clearColor]];
        [lblPlaceholder setTextColor:[UIColor lightGrayColor]];
        
        if(txtvCont.text.length==0){
            lblPlaceholder = [[UILabel alloc]initWithFrame:CGRectMake(4, 3, 300, 30)];
            [lblPlaceholder setBackgroundColor:[UIColor clearColor]];
            [lblPlaceholder setTextColor:[UIColor lightGrayColor]];
            [lblPlaceholder setText:@""];
            [txtvCont addSubview:lblPlaceholder];
            [lblPlaceholder release];
        }
           }
}


-(void)doneWithNumberPad{
    [txtvCont resignFirstResponder];
}
//-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
//    
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:1.0];
//        [sV setContentOffset:CGPointMake(0, 130)];
//        [UIView commitAnimations];
//    return YES;
//}
//- (BOOL) textViewShouldEndEditing:(UITextView *)textView{
//	[textView resignFirstResponder];
//    //        if(flag == FALSE){
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.5];
//    [sV setContentOffset:CGPointMake(0,0)];
//    [UIView commitAnimations];
//    //        }
//	return YES;
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)doneAction{
//    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    flag = FALSE;
    [self btnBackClicked:nil];
    
//    [del.viewController.pinView.tGVC.concernInfo.sAVC dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewDidAppear:(BOOL)animated{
//    txtvCont.text = @"";
    
}
-(void)viewWillDisappear:(BOOL)animated {
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
     txtvCont.text = @"";
    if (txtvCont.text.length == 0) {
        lblPlaceholder.hidden = NO;
    }
}
- (void)dealloc {
    [btnSend release];
    [btnBack release];
    [btnCancel release];
    [lblTitle release];
    [super dealloc];
}

-(void)showHud: (NSString *)waitDesc
{
    if (_theHud == nil) {
        _theHud = [[MBProgressHUD alloc] init];
    }
    
    _theHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _theHud.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
    _theHud.labelText = waitDesc;
}

-(void)hideHud
{
    [_theHud hide:YES];
}

@end
