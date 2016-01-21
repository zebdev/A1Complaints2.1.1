//
//  ticketGridViewController.m
//  Hello_SOAP
//
//  Created by TaeIl Kim on 6/18/13.
//
//

#import "ticketGridViewController.h"
//#import "Cell.h"
#import "Screen3GridViewController.h"
#import "Hello_SOAPAppDelegate.h"
#import "Hello_SOAPViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MNMBottomPullToRefreshManager.h"
#import "MBProgressHUD.h"
#import "MyParserViewController.h"
#import "MBProgressHUD.h"

@interface ticketGridViewController ()
{
    MBProgressHUD *_theHud;
}

@end

@implementation ticketGridViewController
@synthesize table, expertID, parser2, concernInfo, imgView;

@synthesize newitemArr,ongoingArr,closedArr,TempDict,TempArr,isPrevious;


-(id)init:(NSString *)expID{
    if(self = [super init]){
        expertID = expID;
    }
    return self;
}
-(void)filteralldata{
    [self.newitemArr removeAllObjects];
    [self.ongoingArr removeAllObjects];
    [self.closedArr removeAllObjects];
    
    Hello_SOAPAppDelegate* del = [UIApplication sharedApplication].delegate;
    NSLog(@"%s del:%@",__FUNCTION__,del.data1);
    
    NSLog(@"refresh array count=%lu",(unsigned long)del.data1.count);
    for (int i=0; i<[del.data1 count]; i++) {
        if ([[[del.data1 objectAtIndex:i] valueForKey:@"TicketStatusName"] isEqualToString:@"Closed"] ||[[[del.data1 objectAtIndex:i] valueForKey:@"TicketStatusName"] isEqualToString:@"Resolved"] ) {
            [self.closedArr addObject:[del.data1 objectAtIndex:i]];
            
        }
//        else if( [[[del.data1 objectAtIndex:i] valueForKey:@"TicketStatusName"] caseInsensitiveCompare:@"Waiting"] == NSOrderedSame|| [[[del.data1 objectAtIndex:i] valueForKey:@"TicketStatusName"] caseInsensitiveCompare:@"assigned"] == NSOrderedSame)
        else if( [[[del.data1 objectAtIndex:i] valueForKey:@"ticketverified"]boolValue]==false)
        {
            [self.newitemArr addObject:[del.data1 objectAtIndex:i]];
        }
        else
            [self.ongoingArr addObject:[del.data1 objectAtIndex:i]];
        
        
    }

}
-(void)viewWillAppear:(BOOL)animated
{
    //code copy and past from viewDidLoad
    [self filteralldata];
    self.TempArr=self.newitemArr;
    self.TempDict=[self.newitemArr mutableCopy];
    ////////////////
    refFlag = FALSE;
    //pavanfix
//    if ([TempArr count]==0) {
//        [btnNew setSelected:YES];
//        return;
//    }

    
    parser2 = [[MyParserViewController alloc]init:self];
    
    [self.table reloadData];
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    if (isPrevious)
    {
        [self onRefresh:btnRefresh];
    }
    
    [pullToRefreshManager  tableViewReloadFinished];
    
    if(pullToRefreshManager==NULL)
    {
        id client =self;
        pullToRefreshManager = [[MNMBottomPullToRefreshManager alloc] initWithPullToRefreshViewHeight:60.0f tableView:table withClient:client];
        
    }
    
    if([glbAppdel.Selected_Category isEqualToString:@"1"])
    {
        [self btnNewClicked:nil];
    }
    else if([glbAppdel.Selected_Category isEqualToString:@"2"])
    {
        [self btnOngoingClicked:nil];
    }
    else
    {
        [self btnClosedClicked:nil];
    }
    
    //[self showTables];
    [self refreshTable];
    
}
//-(IBAction)onSettings:(id)sender{
//   
//    if(refFlag == TRUE) return;
//    [glbAppdel.parentvc  dismissViewControllerAnimated:YES completion:nil];
//    
//}
-(IBAction)onRefresh:(id)sender
{
    if(refFlag == TRUE) return;
    
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    
    if(PullToRefreshFlag==TRUE)
    {
        PullToRefreshFlag=FALSE;
        int pageno;
        pageno=(int)[del.Page_new integerValue];
        pageno=pageno+1;
        del.Page_new=[NSString stringWithFormat:@"%d",pageno];
        del.Status_For_Ticket=@"-1";
    }
       del.Status_For_Ticket=@"-1";
//    [del.data1 removeAllObjects];
    [TempDict removeAllObjects];
//    [del.viewController.pinView dismissViewControllerAnimated:YES completion:nil];
    refFlag = TRUE;
    [parser2 getTicketID:del.expertID];
}
/*-(void)viewDidLayoutSubviews{
    
}*/
-(void)showTables
{
    CGRect rt = [UIScreen mainScreen].bounds;
    /*CGRect rtTable = table.frame;
//    rtTable.origin.y =90;
    
    rtTable.size.height = rt.size.height-btnNew.frame.size.height-rtTable.origin.y;
    NSLog(@"Table: %f,%f,%f,%f", rtTable.origin.x, rtTable.origin.y, rtTable.size.width, rtTable.size.height);
    [table setFrame:rtTable];
    NSLog(@"****** y=%f and height=%f",table.frame.origin.y,table.frame.size.height);
    
    rtTable = btnNew.frame;
    rtTable.origin.y = rt.size.height - btnNew.frame.size.height;
        NSLog(@"New: %f,%f,%f,%f", rtTable.origin.x, rtTable.origin.y, rtTable.size.width, rtTable.size.height);
    [btnNew setFrame:rtTable];
    NSLog(@"Button****** y=%f and height=%f",btnNew.frame.origin.y,btnNew.frame.size.height);
    NSLog(@"Table****** y=%f and height=%f",table.frame.origin.y,table.frame.size.height);
    
    rtTable = btnOngoing.frame;
    rtTable.origin.y = rt.size.height - btnNew.frame.size.height;
        NSLog(@"Ongoing: %f,%f,%f,%f", rtTable.origin.x, rtTable.origin.y, rtTable.size.width, rtTable.size.height);
    [btnOngoing setFrame:rtTable];
    NSLog(@"Button****** y=%f and height=%f",btnOngoing.frame.origin.y,btnOngoing.frame.size.height);
    NSLog(@"****** y=%f and height=%f",table.frame.origin.y,table.frame.size.height);
    
    rtTable = btnClosed.frame;
    rtTable.origin.y = rt.size.height - btnNew.frame.size.height;
        NSLog(@"Closed: %f,%f,%f,%f", rtTable.origin.x, rtTable.origin.y, rtTable.size.width, rtTable.size.height);
    [btnClosed setFrame:rtTable];
    NSLog(@"Button****** y=%f and height=%f",btnClosed.frame.origin.y,btnClosed.frame.size.height);
    NSLog(@"****** y=%f and height=%f",table.frame.origin.y,table.frame.size.height);*/
    
    rt.size.height = rt.size.height-150;
    rt.origin.y=table.frame.origin.y;
    NSLog(@"rt y=%f and rt height=%f",rt.origin.y,rt.size.height);
    table.frame=rt;
    
}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 51;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    if ([self.TempDict count]==0) {
        hiddenlable.hidden=NO;
        hiddenlable.text=@"No Concerns to Show";
        
        
    }
    
    return [self.TempDict count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CountryCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }else{
        [cell removeFromSuperview];
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    // Configure the cell...//,@"LastChanged"
    
    NSArray *a = [[NSMutableArray alloc]initWithObjects:@"PKTicketId",@"Store",@"CustomerName", nil];
    
  //  float wi[3] = {40.0,70.0,150};
    float wi[3] = {40.0,130.0,150};
    float ww;
    Hello_SOAPAppDelegate* del = [UIApplication sharedApplication].delegate;
    NSDictionary *parsed = [self.TempArr objectAtIndex:indexPath.row];//[del.data1 objectAtIndex:indexPath.row];
    NSLog(@"parse Dict %@ and parsed %@",[del.data1 objectAtIndex:indexPath.row],parsed);
    
    UILabel *l;
    ww = 10;
    
    for(int i = 0; i < a.count; i++){
        l = [[UILabel alloc]initWithFrame:CGRectMake(ww, 0, wi[i],44)];
        l.numberOfLines=4;
        //[l setTextColor:[UIColor colorWithRed:0 green:102 blue:255 alpha:1]];
        
        ww += wi[i];
        
        l.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:11.f];
        l.text = [parsed objectForKey:[a objectAtIndex:i]];
        
        [cell.contentView addSubview:l];
    }
    if([[parsed objectForKey:@"TicketStatusName"]isEqualToString:filterString])
    {
       // [cell.contentView setBackgroundColor:[UIColor colorWithRed:0.2196 green:0.55294 blue:0.8 alpha:0.25]];
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        
//        [cell setBackgroundColor:];
    }else{
        [cell.contentView setBackgroundColor:[UIColor whiteColor]];
    }
    [self hideHud];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(refFlag == TRUE) return;
    
    Hello_SOAPAppDelegate* del = [UIApplication sharedApplication].delegate;
    NSDictionary *parsed = [self.TempArr objectAtIndex:indexPath.row];//[del.data1 objectAtIndex:indexPath.row];
    storeName = [parsed objectForKey:@"Store"];
    del.Store_name=[parsed objectForKey:@"Store"];
    NSLog(@"Store Name=%@",storeName);
    customerName = [parsed objectForKey:@"CustomerName"];
    del.Customer_Name= [parsed objectForKey:@"CustomerName"];
    NSLog(@"CustomerName=%@",customerName);
    
    del.ticID = [parsed objectForKey:@"PKTicketId"];
    NSLog(@"ticID=%@",del.ticID);
    
    [[NSUserDefaults standardUserDefaults]setObject:[parsed objectForKey:@"PKTicketId"] forKey:@"PKTicketId"];
     [[NSUserDefaults standardUserDefaults]setObject:[parsed objectForKey:@"TicketDescription"] forKey:@"TicketDescription"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [parser2 getTicketInformation:del.ticID];
}
-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section   {
    
    NSString *message = @"";
    NSInteger numberOfRowsInSection = [self tableView:self.table numberOfRowsInSection:section ];
    
    if (numberOfRowsInSection == 0) {
        message = @"No Concerns to Show";
    }
    
    return message;
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
    hiddenlable.hidden=YES;
    [self prefersStatusBarHidden];
//    HUD=[[MBProgressHUD alloc] initWithView:self.navigationController.view];
//    [self.navigationController.view addSubview:HUD];
//    [HUD hide:YES];
    
    filterString = @"Waiting";
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    
    status_for_ticket=@"-1";
    del.Status_For_Ticket=@"-1";
    self.newitemArr=[[NSMutableArray alloc] init];
    self.ongoingArr=[[NSMutableArray alloc] init];
    self.closedArr=[[NSMutableArray alloc] init];
    self.TempDict=[[NSMutableDictionary alloc] init];
    self.TempArr=[[NSMutableArray alloc] init];
 
    isid=YES;
    isstore=YES;
    iscustomer=YES;
    
    PullToRefreshFlag=FALSE;
    
   
    [super viewDidLoad];
    
    //    NSDictionary *parsed = [del.data1 objectAtIndex:indexPath.row];
    
    // Do any additional setup after loading the view from its nib.
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)doneAction
{
    static int b = 0;
    
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    NSMutableDictionary *parsed;
    NSDictionary *tempParsed;
    NSString *temp;
    
    if(refFlag==TRUE)
    {
        if(b == 0)
        {
            del.data1 = [NSMutableArray arrayWithArray:parser2.allData];
            do
            {
                temp = [[del.data1 objectAtIndex:b]objectForKey:@"PKTicketId"];
                b++;
            }while([temp isEqualToString:@""]);
            [parser2 getLocationName:temp];
            [self refreshTable];
        }
        else if(del.data1.count>b)
        {
            parsed = [del.data1 objectAtIndex:b-1];
            tempParsed = [parser2.allData objectAtIndex:0];
            if([tempParsed objectForKey:@"GetLocationNameResult"]==nil)
                [parsed setObject:@"" forKey:@"Store"];
            else
                [parsed setObject:[tempParsed objectForKey:@"GetLocationNameResult"] forKey:@"Store"];
            do
            {
                temp = [[del.data1 objectAtIndex:b]objectForKey:@"PKTicketId"];
                b++;
            }while([temp isEqualToString:@""]);
            [parser2 getLocationName:temp];
        }
        else
        {
            parsed = [del.data1 objectAtIndex:b-1];
            tempParsed = [parser2.allData objectAtIndex:0];
            if([tempParsed objectForKey:@"GetLocationNameResult"]==nil)
                [parsed setObject:@"" forKey:@"Store"];
            else
                [parsed setObject:[tempParsed objectForKey:@"GetLocationNameResult"] forKey:@"Store"];
            b = 0;
            [self.table reloadData];
            [pullToRefreshManager  tableViewReloadFinished];
            [pullToRefreshManager relocatePullToRefreshView];
            refFlag = FALSE;
        }
    }
    else
    {
        del.data1 = [NSMutableArray arrayWithArray:parser2.allData];
        [[del.data1 objectAtIndex:0] setObject:storeName forKey:@"Store"];
        [[del.data1 objectAtIndex:0] setObject:customerName forKey:@"CustomerName"];
        [self performSegueWithIdentifier:@"show_conern" sender:self];

    }
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
        glbAppdel.parentvc=self;
    if([segue.identifier isEqualToString:@"show_conern"])
    {
        ConcernInfoViewController *info =segue.destinationViewController;
        info.delegate =self;
    }
}
-(IBAction)btnNewClicked:(id)sender
{  // [self showHud:@"Loading"];
    [pullToRefreshManager  tableViewReloadFinished];
    
    Hello_SOAPAppDelegate* del = [UIApplication sharedApplication].delegate;
    del.Selected_Category=@"1";
    
    status_for_ticket=@"-1";
    del.Status_For_Ticket=@"-1";
    filterString = @"Waiting";
    
    self.TempDict=[self.newitemArr mutableCopy];
    self.TempArr=self.newitemArr;

    [btnNew setSelected:YES];
    [btnOngoing setSelected:NO];
    [btnClosed setSelected:NO];
    
    NSLog(@"total count=%lu",(unsigned long)[TempArr count]);
    
//    if ([TempArr count]==0) {
//        //[self hideHud];
//        //[table reloadData];
//        return;
//    }
        [self onRefresh:sender];
    [table reloadData];

//    [pullToRefreshManager relocatePullToRefreshView];
    
    /*if([TempArr count]==0)
    {
        [pullToRefreshManager setHidden:YES];
    }
    else
    {
        [pullToRefreshManager setHidden:NO];
    }*/
}

