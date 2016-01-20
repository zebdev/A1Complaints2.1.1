//
//  ConcernInfoViewController.m
//  Hello_SOAP
//
//  Created by TaeIl Kim on 7/8/13.
//
//

#import "ConcernInfoViewController.h"
#import "Hello_SOAPViewController.h"
#import "Hello_SOAPAppDelegate.h"
#import "TicketDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+Toast.h"

@interface ConcernInfoViewController ()
{
    
      MBProgressHUD         * _theHud;
}


@end

@implementation ConcernInfoViewController
@synthesize table,imgView,btnAction,btnCall,btnClose,btnMessage,btnReject,lblBack,btnback,sAVC;
-(IBAction)bClickedCall:(id)sender{
    NSLog(@"%s",__FUNCTION__);
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    NSDictionary *parsed;
    
    parsed = [del.data1 objectAtIndex:0];
    
     if ([parsed objectForKey:@"phonenumber"]  != [NSNull null] && [parsed objectForKey:@"phonenumber"] !=nil) {
         
    NSString *tP = [NSString stringWithFormat:@"%@",[parsed objectForKey:@"phonenumber"] ];
    NSLog(@"%s tp:%@",__FUNCTION__,tP);
         
         if ([tP isEqualToString:@""]) {
              [self.view makeToast:@"No phone number Found."];
             return;
         
//                     UIAlertController * alert=   [UIAlertController
//                                           alertControllerWithTitle:@"ApoyarA1"
//                                           message:@"No phone number Found."
//                                           preferredStyle:UIAlertControllerStyleAlert];
//             
//             
//             UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
//                 
//                 //do something when click button
//             }];
//             [alert addAction:okAction];
//         
//             return;
             
         }
         
    //tP = [NSString stringWithFormat:@"%@",[tP stringByReplacingOccurrencesOfString:@"+" withString:@""]];
         
    NSString *phoneNumber = [NSString stringWithFormat:@"telprompt://%@",tP];
     NSLog(@"%@",phoneNumber);
         
    NSString *aPhoneNo = [@"telprompt://" stringByAppendingString:tP];
         if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:aPhoneNo]])
         {
             NSURL *url= [NSURL URLWithString:aPhoneNo];
             [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:@"isCalled"];
             [[UIApplication sharedApplication] openURL: url];

         }
     }
     else{
         UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"No Number Available" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
         [alert show];
     }
    

}
-(IBAction)bClickedClose:(id)sender{
      [self showHud:@"Loading"];
    if(flag==TRUE) return;

    if(!rVC){
        rVC = [[rejectViewController alloc]init];
    }
    rVC.desc = @"back2";
    rVC.lbltext=@"Close";
    [self performSegueWithIdentifier:@"show_reject" sender:self];


}

- (IBAction)btnNewClicked:(id)sender {
}

- (IBAction)btnOngoingClicked:(id)sender {
}

