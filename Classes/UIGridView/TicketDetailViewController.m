//
//  TicketDetailViewController.m
//  ApoyarA1 Complaints V2
//
//  Created by Keshav on 25/04/14.
//
//

#import "TicketDetailViewController.h"
#import "Hello_SOAPAppDelegate.h"
#import "Hello_SOAPViewController.h"
#import "NSString+stripHtml.h"
#import "ConcernInfoViewController.h"
@interface TicketDetailViewController ()

@end

@implementation TicketDetailViewController
@synthesize  btnBack,lblID,marrData,lblDate,lblDescription,lblWho,svTicket;
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
       // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    NSLog(@"marrData %@",marrData);
    
//    NSDate *date = [marrData valueForKey:@"DateAdded"]
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSDate *date = [dateFormat dateFromString:[marrData valueForKey:@"DateAdded"]];
    NSLog(@"date %@",date);
    [dateFormat setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    
    lblDate.text = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:date]];
    lblWho.text = [marrData valueForKey:@"AddedBY"];
    lblDescription.text = [[marrData valueForKey:@"Description"] stripHtml];
    lblDescription.numberOfLines = 0;
    [lblDescription sizeToFit];
    lblID.text = [NSString stringWithFormat:@"ID %@",[marrData valueForKey:@"PKTicketDetailID"]];
    [svTicket setContentSize:CGSizeMake(svTicket.frame.size.width,(178+lblDescription.frame.origin.y+lblDescription.frame.size.height))];
}
- (IBAction)btnBackClicked:(id)sender {
    if(flag == TRUE)return;
    desc = @"back";
    flag = TRUE;
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    [parser11 getTicketInformation:del.ticID];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [lblDate release];
    [lblWho release];
    [lblDescription release];
    [svTicket release];
    [super dealloc];
}
@end