- (IBAction)btnOngoingClicked:(id)sender
{
    
    
//    [pullToRefreshManager  tableViewReloadFinished];
              Hello_SOAPAppDelegate* del = [UIApplication sharedApplication].delegate;
    del.Selected_Category=@"2";
    
    status_for_ticket=@"-2";
  
 
    del.Status_For_Ticket=@"-2";
    filterString = @"Work In Progress";
    
    self.TempDict=[self.ongoingArr mutableCopy];
    self.TempArr=self.ongoingArr;

    [btnNew setSelected:NO];
    [btnOngoing setSelected:YES];
    [btnClosed setSelected:NO];
    
    NSLog(@"total count=%lu",(unsigned long)[TempArr count]);
    [self onRefresh:sender];

    [table reloadData];
    
    //set pullToRefreshManager
//    [pullToRefreshManager relocatePullToRefreshView];
    
    /*if([TempArr count]==0)
    {
        [pullToRefreshManager setHidden:YES];
    }
    else
    {
        [pullToRefreshManager setHidden:NO];
    }*/
}

- (IBAction)btnClosedClicked:(id)sender
{
   
    
//    [pullToRefreshManager  tableViewReloadFinished];
    
    Hello_SOAPAppDelegate* del = [UIApplication sharedApplication].delegate;
    del.Selected_Category=@"3";
    
    status_for_ticket=@"5";
       del.Status_For_Ticket=@"5";
    filterString = @"Closed";
    self.TempDict=[self.closedArr mutableCopy];
    self.TempArr=self.closedArr;

    [btnNew setSelected:NO];
    [btnOngoing setSelected:NO];
    [btnClosed setSelected:YES];
    
    NSLog(@"total count=%lu",(unsigned long)[TempArr count]);
       [self onRefresh:sender];
    [table reloadData];
    
    //set pullToRefreshManager
//    [pullToRefreshManager relocatePullToRefreshView];
    
    /*if([TempArr count]==0)
    {
        [pullToRefreshManager setHidden:YES];
    }
    else
    {
        [pullToRefreshManager setHidden:NO];
    }*/
   
    
}