- (IBAction)btnClosedClicked:(id)sender {
}
-(IBAction)bClickedMessage:(id)sender{
    [self showHud:@"Loading"];
    if(flag==TRUE) return;
//    [self goCallBack:nil];
    if(!mVC){
        mVC = [[messageViewController alloc]init];
    }
    mVC.delegate = self;
    mVC.desc = @"back2";

    [self performSegueWithIdentifier:@"show_message" sender:self];
}
-(void)message:(NSString *)string {
  
    message = string;
}
-(IBAction)bClickedReject:(id)sender{
      [self showHud:@"Loading"];
    if(flag==TRUE) return;
    if(!rVC){
        rVC = [[rejectViewController alloc]init];
    }
    rVC.desc = @"back2";
    rVC.lbltext = @"Release";
        [self performSegueWithIdentifier:@"show_reject" sender:self];
    
//    rVC.lastString = @"Release";
}
-(IBAction)btnBack:(id)sender
{
   [self showHud:@"Loading..."];
    if(flag==TRUE) return;
    desc = @"btnBack";
    flag = TRUE;
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    [parser10 getTicketID:del.expertID];
    
}
-(IBAction)btnClickedAction:(id)sender{
    [self hideHud];
   [ self showHud:@"Loading..."];
    NSLog(@"%s",__FUNCTION__);
    if(flag==TRUE) return;
    desc = @"btnAction";
    flag = TRUE;
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    [parser10 getAllTicketDetails:del.ticID];
    
}
//-(id)init{
//    if(self = [super init])
//    {
//        self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        [self.view setFrame:CGRectMake(0, 0, 320, 568)];
//    }
//    return self;
//}
-(void)viewWillAppear:(BOOL)animated
{
    [self hideHud];
    Hello_SOAPAppDelegate* del = [UIApplication sharedApplication].delegate;
    
    NSDictionary *parsed = [del.data1 objectAtIndex:0];
    NSLog(@"%@",parsed);
    
    NSLog(@"Customer Name=%@",del.Customer_Name);
    NSLog(@"Store Name=%@",del.Store_name);
    
   NSLog(@"%s and isCalled %@",__FUNCTION__,[[NSUserDefaults standardUserDefaults] valueForKey:@"isCalled"]);
  if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isCalled"] isEqualToString:@"YES"]) {
        CTCallCenter *callCenter = [[CTCallCenter alloc]init];
        callCenter.callEventHandler = ^(CTCall* myCall){
            NSString *call = myCall.callState;
            static int a = 0;
            if([call isEqualToString:CTCallStateDisconnected]){
                
                if(a==2)
                {
                    a = 0;
                    return;//calling ok.
                }
                NSLog(@"Call has been disconnected.");
                a = 0;
                [self performSelectorOnMainThread:@selector(goCallBack:) withObject:nil waitUntilDone:YES];
            }
            else if([call isEqualToString:CTCallStateDialing])
            {
                NSLog(@"Call start");
                a = 1;
            }
            else if([call isEqualToString:CTCallStateConnected]){
                NSLog(@"Call has just been connected");
                
                NSDate *today = [NSDate date];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                // display in 12HR/24HR (i.e. 11:25PM or 23:25) format according to User Settings
                [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
                NSString *currentTime = [dateFormatter stringFromDate:today];
                
                Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
                parser10 = [[MyParserViewController alloc]init:self];
               
                [parser10 callbackTicket:del.expertID TicketID:del.ticID Description:currentTime];


               
                if(a==1)
                    a=2;
            }
            else if([call isEqualToString:CTCallStateIncoming]){
                NSLog(@"Call is incoming");
            }
            else{
                NSLog(@"None");
            }
        };
    }
    parser10 = [[MyParserViewController alloc]init:self];
    [self.table reloadData];
    flag = FALSE;
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
}
-(void)viewDidLayoutSubviews{
    [self showTables];
}
-(void)showTables{
    CGRect rt = [UIScreen mainScreen].bounds;
    CGRect rtTable;
    rtTable = l.frame;
    rtTable.size.height = rt.size.height - table.frame.size.height - table.frame.origin.y - btnCall.frame.size.height;
    rtTable.origin.y = table.frame.origin.y + table.frame.size.height;
    l.frame = rtTable;
    
    rtTable = btnCall.frame;
    rtTable.origin.y = rt.size.height - btnCall.frame.size.height;
    btnCall.frame = rtTable;
    
    rtTable = btnMessage.frame;
    rtTable.origin.y = rt.size.height - btnMessage.frame.size.height;
    btnMessage.frame = rtTable;
    
    rtTable = btnReject.frame;
    rtTable.origin.y = rt.size.height - btnReject.frame.size.height;
    btnReject.frame = rtTable;
    
    rtTable = btnClose.frame;
    rtTable.origin.y = rt.size.height - btnClose.frame.size.height;
    btnClose.frame = rtTable;
    
//    CGRect rt;
//    CGSize sz = [UIScreen mainScreen].bounds.size;
//    rt = self.view.layer.frame;
//    rt = [UIScreen mainScreen].bounds;
//    self.view.layer.frame = rt;
//    [self.lblBack setFrame:rt];
//
//    rt = CGRectMake(0, 0, sz.width, sz.height);
//    [self.lblBack setFrame:rt];
//
    
//    rt = self.table.frame;
////    rt.origin.y =sz.height/2 - 115;
//    rt.size.height = 288 - (568 - sz.height);
//    [self.table setFrame:rt];
//
//    rt = self.btnReject.frame;
//    rt.origin.y = sz.height - 60;
//    [self.btnReject setFrame:rt];
//    
//    rt = self.btnMessage.frame;
//    rt.origin.y = sz.height - 60;
//    [self.btnMessage setFrame:rt];
//    
//    rt = self.btnClose.frame;
//    rt.origin.y = sz.height - 60;
//    [self.btnClose setFrame:rt];
//    
//    rt = self.btnCall.frame;
//    rt.origin.y = sz.height - 60;
//    [self.btnCall setFrame:rt];
//    
//    rt = self.btnAction.frame;
//    rt.origin.y = sz.height - 120;
//    [self.btnAction setFrame:rt];
//
    
//    [[self.table layer] setBorderColor:[[UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0] CGColor]];
//    [self.table.layer setCornerRadius:10];
//    [[self.table layer] setBorderWidth:2];
    
//    self.table.hidden = NO;
}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"go_detail" sender:self];
//    TicketDetailViewController *ticketDetailViewController = [[TicketDetailViewController alloc] initWithNibName:@"TicketDetailViewController" bundle:nil];
//    [[self navigationController] pushViewController:ticketDetailViewController animated:YES];
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 480, tableView.rowHeight*2)];
//    tempView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:145/255.0 blue:35/255.0 alpha:1.0f];
//    UILabel *l;
//    float sWidth = [UIScreen mainScreen].bounds.size.width;
//        l = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, sWidth, tableView.rowHeight)];
//        l.text = @"   Concern Info";
//        l.backgroundColor = [UIColor clearColor];
//        [tempView addSubview:l];
//    return tempView;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 40;
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    Hello_SOAPAppDelegate* del = [UIApplication sharedApplication].delegate;
//    NSDictionary *parsed = [del.data1 objectAtIndex:0];
//    return parsed.count;
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0)
//        return 100;
        return 0;
    else
        return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CountryCell1";
