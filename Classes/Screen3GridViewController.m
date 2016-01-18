//
//  Screen3GridViewController.m
//  Hello_SOAP
//
//  Created by TaeIl Kim on 6/19/13.
//
//

#import "Screen3GridViewController.h"
#import "Screen4GridViewController.h"
#import "Hello_SOAPAppDelegate.h"
#import "Hello_SOAPViewController.h"
#import "Cell.h"
#import "MyParserViewController.h"
#import <CoreTelephony/CTCall.h>
#import <CoreTelephony/CTCallCenter.h>

@interface Screen3GridViewController ()

@end
BOOL enableGo, enableShow;
@implementation Screen3GridViewController
@synthesize infoView, historyView, expID, ticID, desc, parser, descView, viewSub, emAddress, webView, scr4, tempView, incBtn;
NSTimer* myTimer;
NSArray *title1,*contentKey1;
-(IBAction)btnShowHide:(id)sender{
    if(enableShow == TRUE){
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1.0];
        [incBtn setContentOffset:CGPointMake(-450, 0)];
        [UIView commitAnimations];
        enableShow = FALSE;
    }else{
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1.0];
        [incBtn setContentOffset:CGPointMake(0, 0)];
        [UIView commitAnimations];
        enableShow = TRUE;
    }
}
-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    [infoView reloadData];
//    [historyView reloadData];
    
//    UIScrollView *temp = infoView;
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:1];
//    [temp setContentOffset:CGPointMake(0, 150)];
//    [UIView commitAnimations];
    
//    [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:0.3];
//    [temp setContentOffset:CGPointMake(0, 0)];
//    [UIView commitAnimations];
    [infoView reloadData];
    [historyView reloadData];
//    enableShow = TRUE;
    if(enableShow == TRUE)
        [self btnShowHide:nil];
}
-(IBAction)btnOK:(id)sender{
    
    if([desc isEqualToString:@"close"]){
        [parser closeTicket:expID TicketID:ticID Description:descView.text];
    }
    if([desc isEqualToString:@"reject"]){
        [parser rejectTicket:expID TicketID:ticID Description:descView.text];
    }
    viewSub.hidden = YES;
}
-(IBAction)btnCancel:(id)sender{
    viewSub.hidden = YES;
}
-(IBAction)btnClose:(id)sender{
    desc = @"close";
    descView.text = @"";
    viewSub.hidden = NO;
//    [parser closeTicket:expID TicketID:ticID Description:@"close"];
}
-(IBAction)btnCall:(id)sender{
    /*
         NSDictionary *parsed;
     parsed = [del.data1 objectAtIndex:0];
     if(columnIndex == 0){
     cell.label.text = [title1 objectAtIndex:rowIndex];//[[parsed allKeys] objectAtIndex:rowIndex];
     }
     else
     {
     cell.label.text = [parsed objectForKey:[contentKey1 objectAtIndex:rowIndex] ];//[[parsed allValues] objectAtIndex:rowIndex];
     }
     
     */
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    NSDictionary *parsed;
    parsed = [del.data1 objectAtIndex:0];
    
    NSString *tP = [NSString stringWithFormat:@"%@",[parsed objectForKey:@"phonenumber"] ];
    tP = [NSString stringWithFormat:@"%@",[tP stringByReplacingOccurrencesOfString:@"+" withString:@""]];
//    NSString *phoneNumber = [NSString stringWithFormat:@"tel://%@",[parsed objectForKey:@"phonenumber"] ];
    NSString *phoneNumber = [NSString stringWithFormat:@"tel://%@",tP ];

    webView.hidden = NO;
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://"]]])
    {
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:/*@"tel://18343133736"*/ phoneNumber]]];
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"This function is only available on the iPhone" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}
-(IBAction)btnMessage:(id)sender{
//    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
//    del.dat1 = [NSMutableArray arrayWithArray: del.data1];
//    [del.data1 removeAllObjects];
//    del.dat2 = [NSMutableArray arrayWithArray:del.data2];
//    [del.data2 removeAllObjects];
//    desc = @"messageRequest";
//    [parser messageTicket:expID TicketID:ticID Description:desc];
    desc = @"mailAddress";
    [parser getFromEmailAddress:expID TicketID:ticID Description:desc];
}
-(IBAction)btnReject:(id)sender{
    desc = @"reject";
    descView.text = @"";
    viewSub.hidden = NO;
}
- (CGFloat) gridView:(UIGridView *)grid widthForColumnAt:(int)columnIndex
{
    NSArray *a = [NSArray arrayWithObjects:@"200",@"280", nil];
    NSString *temp;
    if(grid.tagId == 2){
        temp = [a objectAtIndex:columnIndex];
        
        return temp.floatValue;
    }else{
        return 130;
    }
}