- (void)dealloc {
    [btnNew release];
    [btnOngoing release];
    [btnClosed release];
    [super dealloc];
}
-(void)refreshTable
{
    [self filteralldata];
    self.TempArr=self.newitemArr;
    self.TempDict=[self.newitemArr mutableCopy];
    

    
    if ([filterString isEqualToString:@"Waiting"]) {
        [self btnNewClicked:btnNew];
    } else if ([filterString isEqualToString:@"Work In Progress"]) {
        [self btnOngoingClicked:btnOngoing];
    } else {
        [self btnClosedClicked:btnClosed];
    }
    
    [self showTables];
    //[btnNew setSelected:YES];
//    [btnClosed setSelected:NO];
//    [btnOngoing setSelected:NO];
}
#pragma  mark - Header Button Clicked
- (IBAction)btnheadingClicked:(id)sender
{
    if ([sender tag]==0) {
        //  sorting by id
        NSSortDescriptor *sortByName;
        
        if (isid) {
            isid=NO;
             sortByName=[NSSortDescriptor sortDescriptorWithKey:@"PKTicketId" ascending:YES];
        }
        else{
            isid=YES;
            sortByName = [NSSortDescriptor sortDescriptorWithKey:@"PKTicketId" ascending:NO];
        }
        
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
        
        NSArray *sortedArray = [self.TempArr sortedArrayUsingDescriptors:sortDescriptors];
        
        self.TempArr=[[NSMutableArray alloc] initWithArray:sortedArray];
        
        [table reloadData];
    }
    else if([sender tag]==1)
    {// sort store
        
        NSSortDescriptor *sortByName;
        
        if (isstore) {
            isstore=NO;
            sortByName=[NSSortDescriptor sortDescriptorWithKey:@"Store" ascending:YES];
        }
        else{
            isstore=YES;
            sortByName = [NSSortDescriptor sortDescriptorWithKey:@"Store" ascending:NO];
        }
        
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
        
        NSArray *sortedArray = [self.TempArr sortedArrayUsingDescriptors:sortDescriptors];
        
        self.TempArr=[[NSMutableArray alloc] initWithArray:sortedArray];
        
        [table reloadData];

    }
    else if([sender tag]==2)
    {// sort customer
      
        NSSortDescriptor *sortByName;
        
        if (iscustomer) {
            iscustomer=NO;
            sortByName=[NSSortDescriptor sortDescriptorWithKey:@"CustomerName" ascending:YES];
        }
        else{
            iscustomer=YES;
            sortByName = [NSSortDescriptor sortDescriptorWithKey:@"CustomerName" ascending:NO];
        }
        
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
        
        NSArray *sortedArray = [self.TempArr sortedArrayUsingDescriptors:sortDescriptors];
        
        self.TempArr=[[NSMutableArray alloc] initWithArray:sortedArray];
        
        [table reloadData];

    }
}