//    NSArray *t1 = [[NSArray alloc]initWithObjects:@"TicketDescription",@"PKTicketId",@"TicketProblemTypeName",@"raisedby", @"Store", @"TicketTypeName",@"phonenumber", nil];
    NSArray *t1 = [[NSArray alloc]initWithObjects:@"TicketDescription", @"TicketProblemTypeName",@"Store",@"CustomerName",@"phonenumber", nil];
    
//    NSArray *t2 = [[NSArray alloc]initWithObjects:@"   Description", @"   ID", @"   Issue Type", @"   Raised By", @"   Store", @"   Type", @"   Phone Number", nil];
    NSArray *t2 = [[NSArray alloc]initWithObjects:@"Description", @"Type", @"Store", @"Customer", @"Phone", nil];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    else
    {
        [cell removeFromSuperview];
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    // Configure the cell...
    
    Hello_SOAPAppDelegate* del = [UIApplication sharedApplication].delegate;
    NSDictionary *parsed = [del.data1 objectAtIndex:0];
    NSLog(@"parsed=%@",parsed);
    UILabel *ll;
//    UITextView *l;
//    int temp=0;

    float sWidth = ([UIScreen mainScreen].bounds.size.width-15)/2;
    if(indexPath.row != 0){
        ll = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, sWidth, 44-4)];
        ll.text = t2[indexPath.row];