- (CGFloat) gridView:(UIGridView *)grid heightForRowAt:(int)rowIndex
{
//    NSLog(@"Called GridHeightForRowAt");
//    UITableViewCell* cell = [grid cellForRowAtIndexPath:[NSIndexPath indexPathWithIndex:rowIndex]];
//    if(columnIndex == 0){
//        CGSize lLabelSIze = [cell.label.text sizeWithFont: cell.label.font forWidth:cell.label.frame.size.width lineBreakMode:NSLineBreakByWordWrapping];
//        //            NSLog(@"%f,,,%f",lLabelSIze.width, lLabelSIze.height);
//        cell.frame = CGRectMake(0, 0, cell.frame.size.width, lLabelSIze.height+500);
//    }
	return 100;
}

- (NSInteger) numberOfColumnsOfGridView:(UIGridView *) grid
{
	return grid.cols;
}

- (NSInteger) numberOfCellsOfGridView:(UIGridView *) grid
{
	return grid.cols*grid.rows;
}

- (UIGridViewCell *) gridView:(UIGridView *)grid cellForRowAt:(int)rowIndex AndColumnAt:(int)columnIndex
{
//    NSArray *a = [NSArray arrayWithObjects:@"200",@"280", nil];height = 100;
//    CGRectMake(0, 0, 200, 100);
//    CGRectMake(0,0, 280, 100);
//    CGRectMake(0,0,130,100);

	Cell *cell = (Cell *)[grid dequeueReusableCell];
	
	if (cell == nil) {
        cell = [[Cell alloc] init];
	}
    Hello_SOAPAppDelegate* del = [UIApplication sharedApplication].delegate;
    NSDictionary *parsed;
    cell.autoresizesSubviews = TRUE;
    cell.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    if(grid.tagId == 2){
        
        parsed = [del.data1 objectAtIndex:0];
        if(columnIndex == 0){
            cell.label.text = [title1 objectAtIndex:rowIndex];//[[parsed allKeys] objectAtIndex:rowIndex];
        }
        else
        {
            cell.label.text = [parsed objectForKey:[contentKey1 objectAtIndex:rowIndex] ];//[[parsed allValues] objectAtIndex:rowIndex];
        }
        cell.label.textAlignment = NSTextAlignmentCenter;
        if(rowIndex%2 == 0){
            cell.label.backgroundColor = [UIColor colorWithRed:255 green:0 blue:0 alpha:0.5];
        }
        else{
            cell.label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:255 alpha:0.5];
        }
        cell.label.frame = cell.frame;
        NSLog(@"(%d,%d):%@",rowIndex,columnIndex,cell.label.text);
    }else if(grid.tagId == 3){
        NSDictionary *parsed;
        NSString *temp;
        parsed = [del.data2 objectAtIndex:rowIndex];
        if([parsed allKeys].count>columnIndex)
            temp = [parsed objectForKey:[[parsed allKeys]objectAtIndex:columnIndex]];
        else
            temp = @"";
        cell.label.text = temp;
        if(rowIndex%2 == 0){
            cell.label.backgroundColor = [UIColor colorWithRed:255 green:0 blue:0 alpha:0.5];
        }
        else{
            cell.label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:255 alpha:0.5];
        }
    }

//    NSLog(@"%@",cell.label.text);
    /*
     CGSize textSize = [[myObject getALongText]
     sizeWithFont:[UIFont boldSystemFontOfSize:15]
     constrainedToSize:CGSizeMake(maxWidth, 2000)
     lineBreakMode:UILineBreakModeWordWrap];
     then you can create your UILabel like that :
     
     UILabel * lbl = [[UILabel alloc] initWithFrame:CGRectMake(0,0,textSize.width, textSize.height];
     [lbl setNumberOfLines:0];
     [lbl setLineBreakMode:UILineBreakModeWordWrap];
     [lbl setText:[myObject getALongText]];
     
     */
    
    /*//=-------------------This is right-------------------
     UILabel *testLabel =[[UILabel alloc] initWithFrame:CGRectMake(6,3, 262,20 )]; // RectMake(xPos,yPos,Max Width I want, is just a container value);
     
     NSString * test=@"this is test this is test inthis is test ininthis is test inthis is test inthis is test in uilabel ...this is test in uilabel ...this is test in uilabel ...this is test in uilabel ...this is test in uilabel ...this is test in uilabel ...this is test in uilabel ...this is test in uilabel ...this is test in uilabel ...this is test in uilabel ...this is test in uilabel ...this is test in uilabel ...this is test in uilabel ...this is test in uilabel ...this is test in uilabel ...this is test in uilabel ...this is test in uilabel ...";
     
     testLabel.text = test;
     testLabel.numberOfLines = 0; //will wrap text in new line
     [testLabel sizeToFit];
     
     [self.view addSubview:testLabel];
     */
    
    /*-----------------------This is right-----------------------
     CGFloat pointSize = 0.0f;
     CGRect frame = title.frame;
     frame.size = [title.text sizeWithFont:font
     minFontSize:title.minimumFontSize
     actualFontSize:&pointSize
     forWidth:width
     lineBreakMode:title.lineBreakMode];
     UIFont *actualFont = [UIFont fontWithName:@"Marker Felt" size:pointSize];
     CGSize sizeWithCorrectHeight = [title.text sizeWithFont:actualFont];
     frame.size.height = sizeWithCorrectHeight.height;
     title.frame = frame;
     title.font = actualFont;
     
     */
	return cell;
}