#pragma mark -
#pragma mark MNMBottomPullToRefreshManagerClient

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [HUD  setHidden:NO];
    [pullToRefreshManager relocatePullToRefreshView];
}
/**
 * This is the same delegate method as UIScrollView but required in MNMBottomPullToRefreshManagerClient protocol
 * to warn about its implementation. Here you have to call [MNMBottomPullToRefreshManager tableViewScrolled]
 *
 * Tells the delegate when the user scrolls the content view within the receiver.
 *
 * @param scrollView: The scroll-view object in which the scrolling occurred.
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [pullToRefreshManager tableViewScrolled];
}

/**
 * This is the same delegate method as UIScrollView but required in MNMBottomPullToRefreshClient protocol
 * to warn about its implementation. Here you have to call [MNMBottomPullToRefreshManager tableViewReleased]
 *
 * Tells the delegate when dragging ended in the scroll view.
 *
 * @param scrollView: The scroll-view object that finished scrolling the content view.
 * @param decelerate: YES if the scrolling movement will continue, but decelerate, after a touch-up gesture during a dragging operation.
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [pullToRefreshManager tableViewReleased];
}

/**
 * Tells client that refresh has been triggered
 * After reloading is completed must call [MNMBottomPullToRefreshManager tableViewReloadFinished]
 *
 * @param manager PTR manager
 */