//        if(indexPath.row % 2 == 1)
//            ll.backgroundColor = [UIColor colorWithRed:151.0/255.0 green:214.0/255.0 blue:245.0/255.0 alpha:0.5];
//        else
//            ll.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    }
    else
    {
//        NSString *tmp = [parsed objectForKey:@"TicketDescription"];
//        l = [[UITextView alloc]initWithFrame:CGRectMake(10, table.frame.origin.y+table.frame.size.height+1, 306,[UIScreen mainScreen].bounds.size.height - (table.frame.origin.y+table.frame.size.height+1) - 110 )];
//        l.layer.borderColor = [UIColor redColor].CGColor;
//        l.layer.borderWidth = 1;
        [l setFont:[UIFont systemFontOfSize:16]];
        l.text = [parsed objectForKey:t1[0]];
        l.textAlignment = NSTextAlignmentLeft;
        l.editable=NO;
        [self.view addSubview:l];

        return cell;
    }
    [cell.contentView addSubview:ll];
    
    if(indexPath.row == 4)
    {
        NSLog(@"TextField1:  %@", tf.text);
            ll = [[UILabel alloc]initWithFrame:CGRectMake(sWidth, 10, sWidth, 44-14)];
            ll.text = [parsed objectForKey:t1[indexPath.row]];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView addSubview:ll];
//        tf.delegate = self;
    }
//    else if(indexPath.row==1)
//    {
//        ll.text=del.Store_name;
//    }
//    else if(indexPath.row==2)
//    {
//        ll.text=del.Customer_Name;
//    }
    else
    {
        if(indexPath.row == 0){
            ll = [[UILabel alloc]initWithFrame:CGRectMake(sWidth, 3, sWidth-5, 95)];
        }
        else
        {
            ll = [[UILabel alloc]initWithFrame:CGRectMake(sWidth, 0, sWidth, 44-4)];
        }
        
        if(indexPath.row==2)
        {
            //ll.text = [parsed objectForKey:t1[indexPath.row]];
            ll.text=del.Store_name;
        }
        else if(indexPath.row==3)
        {
            ll.text=del.Customer_Name;
        }
        else
        {
            ll.text = [parsed objectForKey:t1[indexPath.row]];
        }

//        if(indexPath.row % 2 == 1)
//            ll.backgroundColor = [UIColor colorWithRed:151.0/255.0 green:214.0/255.0 blue:245.0/255.0 alpha:0.5];
//        else
//            ll.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView addSubview:ll];
    }
    if(indexPath.row == 0)
    {
        ll.lineBreakMode = NSLineBreakByWordWrapping;
        ll.numberOfLines = 10;
        ll.textAlignment = NSTextAlignmentLeft;
    }
    
    return cell;
}

