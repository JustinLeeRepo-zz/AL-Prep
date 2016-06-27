//
//  GameResult.m
//  Matchismo
//
//  Created by Justin Lee on 6/25/16.
//  Copyright © 2016 Justin Lee. All rights reserved.
//

#import "GameResult.h"

@interface GameResult()

@property (nonatomic, readwrite) NSDate *start;
@property (nonatomic, readwrite) NSDate *end;

@end

@implementation GameResult

- (void)setScore:(int)score
{
	_score = score;
	self.end = [NSDate date];
}

- (instancetype)init
{
	self = [super init];
	if (self) {
		_start = [NSDate date];
		_end = _start;
	}
	return self;
}
#pragma mark - Properties





@end
