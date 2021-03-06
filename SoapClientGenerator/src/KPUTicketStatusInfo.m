//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.2
//
// Created by Quasar Development at 23-03-2015
//
//---------------------------------------------------


#import "KPUHelper.h"
#import "KPUTicketStatusInfo.h"


@implementation KPUTicketStatusInfo
@synthesize PKTicketStatusId;
@synthesize TicketStatusName;
@synthesize TicketStatusKey;
@synthesize TableColor;

+ (KPUTicketStatusInfo *)createWithXml:(DDXMLElement *)__node __request:(KPURequestResultHandler*) __request
{
    if(__node == nil) { return nil; }
    return [[self alloc] initWithXml: __node __request:__request];
}

-(id)init {
    if ((self=[super init])) {
        self.PKTicketStatusId =[NSNumber numberWithInt:0];
    }
    return self;
}

- (id) initWithXml: (DDXMLElement*) __node __request:(KPURequestResultHandler*) __request{
    if(self = [self init])
    {
        if([KPUHelper hasValue:__node name:@"PKTicketStatusId" index:0])
        {
            self.PKTicketStatusId = [KPUHelper getNumber:[[KPUHelper getNode:__node name:@"PKTicketStatusId" index:0] stringValue]];
        }
        if([KPUHelper hasValue:__node name:@"TicketStatusName" index:0])
        {
            self.TicketStatusName = [[KPUHelper getNode:__node name:@"TicketStatusName" index:0] stringValue];
        }
        if([KPUHelper hasValue:__node name:@"TicketStatusKey" index:0])
        {
            self.TicketStatusKey = [[KPUHelper getNode:__node name:@"TicketStatusKey" index:0] stringValue];
        }
        if([KPUHelper hasValue:__node name:@"TableColor" index:0])
        {
            self.TableColor = [[KPUHelper getNode:__node name:@"TableColor" index:0] stringValue];
        }
    }
    return self;
}

-(void) serialize:(DDXMLElement*)__parent __request:(KPURequestResultHandler*) __request
{

             
    DDXMLElement* __PKTicketStatusIdItemElement=[__request writeElement:PKTicketStatusId type:[NSNumber class] name:@"PKTicketStatusId" URI:@"http://www.apoyar.net/" parent:__parent skipNullProperty:NO];
    if(__PKTicketStatusIdItemElement!=nil)
    {
        [__PKTicketStatusIdItemElement setStringValue:[self.PKTicketStatusId stringValue]];
    }
             
    DDXMLElement* __TicketStatusNameItemElement=[__request writeElement:TicketStatusName type:[NSString class] name:@"TicketStatusName" URI:@"http://www.apoyar.net/" parent:__parent skipNullProperty:YES];
    if(__TicketStatusNameItemElement!=nil)
    {
        [__TicketStatusNameItemElement setStringValue:self.TicketStatusName];
    }
             
    DDXMLElement* __TicketStatusKeyItemElement=[__request writeElement:TicketStatusKey type:[NSString class] name:@"TicketStatusKey" URI:@"http://www.apoyar.net/" parent:__parent skipNullProperty:YES];
    if(__TicketStatusKeyItemElement!=nil)
    {
        [__TicketStatusKeyItemElement setStringValue:self.TicketStatusKey];
    }
             
    DDXMLElement* __TableColorItemElement=[__request writeElement:TableColor type:[NSString class] name:@"TableColor" URI:@"http://www.apoyar.net/" parent:__parent skipNullProperty:YES];
    if(__TableColorItemElement!=nil)
    {
        [__TableColorItemElement setStringValue:self.TableColor];
    }


}
@end