-(void)doneAction{
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    if([desc isEqualToString:@"btnBack"]){

        static int b = 0;

        NSMutableDictionary *parsed;
        NSDictionary *tempParsed;
        NSString *temp;
        if(b == 0){
            del.data1 = [NSMutableArray arrayWithArray:parser10.allData];
            do{
                temp = [[del.data1 objectAtIndex:b]objectForKey:@"PKTicketId"];
                b++;
                if(temp==nil) temp = @"";
            }while(([temp isEqualToString:@""]) && (del.data1.count>b));
            [parser10 getLocationName:temp];
        }else if(del.data1.count>b){
            parsed = [del.data1 objectAtIndex:b-1];
            tempParsed = [parser10.allData objectAtIndex:0];
            if([tempParsed objectForKey:@"GetLocationNameResult"]==nil)
                [parsed setObject:@"" forKey:@"Store"];
            else
                [parsed setObject:[tempParsed objectForKey:@"GetLocationNameResult"] forKey:@"Store"];
            do{
                temp = [[del.data1 objectAtIndex:b]objectForKey:@"PKTicketId"];
                b++;
                if(temp==nil) temp = @"";
            }while(([temp isEqualToString:@""]) && (del.data1.count>b));
            
            [parser10 getLocationName:temp];
        }else{
            parsed = [del.data1 objectAtIndex:b-1];
            tempParsed = [parser10.allData objectAtIndex:0];
            if([tempParsed objectForKey:@"GetLocationNameResult"]==nil)
                [parsed setObject:@"" forKey:@"Store"];
            else
                [parsed setObject:[tempParsed objectForKey:@"GetLocationNameResult"] forKey:@"Store"];
            b = 0;
            
            desc = @"";
            flag = FALSE;
            del.viewController.pinView.tGVC.isPrevious  = YES;
            [self.delegate dismissViewControllerAnimated:YES completion:nil];
//            [del.viewController.pinView.tGVC dismissViewControllerAnimated:YES completion:nil];
        }
    }
    if([desc isEqualToString:@"btnAction"]){
        del.data1 = [NSMutableArray arrayWithArray:parser10.allData];
        flag = FALSE;
        desc = @"";

        
        [self performSegueWithIdentifier:@"show_action" sender:self];
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
    [self prefersStatusBarHidden];
    CGRect rt = [UIScreen mainScreen].bounds;
    self.view.bounds = rt;
    self.view.superview.frame = rt;
    
    Hello_SOAPAppDelegate* del = [UIApplication sharedApplication].delegate;
    
    //////////change
    //NSDictionary *parsed = [del.data1 objectAtIndex:0];
    //NSLog(@"%@",parsed);
    //////////
//    lblID.text = [NSString stringWithFormat:@"%@%@", @"ID", [parsed objectForKey:@"PKTicketId"]];
    lblID.text = [NSString stringWithFormat:@"ID   %@",del.ticID];
    [super viewDidLoad];
    [self showTables];
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"isCalled"]) {
        [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:@"isCalled"];
    }
  //  NSString *html=[[NSUserDefaults standardUserDefaults] objectForKey:@"TicketDescription"];
    
    [web loadHTMLString: [[NSUserDefaults standardUserDefaults] objectForKey:@"TicketDescription"] baseURL:nil];
//    l.text =[[NSUserDefaults standardUserDefaults] objectForKey:@"TicketDescription"];
    // Do any additional setup after loading the view from its nib.
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
        glbAppdel.parentvc=self;
    if([segue.identifier isEqualToString:@"show_message"])
    {
        messageViewController *mVC1 =segue.destinationViewController;
        mVC1.delegate = self;
        mVC1.desc = @"back2";

//        [self performSegueWithIdentifier:@"show_message" sender:self];
    }
    else if ([segue.identifier isEqualToString:@"show_reject"])
    {
        rejectViewController *reject =segue.destinationViewController;
        reject.desc=rVC.desc;
        reject.lbltext=rVC.lbltext;
        
    }
}

-(void)goCallBack:(id)sender{
    [[NSUserDefaults standardUserDefaults] setValue:@"NO" forKey:@"isCalled"];

    [self performSegueWithIdentifier:@"show_selectaction" sender:self];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"%@",tf.text);
    if(flag == TRUE) return;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1.0];
        [self.table setContentOffset:CGPointMake(0, 100)];
        [UIView commitAnimations];
        flag = FALSE;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(flag == TRUE) NO;
    [textField resignFirstResponder];
    //        if(flag == FALSE){
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [self.table setContentOffset:CGPointMake(0,0)];
    [UIView commitAnimations];
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    NSDictionary *parsed = [del.data1 objectAtIndex:0];
    NSLog(@"%@:%@",tf.text,[parsed objectForKey:@"PKTicketId"]);
    desc = @"";
    [parser10 updateCustomerPhonenumber:del.expertID CustomerID:[parsed objectForKey:@"PKTicketId"] PhoneNumber:tf.text];
//    flag = TRUE;
    //        }
	return YES;
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
    [btnNew release];
    [btnOngoing release];
    [btnClosed release];
    [l release];
    [super dealloc];
}
@end