- (void) gridView:(UIGridView *)grid didSelectRowAt:(int)rowIndex AndColumnAt:(int)colIndex
{
    //Go Screen4
	NSLog(@"%d, %d clicked", rowIndex, colIndex);
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)goCallBack:(id)sender{
//    Hello_SOAPAppDelegate* del = [UIApplication sharedApplication].delegate;
    if(!scr4)
          scr4 = [[Screen4GridViewController alloc]init];
    
    
    [self presentViewController:scr4 animated:YES completion:nil];
}

- (void)viewDidLoad
{
    
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    title1 = [[NSArray alloc]initWithObjects:@"Concern ID", @"Store Name", @"Phone Number", @"Concern Type", @"Customer Narrative", nil];
    contentKey1 = [[NSArray alloc]initWithObjects:@"PKTicketId", @"GetLocationNameResponse", @"phonenumber", @"TicketTypeName", @"TicketDescription", nil];
    [super viewDidLoad];
    CTCallCenter *callCenter = [[CTCallCenter alloc]init];
    callCenter.callEventHandler = ^(CTCall* myCall){
        NSString *call = myCall.callState;
        if([call isEqualToString:CTCallStateDisconnected]){
         
            NSLog(@"Call has been disconnected.");
            [self performSelectorOnMainThread:@selector(goCallBack:) withObject:nil waitUntilDone:YES];
        }
        else if([call isEqualToString:CTCallStateDialing])
        {
            NSLog(@"Call start");
        }
        else if([call isEqualToString:CTCallStateConnected]){
            NSLog(@"Call has just been connected");
        }
        else if([call isEqualToString:CTCallStateIncoming]){
            NSLog(@"Call is incoming");
        }
        else{
            NSLog(@"None");
        }
    };

    // Do any additional setup after loading the view from its nib.
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    infoView.cols = 2;
    infoView.rows = (int)title1.count;
    infoView.tagId = 2;
    
    historyView.cols = 4;
    historyView.rows = (int)del.data2.count;
    historyView.tagId = 3;
    
    expID = del.expertID;
    del.ticID = ticID;
    parser = [[MyParserViewController alloc]init:self];
    enableShow = TRUE;
//    Hello_SOAPAppDelegate* del = [UIApplication sharedApplication].delegate;
//    del.data1
    
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeRight;
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscapeRight;
}
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    //    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
    //    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return FALSE;
    }
    return TRUE;
}
-(void)doneAction{
    NSDictionary *parsed;
    
    if([desc isEqualToString:@"mailAddress"]){
        
        //-------- GET E-MAIL ADDRESS!----------
        emAddress = @"sofiaeula3@gmail.com";

        parsed = [parser.allData objectAtIndex:0];
        emAddress = [parsed objectForKey:@"GetFromEmailAddressResult"];
        if(!emAddress){
            emAddress = @" ";
        }
        //--------------------------------------
        Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
        if (mailClass != nil) {
            // We must always check whether the current device is configured for sending emails
            if ([mailClass canSendMail]) {
                MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
                picker.mailComposeDelegate = self;
                
//                [picker setSubject:@"Hello from California!"];
                
                
                // Set up recipients
                NSArray *toRecipients = [NSArray arrayWithObject:emAddress];
//                NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
//                NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"];
                [picker setMessageBody:tempView.text isHTML:NO];
                [picker setToRecipients:toRecipients];
//                [picker setCcRecipients:ccRecipients];
//                [picker setBccRecipients:bccRecipients];
                
                // Attach an image to the email
//                NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"jpg"];
//                NSData *myData = [NSData dataWithContentsOfFile:path];
//                [picker addAttachmentData:myData mimeType:@"image/jpeg" fileName:@"rainy"];
                
                // Fill out the email body text
//                NSString *emailBody = @"It is raining in sunny California!";
//                [picker setMessageBody:emailBody isHTML:NO];
                
                [self presentViewController:picker animated:YES completion:nil];
                [picker release];
            }
            else {
                NSLog( @"Device not configured to send mail.");
            }
        }
        else	{
			NSLog( @"Device not configured to send mail.");
        }
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
            NSLog( @"Result: Mail sending canceled");
			break;
		case MFMailComposeResultSaved:
            NSLog( @"Result: Mail saved");
			break;
		case MFMailComposeResultSent:
            NSLog( @"Result: Mail sent");
            [self performSelector:@selector(goCallBack:) withObject:nil afterDelay:1.0f];
			break;
		case MFMailComposeResultFailed:
			NSLog( @"Result: Mail sending failed");
			break;
		default:
			NSLog( @"Result: Mail not sent");
			break;
	}

	[self dismissViewControllerAnimated:YES completion:nil];
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result {
	
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MessageComposeResultCancelled:
			NSLog( @"Result: SMS sending canceled");
			break;
		case MessageComposeResultSent:
			NSLog( @"Result: SMS sent");
			break;
		case MessageComposeResultFailed:
			NSLog( @"Result: SMS sending failed");
			break;
		default:
			NSLog( @"Result: SMS not sent");
			break;
	}
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
