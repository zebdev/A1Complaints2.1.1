//
//  UIGridViewView.m
//  foodling2
//
//  Created by Tanin Na Nakorn on 3/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "UIGridView.h"
#import "UIGridViewDelegate.h"
#import "UIGridViewCell.h"
#import "UIGridViewRow.h"
#import "Cell.h"

@implementation UIGridView
@synthesize cols,rows,tagId;

@synthesize uiGridViewDelegate;
@synthesize cWidth;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		[self setUp];
    }
    return self;
}


- (id) initWithCoder:(NSCoder *)aDecoder
{
	
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
		self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}


- (void) setUp
{
	self.delegate = self;
	self.dataSource = self;
    cWidth = 480;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
	self.delegate = nil;
	self.dataSource = nil;
	self.uiGridViewDelegate = nil;
    [super dealloc];
}

- (UIGridViewCell *) dequeueReusableCell
{
	UIGridViewCell* temp = tempCell;
	tempCell = nil;
	return temp;
}


// UITableViewController specifics
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 0.0;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    [cell setNeedsDisplay];
//    [cell setNeedsLayout];
    [cell.contentView setNeedsDisplay];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	int residue =  (int)([uiGridViewDelegate numberOfCellsOfGridView:self] % [uiGridViewDelegate numberOfColumnsOfGridView:self]);
	
	if (residue > 0) residue = 1;
	
	return ([uiGridViewDelegate numberOfCellsOfGridView:self] / [uiGridViewDelegate numberOfColumnsOfGridView:self]) + residue;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (int)[uiGridViewDelegate gridView:self heightForRowAt:(int)indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UIGridViewRow";
    UIGridViewRow *row1 = (UIGridViewRow *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (row1 == nil) {
        row1 = [[[UIGridViewRow alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	int numCols = (int)[uiGridViewDelegate numberOfColumnsOfGridView:self];
	int count = (int)[uiGridViewDelegate numberOfCellsOfGridView:self];
	
	CGFloat x = 0.0;
	CGFloat height = [uiGridViewDelegate gridView:self heightForRowAt:(int)indexPath.row];
	
	for (int i=0;i<numCols;i++) {
		
		if ((i + indexPath.row * numCols) >= count) {
			
			if ([row1.contentView.subviews count] > i) {
				((UIGridViewCell *)[row1.contentView.subviews objectAtIndex:i]).hidden = YES;
			}
			
			continue;
		}
		
		if ([row1.contentView.subviews count] > i) {
			tempCell = [row1.contentView.subviews objectAtIndex:i];
		} else {
			tempCell = nil;
		}
		
		UIGridViewCell *cell = [uiGridViewDelegate gridView:self 
												cellForRowAt:(int)indexPath.row
												 AndColumnAt:i];
		
		if (cell.superview != row1.contentView) {
			[cell removeFromSuperview];
			[row1.contentView addSubview:cell];
			
			[cell addTarget:self action:@selector(cellPressed:) forControlEvents:UIControlEventTouchUpInside];
		}
		cell.hidden = NO;
		cell.rowIndex = (int)indexPath.row;
		cell.colIndex = i;
		
		CGFloat thisWidth = [uiGridViewDelegate gridView:self widthForColumnAt:i];
		cell.frame = CGRectMake(x, 0, thisWidth, height);
        ((Cell *)cell).label.frame =CGRectMake(0, 3, thisWidth, height-3);
        
        /*
         lblNew = [lblNameArray objectAtIndex:indexPath.row];
         for (id label in [cell.contentView subviews]) {
         if ([label isKindOfClass:[UILabel class]]) {
         lblCell = label;
         }
         }
         if (![lblNew.text isEqualToString:lblCell.text]) {
         cell = [[[MyTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
         [cell.contentView addSubview:[lblNameArray objectAtIndex:indexPath.row]];
         }
         
         */
		x += thisWidth;
	}
	if(x>cWidth)
        cWidth = x;
	row1.frame = CGRectMake(row1.frame.origin.x,
							row1.frame.origin.y,
							x,
							height);
    
    return row;
}
- (IBAction) cellPressed:(id) sender
{
	UIGridViewCell *cell = (UIGridViewCell *) sender;
	[uiGridViewDelegate gridView:self didSelectRowAt:cell.rowIndex AndColumnAt:cell.colIndex];
}


@end
