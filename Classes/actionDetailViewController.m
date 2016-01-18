//
//  actionDetailViewController.m
//  Hello_SOAP
//
//  Created by TaeIl Kim on 7/8/13.
//
//

#import "actionDetailViewController.h"
#import "Hello_SOAPAppDelegate.h"
#import "Hello_SOAPViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "TicketDetailViewController.h"
@interface actionDetailViewController ()

@end

@implementation actionDetailViewController
@synthesize btnBack,btnRefresh,lblBack,table;

-(IBAction)actionBack:(id)sender{
    //    Hello_SOAPAppDelegate *del =
    if(flag == TRUE)return;
    desc = @"back";
    flag = TRUE;
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    [parser11 getTicketInformation:del.ticID];
}
-(IBAction)actionRefresh:(id)sender{
    if(flag == TRUE) return;
    desc = @"refresh";
    flag = TRUE;
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    [parser11 getAllTicketDetails:del.ticID];
    
    //    desc = @"";
}
-(void)viewWillAppear:(BOOL)animated{
    //    if(!parser11)
    parser11 = [[MyParserViewController alloc]init:self];
    //    [table setAllowsSelection:YES];
    [self.table reloadData];
    flag = FALSE;
    //    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    if(!sizes){
        sizes = [[NSMutableDictionary alloc]init];
    }
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    return del.data1.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
    NSNumber *intval;
    if(indexPath.row>=2)
    {
        Hello_SOAPAppDelegate* del = [UIApplication sharedApplication].delegate;
        NSDictionary *parsed = [del.data1 objectAtIndex:indexPath.row];
        NSString *tmp = [parsed objectForKey:@"Description"];
        CGSize expectedLabelSize;
        
        UILabel *gettingSizeLabel = [[UILabel alloc] init];
        gettingSizeLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13.0f] ; // Your Font-style whatever you want to use.
        gettingSizeLabel.text = tmp;
        gettingSizeLabel.lineBreakMode =NSLineBreakByWordWrapping;
        gettingSizeLabel.numberOfLines = 0;
        CGSize maximumLabelSize = CGSizeMake(107.0, 1000.0f); // this width will be as per your requirement
        
        expectedLabelSize = [gettingSizeLabel sizeThatFits:maximumLabelSize];
        
