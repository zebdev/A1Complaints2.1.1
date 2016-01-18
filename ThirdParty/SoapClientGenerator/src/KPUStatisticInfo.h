//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.2
//
// Created by Quasar Development at 23-03-2015
//
//---------------------------------------------------


#import <Foundation/Foundation.h>

@class KPUHelper;
#import "KPURequestResultHandler.h"
#import "DDXML.h"



@interface KPUStatisticInfo : NSObject <KPUISerializableObject>


@property (retain,nonatomic,getter=getPKStatisticId) NSNumber* PKStatisticId;

@property (retain,nonatomic,getter=getFkTicketId) NSNumber* FkTicketId;

@property (retain,nonatomic,getter=getTotalTimeUnAssigned) NSNumber* TotalTimeUnAssigned;

@property (retain,nonatomic,getter=getResponseSLAOverdue) NSNumber* ResponseSLAOverdue;

@property (retain,nonatomic,getter=getResolutionSLAOverdue) NSNumber* ResolutionSLAOverdue;

@property (retain,nonatomic,getter=getTotalActionTime) NSNumber* TotalActionTime;

@property (retain,nonatomic,getter=getWaitingTime) NSNumber* WaitingTime;

@property (retain,nonatomic,getter=getResolutionOverdue) NSString* ResolutionOverdue;
-(id)init;
-(id)initWithXml: (DDXMLElement*)__node __request:(KPURequestResultHandler*) __request;
+(KPUStatisticInfo*) createWithXml:(DDXMLElement*)__node __request:(KPURequestResultHandler*) __request;
-(void) serialize:(DDXMLElement*)__parent __request:(KPURequestResultHandler*) __request;
@end