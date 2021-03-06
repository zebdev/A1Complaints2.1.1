//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.2
//
// Created by Quasar Development at 23-03-2015
//
//---------------------------------------------------


#import "KPUHelper.h"
#import "KPUStatisticInfo.h"


@implementation KPUStatisticInfo
@synthesize PKStatisticId;
@synthesize FkTicketId;
@synthesize TotalTimeUnAssigned;
@synthesize ResponseSLAOverdue;
@synthesize ResolutionSLAOverdue;
@synthesize TotalActionTime;
@synthesize WaitingTime;
@synthesize ResolutionOverdue;

+ (KPUStatisticInfo *)createWithXml:(DDXMLElement *)__node __request:(KPURequestResultHandler*) __request
{
    if(__node == nil) { return nil; }
    return [[self alloc] initWithXml: __node __request:__request];
}

-(id)init {
    if ((self=[super init])) {
        self.PKStatisticId =[NSNumber numberWithInt:0];
        self.FkTicketId =[NSNumber numberWithInt:0];
        self.TotalTimeUnAssigned =[NSNumber numberWithInt:0];
        self.ResponseSLAOverdue =[NSNumber numberWithInt:0];
        self.ResolutionSLAOverdue =[NSNumber numberWithInt:0];
        self.TotalActionTime =[NSNumber numberWithInt:0];
        self.WaitingTime =[NSNumber numberWithInt:0];
    }
    return self;
}

- (id) initWithXml: (DDXMLElement*) __node __request:(KPURequestResultHandler*) __request{
    if(self = [self init])
    {
        if([KPUHelper hasValue:__node name:@"PKStatisticId" index:0])
        {
            self.PKStatisticId = [KPUHelper getNumber:[[KPUHelper getNode:__node name:@"PKStatisticId" index:0] stringValue]];
        }
        if([KPUHelper hasValue:__node name:@"FkTicketId" index:0])
        {
            self.FkTicketId = [KPUHelper getNumber:[[KPUHelper getNode:__node name:@"FkTicketId" index:0] stringValue]];
        }
        if([KPUHelper hasValue:__node name:@"TotalTimeUnAssigned" index:0])
        {
            self.TotalTimeUnAssigned = [KPUHelper getNumber:[[KPUHelper getNode:__node name:@"TotalTimeUnAssigned" index:0] stringValue]];
        }
        if([KPUHelper hasValue:__node name:@"ResponseSLAOverdue" index:0])
        {
            self.ResponseSLAOverdue = [KPUHelper getNumber:[[KPUHelper getNode:__node name:@"ResponseSLAOverdue" index:0] stringValue]];
        }
        if([KPUHelper hasValue:__node name:@"ResolutionSLAOverdue" index:0])
        {
            self.ResolutionSLAOverdue = [KPUHelper getNumber:[[KPUHelper getNode:__node name:@"ResolutionSLAOverdue" index:0] stringValue]];
        }
        if([KPUHelper hasValue:__node name:@"TotalActionTime" index:0])
        {
            self.TotalActionTime = [KPUHelper getNumber:[[KPUHelper getNode:__node name:@"TotalActionTime" index:0] stringValue]];
        }
        if([KPUHelper hasValue:__node name:@"WaitingTime" index:0])
        {
            self.WaitingTime = [KPUHelper getNumber:[[KPUHelper getNode:__node name:@"WaitingTime" index:0] stringValue]];
        }
        if([KPUHelper hasValue:__node name:@"ResolutionOverdue" index:0])
        {
            self.ResolutionOverdue = [[KPUHelper getNode:__node name:@"ResolutionOverdue" index:0] stringValue];
        }
    }
    return self;
}

-(void) serialize:(DDXMLElement*)__parent __request:(KPURequestResultHandler*) __request
{

             
    DDXMLElement* __PKStatisticIdItemElement=[__request writeElement:PKStatisticId type:[NSNumber class] name:@"PKStatisticId" URI:@"http://www.apoyar.net/" parent:__parent skipNullProperty:NO];
    if(__PKStatisticIdItemElement!=nil)
    {
        [__PKStatisticIdItemElement setStringValue:[self.PKStatisticId stringValue]];
    }
             
    DDXMLElement* __FkTicketIdItemElement=[__request writeElement:FkTicketId type:[NSNumber class] name:@"FkTicketId" URI:@"http://www.apoyar.net/" parent:__parent skipNullProperty:NO];
    if(__FkTicketIdItemElement!=nil)
    {
        [__FkTicketIdItemElement setStringValue:[self.FkTicketId stringValue]];
    }
             
    DDXMLElement* __TotalTimeUnAssignedItemElement=[__request writeElement:TotalTimeUnAssigned type:[NSNumber class] name:@"TotalTimeUnAssigned" URI:@"http://www.apoyar.net/" parent:__parent skipNullProperty:NO];
    if(__TotalTimeUnAssignedItemElement!=nil)
    {
        [__TotalTimeUnAssignedItemElement setStringValue:[self.TotalTimeUnAssigned stringValue]];
    }
             
    DDXMLElement* __ResponseSLAOverdueItemElement=[__request writeElement:ResponseSLAOverdue type:[NSNumber class] name:@"ResponseSLAOverdue" URI:@"http://www.apoyar.net/" parent:__parent skipNullProperty:NO];
    if(__ResponseSLAOverdueItemElement!=nil)
    {
        [__ResponseSLAOverdueItemElement setStringValue:[self.ResponseSLAOverdue stringValue]];
    }
             
    DDXMLElement* __ResolutionSLAOverdueItemElement=[__request writeElement:ResolutionSLAOverdue type:[NSNumber class] name:@"ResolutionSLAOverdue" URI:@"http://www.apoyar.net/" parent:__parent skipNullProperty:NO];
    if(__ResolutionSLAOverdueItemElement!=nil)
    {
        [__ResolutionSLAOverdueItemElement setStringValue:[self.ResolutionSLAOverdue stringValue]];
    }
             
    DDXMLElement* __TotalActionTimeItemElement=[__request writeElement:TotalActionTime type:[NSNumber class] name:@"TotalActionTime" URI:@"http://www.apoyar.net/" parent:__parent skipNullProperty:NO];
    if(__TotalActionTimeItemElement!=nil)
    {
        [__TotalActionTimeItemElement setStringValue:[self.TotalActionTime stringValue]];
    }
             
    DDXMLElement* __WaitingTimeItemElement=[__request writeElement:WaitingTime type:[NSNumber class] name:@"WaitingTime" URI:@"http://www.apoyar.net/" parent:__parent skipNullProperty:NO];
    if(__WaitingTimeItemElement!=nil)
    {
        [__WaitingTimeItemElement setStringValue:[self.WaitingTime stringValue]];
    }
             
    DDXMLElement* __ResolutionOverdueItemElement=[__request writeElement:ResolutionOverdue type:[NSString class] name:@"ResolutionOverdue" URI:@"http://www.apoyar.net/" parent:__parent skipNullProperty:YES];
    if(__ResolutionOverdueItemElement!=nil)
    {
        [__ResolutionOverdueItemElement setStringValue:self.ResolutionOverdue];
    }


}
@end