//        
//        expectedLabelSize = [tmp sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13.0f] constrainedToSize:CGSizeMake(107.0, 1000.0f) lineBreakMode:NSLineBreakByWordWrapping];
        
        NSLog(@"%f",expectedLabelSize.height);
        intval = [NSNumber numberWithFloat: expectedLabelSize.height];
        
    }
    else
    {
        intval = [NSNumber numberWithFloat:40.0f];
    }
    [sizes setObject:intval forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    NSLog(@"%f***********************", intval.floatValue);
    
    if(intval.floatValue+3<=30.00)
    {
        return 30;
    }
    else if (intval.floatValue>=100)
    {
        return 100;
    }
    else
    {
        return intval.floatValue+3;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //Description, DateAdded, AddedBY, PKTicketDetailID
    NSLog(@"%s",__FUNCTION__);
    static NSString *CellIdentifier = @"CountryCell2";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell=nil;
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    else
    {
        [cell removeFromSuperview];
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    // Configure the cell...
    
    NSArray *a = [[NSMutableArray alloc]initWithObjects:@"DateAdded", @"AddedBY", @"Description", nil];
    float ws[3]={88.0,80.0,130.0};
    float sw = 13.0;
    Hello_SOAPAppDelegate* del = [UIApplication sharedApplication].delegate;
    NSDictionary *parsed = [del.data1 objectAtIndex:indexPath.row];
    //   NSLog(@"parsed %@",parsed);
    UILabel *l;
    
    for(int i = 0; i < a.count; i++)
    {
        NSNumber *tmp;
        NSNumber *tmp1=[NSNumber numberWithFloat:30.00];
        tmp = [sizes objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        NSLog(@"%f",tmp.floatValue);
        NSLog(@"%f",tmp1.floatValue);
        
        if(tmp.floatValue<tmp1.floatValue)
        {
            tmp=[NSNumber numberWithFloat:30.00];
        }
        else if (tmp.floatValue>100.00)
        {
             tmp=[NSNumber numberWithFloat:100.00];
        }
        //        if(indexPath.row==2){
        
        
        //            l = [[UILabel alloc]initWithFrame:CGRectMake(sw, 0, ws[i], expectedLabelSize.height)];
        //        }else{
        l = [[UILabel alloc]initWithFrame:CGRectMake(sw, 0, ws[i], tmp.floatValue)];
        //        }
        sw += ws[i];
        
        l.textAlignment = NSTextAlignmentLeft;
        l.numberOfLines = 5;
        l.lineBreakMode = NSLineBreakByWordWrapping;
        l.font = [UIFont fontWithName:@"Helvetica Neue" size:13.0f];
        l.text = [parsed objectForKey:[a objectAtIndex:i]];
        //        NSLog(@"first l : %@",l.text);
        if(i==0){
            NSDateFormatter *inpf = [[NSDateFormatter alloc]init];
            NSDateFormatter *outf = [[NSDateFormatter alloc]init];
            //            [outf setDateFormat:@"d MMM hh:mm"];
            [outf setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
            
            [inpf setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
            NSDate *inpd = [inpf dateFromString:l.text];
            l.text = [outf stringFromDate:inpd];
            //             NSLog(@"second l : %@",l.text);
        }
        if(indexPath.row==2){
            //   l.text = [l.text stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
            //  l.text = [l.text stringByReplacingOccurrencesOfString:@"<BR/>" withString:@"\n"];
            l.lineBreakMode = NSLineBreakByWordWrapping;
            l.numberOfLines = 5;
            l.textAlignment = NSTextAlignmentLeft;
            //             NSLog(@"thirf l : %@",l.text);
        }
        
        NSString *str=l.text;
        
        
        // [str stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
        // [str stringByReplacingOccurrencesOfString:@"<BR/>" withString:@"\n"];
        if (i==2) {
            NSArray *arr = [l.text componentsSeparatedByString:@"<br/>"];
            NSLog(@"arr %@",arr);
            if ([self isTheStringDate:[arr objectAtIndex:0]] && arr.count == 2) {
                NSLog(@"iSTrue");
                NSDateFormatter *inpf = [[NSDateFormatter alloc]init];
                NSDateFormatter *outf = [[NSDateFormatter alloc]init];
                //            [outf setDateFormat:@"d MMM hh:mm"];
                [outf setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
                
                [inpf setDateFormat:@"MM/dd/yy hh:mm:ss a"];
                NSDate *inpd = [inpf dateFromString:[arr objectAtIndex:0]];
                NSString *strJoin = [outf stringFromDate:inpd];
                str = [NSString stringWithFormat:@"%@<br/>%@",strJoin,[arr objectAtIndex:1]];
                //            l.text=[self stringByStrippingHTML:str];
            }
            
        }
        l.text=[self stringByStrippingHTML:str];
        [cell.contentView addSubview:l];
    }
    
    return cell;
}
- (BOOL) isTheStringDate: (NSString*) theString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yy hh:mm:ss a"];
    NSDate *dateFromString = [[NSDate alloc] init];
    
    dateFromString = [dateFormatter dateFromString:theString];
    
    if (dateFromString !=nil) {
        return true;
    }
    else {
        return false;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s",__FUNCTION__);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
      selectedrow=(int)indexPath.row;
    [self performSegueWithIdentifier:@"show_detail" sender:self];
  
  
    }
#pragma mark Remove Html String
-(NSString *) stringByStrippingHTML:(NSString*)s {
    NSRange r;
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}
-(void)viewDidLayoutSubviews{
    
    //    CGRect rt;
    //    CGSize sz = [UIScreen mainScreen].bounds.size;
    
    //    rt = CGRectMake(0, 0, sz.width, sz.height);
    //    [self.lblBack setFrame:rt];
    //    //    rt = self.view.frame;
    //    //    rt.size.width = sz.width;
    //    //    rt.size.height = sz.height;
    //    //    [self.view setFrame:rt];
    //
    //
    //    rt = self.table.frame;
    //    rt.size.width = sz.height;
    //    [self.table setFrame:rt];
    //
    //    rt = self.lblBack.frame;
    //    rt.size.width = sz.height;
    //    [self.lblBack setFrame:rt];
    //
    //    self.table.hidden = NO;
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
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    lblID.text = [NSString stringWithFormat:@"ID  %@", del.ticID ];
    sizes = [[NSMutableDictionary alloc]init];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
//    return UIInterfaceOrientationLandscapeRight;
//}
//
//-(NSUInteger)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskLandscapeRight;
//}
//-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
//    //    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
//    //    }
//
//}
-(void)doneAction{
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    if([desc isEqualToString:@"refresh"]){
        flag = FALSE;
        desc = @"";
        del.data1 = [NSMutableArray arrayWithArray:parser11.allData];
        [self.table reloadData];
    }
    if([desc isEqualToString:@"back"]){
        flag = FALSE;
        desc = @"";
        del.data1 = [NSMutableArray arrayWithArray:parser11.allData];
        [glbAppdel.parentvc dismissViewControllerAnimated:YES completion:nil];
//        [del.viewController.pinView.tGVC.concernInfo dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    glbAppdel.parentvc=self;
    if([segue.identifier isEqualToString:@"show_detail"])
    {
          Hello_SOAPAppDelegate* del = [UIApplication sharedApplication].delegate;
        TicketDetailViewController *detail =segue.destinationViewController;
     
        detail.marrData =[del.data1 objectAtIndex:selectedrow];
      
        //    NSLog(@"data1 %@",[del.data1 objectAtIndex:indexPath.row]);
        //    ticketDetailViewController.marrData = [del.data1 objectAtIndex:indexPath.row];

    }
}
@end
