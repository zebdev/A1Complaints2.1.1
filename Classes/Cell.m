//
//  Cell.m
//  Hello_SOAP
//
//  Created by TaeIl Kim on 6/19/13.
//
//

#import "Cell.h"

@implementation Cell
@synthesize label;
- (id)initWithFrame:(CGRect)frame
{
//    frame.size.width = 200;
//    frame.size.height = 100;
    self = [super initWithFrame:frame];
    if (self) {
//        self.label.frame = CGRectMake(0, 3, frame.size.width, frame.size.height-6);
//        [[NSBundle mainBundle] loadNibNamed:@"Cell" owner:self options:nil];
//        [self addSubview:self.view];
    }
    return self;
}
- (id)init{
    if(self = [super init]){
//        self.frame = CGRectMake(0, 0, 200, 100);
        self.label.frame = CGRectMake(0, 3, self.frame.size.width, self.frame.size.height-6);
        [[NSBundle mainBundle] loadNibNamed:@"Cell" owner:self options:nil];
        [self addSubview:self.view];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
