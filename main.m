//
//  main.m
//  Hello_SOAP
//
//  Created by Dave McAnall on 11/2/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hello_SOAPAppDelegate.h"
int main(int argc, char *argv[]) {
	
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([Hello_SOAPAppDelegate class]));
	[pool release];
	return retVal;
}
