//
//  PlayingCardView.m
//  SuperCard
//
//  Created by Justin Lee on 6/24/16.
//  Copyright © 2016 Justin Lee. All rights reserved.
//

#import "PlayingCardView.h"

@implementation PlayingCardView

#pragma mark - Properties

- (void)setSuit:(NSString *)suit
{
	_suit = suit;
	[self setNeedsDisplay];
}

- (void)setRank:(NSUInteger)rank
{
	_rank = rank;
	[self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp
{
	_faceUp = faceUp;
	[self setNeedsDisplay];
}

#pragma mark - Drawing

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
	UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
	
	[roundedRect addClip];
	[[UIColor whiteColor] setFill];
	UIRectFill(self.bounds);
	
	[[UIColor blackColor] setStroke];
	[roundedRect stroke];
}

#pragma mark - Initalization
- (void)setup
{
	self.backgroundColor = nil;
	self.opaque = NO;
	self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib
{
	[self setup];
}

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		
	}
	return self;
}

@end
