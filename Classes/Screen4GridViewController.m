//
//  Screen4GridViewController.m
//  Hello_SOAP
//
//  Created by TaeIl Kim on 6/19/13.
//
//

#import "Screen4GridViewController.h"
//#import "pinInputViewController.h"
#import "Hello_SOAPViewController.h"
#import "ticketGridViewController.h"
#import "Cell.h"

@interface Screen4GridViewController ()

@end

@implementation Screen4GridViewController
@synthesize tGVC,occ,txtDateTime, txtClose, txtMessage, sv;
-(IBAction)onOK:(id)sender{
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
     parser4 = [[MyParserViewController alloc]init:self];
     //    [parser4 getTicketID:del.expertID];
     [parser4 callTicket:del.expertID TicketID:del.ticID Description:txtDateTime.text];
}
-(IBAction)setDateTime:(id)sender{
    NSDate *d = [occ getSelectedDate];
    NSTimeInterval secondsPerDay = 8 * 60 * 60;
    NSDate *today = [d dateByAddingTimeInterval:secondsPerDay]; //addTimeInterval:secondsPerDay];
    [occ.view setHidden:YES];
//    [occ release];
//    [self dismissViewControllerAnimated:YES completion:nil];
    txtDateTime.text = today.description;
    NSLog(@"%@",today);
}
-(IBAction)showCalendar:(id)sender{
    if(!occ){
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    occ = [[OCCalendarViewController alloc] initAtPoint:CGPointMake(167, 210) inView:self.view arrowPosition:OCArrowPositionCentered];
    occ.delegate = self;
    occ.selectionMode = OCSelectionSingleDate;
//    [self presentViewController:occ animated:YES completion:nil];
    
        
        
//        NSLocale* currentLocale = [NSLocale currentLocale];
//        [[NSDate date] descriptionWithLocale:currentLocale];
        NSDate *sDate = [NSDate date];
        NSDate *eDate = [NSDate date];
        
//        NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
//        [DateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
//        NSLog(@"%@",[DateFormatter stringFromDate:[NSDate date]]);
 
/*    NSDateComponents *dateParts = [[NSDateComponents alloc] init];
	[dateParts setMonth:5];
	[dateParts setYear:2012];
	[dateParts setDay:8];
    
	NSDate *sDate = [calendar dateFromComponents:dateParts];
	[dateParts release];
    
    dateParts = [[NSDateComponents alloc] init];
	[dateParts setMonth:5];
	[dateParts setYear:2012];
	[dateParts setDay:14];
    
	NSDate *eDate = [calendar dateFromComponents:dateParts];
	[dateParts release];*/
    
    [occ setStartDate:sDate];
    [occ setEndDate:eDate];
    //Add to the view.
    [self.view addSubview:occ.view];
    }
    [occ.view setHidden:NO];
}
-(IBAction)onClicked:(id)sender{
/*    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    parser4 = [[MyParserViewController alloc]init:self];
//    [parser4 getTicketID:del.expertID];
    [parser4 callTicket:del.expertID TicketID:del.ticID Description:@"Call Back OK"];*/
    [self showCalendar:sender];
}
- (BOOL) textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [sv setContentOffset:CGPointMake(0,0)];
    [UIView commitAnimations];
    flag = TRUE;
    
	return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [sv setContentOffset:CGPointMake(0,0)];
        [UIView commitAnimations];
        flag = TRUE;
        
        return FALSE;
    }
    return TRUE;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{

    if(textField == txtClose){
        if(flag == TRUE){
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:1.0];
            [sv setContentOffset:CGPointMake(0, 200)];
            [UIView commitAnimations];
            flag = FALSE;
        }
    }
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    if(flag == TRUE){
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1.0];
        [sv setContentOffset:CGPointMake(0, 100)];
        [UIView commitAnimations];
        flag = FALSE;
    }
}
-(void)doneAction{
    static int flg = 1;
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    if(flg==1){
        flg = 2;
//        [parser4.allData removeAllObjects];
//        [parser4 getTicketID:del.expertID];
        [parser4 messageTicket:del.expertID TicketID:del.ticID Description:txtMessage.text];
    }else if(flg==2){
        [parser4 closeTicket:del.expertID TicketID:del.ticID Description:txtClose.text];
        flg = 3;
        
//        [del.data1 removeAllObjects];
//        del.data1 = [NSMutableArray arrayWithArray:parser4.allData];
//        [del.data2 removeAllObjects];
//        del.data2 = [[NSMutableArray alloc]init];
//        if(!tGVC)
//            tGVC = [[ticketGridViewController alloc]init];
////        [self presentViewController:tGVC animated:YES completion:nil];
//        Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
//        [del.viewController.pinView.tGVC dismissViewControllerAnimated:YES completion:nil];
    }else if(flg == 3){
        [parser4 getTicketID:del.expertID];
        flg = 4;
    }else if(flg == 4){
        [del.data1 removeAllObjects];
        del.data1 = [NSMutableArray arrayWithArray:parser4.allData];
        [del.data2 removeAllObjects];
        del.data2 = [[NSMutableArray alloc]init];
        if(!tGVC)
            tGVC = [[ticketGridViewController alloc]init];
//        [self presentViewController:tGVC animated:YES completion:nil];
        Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
        [del.viewController.pinView.tGVC dismissViewControllerAnimated:YES completion:nil];
        flg = 1;
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
    flag = TRUE;
    // Do any additional setup after loading the view from its nib.
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    Hello_SOAPAppDelegate* del = [UIApplication sharedApplication].delegate;
    tGVC = del.viewController.pinView.tGVC;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark OCCalendarDelegate Methods

- (void)completedWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterShortStyle];
    
    NSLog(@"startDate:%@, endDate:%@", startDate, endDate);
    
    [self showToolTip:[NSString stringWithFormat:@"%@ - %@", [df stringFromDate:startDate], [df stringFromDate:endDate]]];
    
    [df release];
    
    [occ.view removeFromSuperview];
    
    occ.delegate = nil;
    [occ release];
    occ = nil;
}

