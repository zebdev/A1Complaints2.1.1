//
//  calViewController.m
//  Hello_SOAP
//
//  Created by TaeIl Kim on 7/9/13.
//
//

#import "calViewController.h"
#import "Hello_SOAPAppDelegate.h"
#import "Hello_SOAPViewController.h"

@interface calViewController ()

@end

@implementation calViewController
-(IBAction)onBtnBack:(id)sender{
    if(flag == TRUE) return;
    flag = FALSE;
     [glbAppdel.parentvc dismissViewControllerAnimated:YES completion:nil];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	UIDatePicker *datePicker = (UIDatePicker *)[actionSheet viewWithTag:101];
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    formatter.dateFormat = @"MM/dd/YY hh:mm:ss a";
	NSString *timestamp = [formatter stringFromDate:datePicker.date];
    txtDateTime.text = timestamp;
	[actionSheet release];
}
-(IBAction)onBtnCal:(id)sender{
    NSString *title = UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation) ? @"\n\n\n\n\n\n\n\n\n" : @"\n\n\n\n\n\n\n\n\n\n\n\n" ;
    
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Set", nil];
	[actionSheet showInView:self.view];
    
	
	UIDatePicker *datePicker = [[[UIDatePicker alloc] init] autorelease];
	datePicker.tag = 101;
    datePicker.datePickerMode = UIDatePickerModeDateAndTime;

	[actionSheet addSubview:datePicker];
    CGRect rt = actionSheet.frame;
    CGSize sz = [UIScreen mainScreen].bounds.size;
    rt.origin.y =sz.height-rt.size.height;
    actionSheet.frame = rt;
}
-(IBAction)onBtnOK:(id)sender{
    if(flag == TRUE) return;
    flag = TRUE;
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    parser = [[MyParserViewController alloc]init:self];
    [parser callTicket:del.expertID TicketID:del.ticID Description:txtDateTime.text];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
    if(!parser)
        parser = [[MyParserViewController alloc]init:self];
    flag = FALSE;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)doneAction{
    flag = FALSE;
     [glbAppdel.parentvc dismissViewControllerAnimated:YES completion:nil];
}
-(void)viewDidAppear:(BOOL)animated{
    txtDateTime.text = @"";
}
@end
