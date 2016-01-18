//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.2
//
// Created by Quasar Development at 23-03-2015
//
//---------------------------------------------------


#import <Foundation/Foundation.h>
    
#import "KPUAccessType.h"

@implementation KPUAccessType

-(id) initWithEnum:(NSString*)itemName value:(int) itemValue
{
    if(self = [super init])
    {
        self->name=itemName;
        self->value=itemValue;
    }
    return self;
}

-(NSString*) stringValue
{
    return name;
}
    
-(NSString*) description
{
    return name;
}

-(int) getValue
{
    return value;
}

-(BOOL) isEqualTo:(KPUAccessType *)item
{
    return [name isEqualToString:item->name];
}
   
-(void) serialize:(DDXMLNode*)parent
{
    [parent setStringValue:name];
}
     
+(KPUAccessType*) All
{
    static KPUAccessType* obj=nil;
    if(!obj)
    {
        obj=[[KPUAccessType alloc] initWithEnum: @"All" value: 0];
    }
    return obj;
} 
+(KPUAccessType*) Active
{
    static KPUAccessType* obj=nil;
    if(!obj)
    {
        obj=[[KPUAccessType alloc] initWithEnum: @"Active" value: 1];
    }
    return obj;
} 
+(KPUAccessType*) InActive
{
    static KPUAccessType* obj=nil;
    if(!obj)
    {
        obj=[[KPUAccessType alloc] initWithEnum: @"InActive" value: 2];
    }
    return obj;
} 
    
+ (KPUAccessType *)createWithXml:(DDXMLNode *)node
{
    return [KPUAccessType createWithString:[node stringValue]];
}
    
+ (KPUAccessType *)createWithString:(NSString *)value
{
    if([value isEqualToString:@"Active"])
    {
        return [KPUAccessType Active];
    }
    if([value isEqualToString:@"InActive"])
    {
        return [KPUAccessType InActive];
    }
    return [KPUAccessType All];   
}
    

@end