- (void)bottomPullToRefreshTriggered:(MNMBottomPullToRefreshManager *)manager
{
    isPullForMore=YES;
    //[HUD  setHidden:YES];
    [self performSelector:@selector(loadTable) withObject:nil afterDelay:1.0f];
}
- (void)loadTable
{
//    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
//    
//    int pageno;
//    
//    if([status_for_ticket isEqualToString:@"-1"])
//    {
//        pageno=[del.Page_new integerValue];
//        pageno=pageno+1;
//        del.Page_new=[NSString stringWithFormat:@"%d",pageno];
//    }
//    else if ([status_for_ticket isEqualToString:@"-2"])
//    {
//        
//        pageno=[del.Page_new integerValue];
//        pageno=pageno+1;
//        del.Page_new=[NSString stringWithFormat:@"%d",pageno];
//        
//        /*pageno=[del.Page_ongoing integerValue];
//        pageno=pageno+1;
//        del.Page_ongoing=[NSString stringWithFormat:@"%d",pageno];*/
//    }
//    else
//    {
//        pageno=[del.Page_new integerValue];
//        pageno=pageno+1;
//        del.Page_new=[NSString stringWithFormat:@"%d",pageno];
//        
//        /*pageno=[del.Page_Close integerValue];
//        pageno=pageno+1;
//        del.Page_Close=[NSString stringWithFormat:@"%d",pageno];*/
//    }
//    
//    del.Status_For_Ticket=status_for_ticket;
//    
//    NSLog(@"parser status=%@",parser2.Status_for_ticket);
    
    PullToRefreshFlag=TRUE;
    
    [self onRefresh:nil];
    
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
