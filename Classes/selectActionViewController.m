//
//  selectActionViewController.m
//  Hello_SOAP
//
//  Created by TaeIl Kim on 7/8/13.
//
//

#import "selectActionViewController.h"
#import "Hello_SOAPAppDelegate.h"
#import "Hello_SOAPViewController.h"

@interface selectActionViewController ()
{
    MBProgressHUD *_theHud;
}

@end

@implementation selectActionViewController

-(IBAction)clickedBack:(id)sender{
    [glbAppdel.parentvc  dismissViewControllerAnimated:YES completion:nil];

   
}
-(IBAction)clickedCall:(id)sender{
    [self showHud:@"Loading.."];
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    formatter.dateFormat = @"dd/MM/yyyy HH:mm:ss";
	NSString *timestamp = [formatter stringFromDate:datePicker.date];
    
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    parser = [[MyParserViewController alloc]init:self];
    [parser callbackTicket:del.expertID TicketID:del.ticID Description:timestamp];
    [self.view setUserInteractionEnabled:NO];
    [self hideHud];
    
}
-(void)doneAction{
    [self.view setUserInteractionEnabled:YES];
    [glbAppdel.parentvc  dismissViewControllerAnimated:YES completion:nil];

}
-(IBAction)clickedClose:(id)sender{
    if(!rVC){
        rVC = [[rejectViewController alloc]init];
    }
    rVC.desc = @"back1";
       rVC.lbltext = @"Close";
  [self performSegueWithIdentifier:@"show_reject" sender:self];

 
}
-(IBAction)clickedRelease:(id)sender{
    if(!rVC){
        rVC = [[rejectViewController alloc]init];
    }
    rVC.desc = @"back1";
      rVC.lbltext= @"Release";
    [self performSegueWithIdentifier:@"show_reject" sender:self];

  
}
-(IBAction)clickedMessage:(id)sender{
      glbAppdel.parentvc=self;
    if(!mVC){
        mVC = [[messageViewController alloc]init];
    }
    
    mVC.desc = @"back1";

    [self performSegueWithIdentifier:@"show_message" sender:self];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
        glbAppdel.parentvc=self;
    if([segue.identifier isEqualToString:@"show_message"])
    {
        messageViewController *msgvc =segue.destinationViewController;
        msgvc.desc =@"back1";
    }
    else if ([segue.identifier isEqualToString:@"show_reject"])
    {
        rejectViewController *rejectvc =segue.destinationViewController;
        rejectvc.desc=rVC.desc;
        rejectvc.lbltext=rVC.lbltext;
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
    [self myLayoutSubviwes];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillLayoutSubviews{
    [self myLayoutSubviwes];
}
-(void)myLayoutSubviwes{
    CGRect rt = [UIScreen mainScreen].bounds;
    CGRect btnFrame;
    
    btnFrame = btnMessage.frame;
    btnFrame.origin.y = rt.size.height - btnFrame.size.height;
    btnMessage.frame = btnFrame;
    
    btnFrame = btnRelease.frame;
    btnFrame.origin.y = rt.size.height - btnFrame.size.height;
    btnRelease.frame = btnFrame;
    
    btnFrame = btnClose.frame;
    btnFrame.origin.y = rt.size.height - btnFrame.size.height;
    btnClose.frame = btnFrame;
    
    btnFrame = btnCall.frame;
    btnFrame.origin.y = rt.size.height - 136;
    btnCall.frame = btnFrame;
    
    datePicker.center = CGPointMake(160, (tempLabel2.frame.origin.y+tempLabel2.frame.size.height+btnCall.frame.origin.y)/2 );

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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



- (void)dealloc {
    [btnRelease release];
    [btnMessage release];
    [btnCall release];
    [btnClose release];
    
    [datePicker release];
    [tempLabel2 release];
    [super dealloc];
}
@end