-(void) completedWithNoSelection{
    [occ.view removeFromSuperview];
    occ.delegate = nil;
    [occ release];
    occ = nil;
}


#pragma mark -
#pragma mark Prettifying Methods...


//Create our little toast notifications.....
- (void)showToolTip:(NSString *)str {
    if(toolTipLabel) {
        [toolTipLabel removeFromSuperview];
        toolTipLabel = nil;
    }
    toolTipLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(self.view.frame.size.width-260.0, self.view.frame.size.height-35.0, 250.0, 25) ];
    toolTipLabel.textAlignment = NSTextAlignmentCenter;
    toolTipLabel.textColor = [UIColor whiteColor];
    toolTipLabel.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
//    toolTipLabel.layer.cornerRadius = 5.0f;
    toolTipLabel.font = [UIFont fontWithName:@"Helvetica" size:(16.0)];
    toolTipLabel.text = str;
    
    toolTipLabel.alpha = 0.0f;
    
    [self.view addSubview:[toolTipLabel autorelease]];
    
    [UIView beginAnimations:@"fadeInToolTip" context:nil];
    [UIView setAnimationDuration:0.1f];
    toolTipLabel.alpha = 1.0f;
    [UIView commitAnimations];
    
    [self performSelector:@selector(fadeOutToolTip) withObject:nil afterDelay:2.5f];
}
- (void)fadeOutToolTip {
    if(toolTipLabel) {
        [UIView beginAnimations:@"fadeOutToolTip" context:nil];
        [UIView setAnimationDuration:0.1f];
        toolTipLabel.alpha = 0.0f;
        [UIView commitAnimations];
        [toolTipLabel performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.1f];
        
        toolTipLabel = nil;
    }
}
#pragma mark -
#pragma mark Gesture Recognizer

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGPoint insertPoint = [touch locationInView:self.view];
    
    occ = [[OCCalendarViewController alloc] initAtPoint:insertPoint inView:self.view arrowPosition:OCArrowPositionCentered selectionMode:OCSelectionSingleDate];
    occ.delegate = self;
    [self.view addSubview:occ.view];
    
    return YES;
}

@end
