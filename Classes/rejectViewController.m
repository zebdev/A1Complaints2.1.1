//
//  rejectViewController.m
//  Hello_SOAP
//
//  Created by TaeIl Kim on 7/9/13.
//
//

#import "rejectViewController.h"
#import "Hello_SOAPAppDelegate.h"
#import "Hello_SOAPViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"
#import "UIView+Toast.h"
@interface rejectViewController ()
{
    MBProgressHUD *_theHud;
}

@end


@implementation rejectViewController
@synthesize desc,lblDesc;
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    if([text isEqualToString:@"\n"]){
//        [textView resignFirstResponder];
//        return FALSE;
//    }
//    return TRUE;
//}
-(IBAction)btnBackClicked:(id)sender{
    if (flag == TRUE) return;
    flag = FALSE;
        desc = @"";
       [glbAppdel.parentvc dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)btnSendClicked:(id)sender{
    
    if ([txtvCont.text isEqualToString:@"" ]) {
        [self.view makeToast:@"Please enter message"];
        return;
    }
    else
    {

    if (flag == TRUE) return;
    flag = true;
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    if([lblDesc.text isEqualToString:@"Close"]){
        [parser closeTicket:del.expertID TicketID:del.ticID Description:txtvCont.text];
    }else if([lblDesc.text isEqualToString:@"Release"]){
        [parser rejectTicket:del.expertID TicketID:del.ticID Description:txtvCont.text];
    }
         if([lblDesc.text isEqualToString:@"Close"])
         {
         [self.view makeToast:@"Concern is Closed"];
         }
        else
        {
          [self.view makeToast:@"Concern is Released"];  
        }
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
//    CGRect rt;
    CGSize sz = [UIScreen mainScreen].bounds.size;
//    rt = sV.frame;
//    rt.origin.y = (sz.height - 480)/2;
//    sV.frame = rt;
    [lblTitle setText:[NSString stringWithFormat:@"ID %@", [[NSUserDefaults standardUserDefaults]objectForKey:@"PKTicketId"]]];
    
    [txtvCont.layer setCornerRadius:10];
    [txtvCont.layer setBorderWidth:1];
    [txtvCont.layer setBorderColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0].CGColor];
    [txtvCont setTextColor:[UIColor grayColor]];
    [txtvCont setFrame:CGRectMake(txtvCont.frame.origin.x,txtvCont.frame.origin.y, txtvCont.frame.size.width, sz.height - txtvCont.frame.origin.y - 35 - 53)];

    
    lblPlaceholder = [[UILabel alloc]initWithFrame:CGRectMake(4, 3, 300, 30)];
    [lblPlaceholder setBackgroundColor:[UIColor clearColor]];
    [lblPlaceholder setTextColor:[UIColor lightGrayColor]];
    
    [lblPlaceholder setText:@"Enter response here..."];
    [txtvCont addSubview:lblPlaceholder];
    [lblPlaceholder release];
    
    flag = FALSE;
    if(!parser){
        parser = [[MyParserViewController alloc]init:self];
    }
    
    parser.usingObject =self;
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    self.lblDesc.text=self.lbltext;
    txtvCont.inputAccessoryView = numberToolbar;
    // Do any additional setup after loading the view from its nib.
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

//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:1.0];
//    [sV setContentOffset:CGPointMake(0, 130)];
//    [UIView commitAnimations];
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
//    if (![lastString isEqualToString:lblDesc.text]) {
//        NSLog(@"in if");
//        txtvCont.text = @"";
//    }
//    if (![lastString isEqualToString:lblDesc.text]) {
//        lastString = lblDesc.text;
//        txtvCont.text = @"";
//    }
//    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"title"]) {
//        NSLog(@"in if");
//        [[NSUserDefaults standardUserDefaults]setValue:lblDesc.text forKey:@"title"];
//    } else if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:lblDesc.text]){
//        NSLog(@"in else if");
//        [[NSUserDefaults standardUserDefaults]setValue:lblDesc.text forKey:@"title"];
//        txtvCont.text = @"";
//    }
//    txtvCont.text=@"";
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
     txtvCont.text = @"";
    if (txtvCont.text.length == 0) {
        lblPlaceholder.hidden = NO;
    }
}
-(void)errorAction{
    flag = FALSE;
    desc = @"";
}
-(void)doneAction{
    flag = FALSE;
    desc = @"";
           [glbAppdel.parentvc dismissViewControllerAnimated:YES completion:nil];
   }
- (void)dealloc {
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
