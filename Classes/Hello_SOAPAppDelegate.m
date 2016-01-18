//
//  Hello_SOAPAppDelegate.m
//  Hello_SOAP
//
//  Created by Dave McAnall on 11/2/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "Hello_SOAPAppDelegate.h"
#import "Hello_SOAPViewController.h"
#import "FileIO.h"
#import "pinInputViewController.h"

@implementation Hello_SOAPAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize data1;
@synthesize data2;
@synthesize expertID;
@synthesize userName;
@synthesize passWd;
@synthesize dat1;
@synthesize dat2;
@synthesize ticID;
@synthesize sFlg;
@synthesize userUrl;
@synthesize strDeviceToken;
@synthesize Customer_Name;
@synthesize Store_name;
@synthesize Selected_Category;

//for ticket (pull to refresh)
@synthesize Page_new;
@synthesize Page_ongoing;
@synthesize Page_Close;
@synthesize Status_For_Ticket;

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSMutableString *deviceId = [NSMutableString string];
    const unsigned char *ptr = (const unsigned char*)[deviceToken bytes];
    for(int i = 0; i < 32; i++){
        [deviceId appendFormat:@"%02x", ptr[i]];
    }
    NSLog(@"APNS Device Token: %@", deviceId);
    [[NSUserDefaults standardUserDefaults] setValue:deviceId forKey:@"DeviceToken"];
    strDeviceToken = deviceId;
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSString *string = [NSString stringWithFormat:@"%@", userInfo];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:string delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [alert release];
}
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
       glbAppdel =self;
    //for ticket pull to refresh
    Page_new=@"1";
    Page_ongoing=@"1";
    Page_Close=@"1";
    
    Status_For_Ticket=@"-2";
    
    int ret;
    int expID;
    FileIO *m_pFileIO = [[FileIO alloc] initFileIO];
    [m_pFileIO openFile:YES];//read mode
    ret = [m_pFileIO readInt:4];
    expID = [m_pFileIO readInt:8];
    [m_pFileIO closeFile];
    data1 = [[NSMutableArray alloc]init];
    data2 = [[NSMutableArray alloc]init];
    dat1 = [[NSMutableArray alloc]init];
    dat2 = [[NSMutableArray alloc]init];
    Selected_Category=@"1";
    
    [window addSubview:viewController.view];
	[window makeKeyAndVisible];
    
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if(userInfo != nil){
        [self application:application didFinishLaunchingWithOptions:userInfo];
    }
    
    if ([UIApplication respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
    {
        // iOS 8 Notifications
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
        [application registerForRemoteNotifications];
    }
    else
    {
        // iOS < 8 Notifications
    
    [[UIApplication sharedApplication]registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge| UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
    }
    return YES;
}
- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	
	// Override point for customization after app launch	
    glbAppdel =self;
    int ret;
    int expID;
    FileIO *m_pFileIO = [[FileIO alloc] initFileIO];
    [m_pFileIO openFile:YES];//read mode
    ret = [m_pFileIO readInt:4];
    expID = [m_pFileIO readInt:8];
    [m_pFileIO closeFile];
    data1 = [[NSMutableArray alloc]init];
    data2 = [[NSMutableArray alloc]init];
    dat1 = [[NSMutableArray alloc]init];
    dat2 = [[NSMutableArray alloc]init];

//    if(ret == 10){//PIN CODE SAVED
//        pinInputViewController *pinInput = [[pinInputViewController alloc]init];
//        pinInput.expertID = [NSString stringWithFormat:@"%d",expID];
//        expertID = pinInput.expertID;
////      [self presentViewController:pinInput animated:YES completion:nil];
//        [window setRootViewController:pinInput];
//        [window addSubview:pinInput.view];
//        [window makeKeyAndVisible];
//        return;
//    }
    [window addSubview:viewController.view];
	[window makeKeyAndVisible];
}
-(void)applicationDidBecomeActive:(UIApplication *)application{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    sFlg = TRUE;
    
}
- (void)dealloc {
    [viewController release];
	[window release];
	[super dealloc];
}
-(void)sendRequestWithJSONRequest:(NSString *)jsonRequest BASIC_URL:(NSURL *)url
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSLog(@"Request: %@", jsonRequest);
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    if(webdata)
        [webdata release];
    webdata = [[NSMutableData alloc]init];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data{
    [webdata appendData:data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"DidFailWithError\n%@",error);
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    NSLog(@"DidFinishLoading");
//    
//    NSString *theXML = [[NSString alloc] initWithBytes: [webdata mutableBytes] length:[webdata length] encoding:NSUTF8StringEncoding];
//    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:webdata options:kNilOptions error:nil];
//    
//    NSArray *arr = [dictionary allKeys];
    
}
@end
