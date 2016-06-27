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

#define ALL_RESULTS_KEY @"GameResult_All"
#define START_KEY @"StartDate"
#define END_KEY @"EndDate"
#define SCORE_KEY @"Score"
#define GAME_KEY @"Game"

#pragma mark - Properties

- (void)setScore:(int)score
{
	_score = score;
	self.end = [NSDate date];
}

- (id)asPropertyList
{
	return @{ START_KEY : self.start, END_KEY : self.end, SCORE_KEY : @(self.score), GAME_KEY : self.gameType };
}

#pragma mark - Local Data

- (void)synchronize
{
	NSMutableDictionary *userDefaults = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] mutableCopy];
	if (!userDefaults) {
		userDefaults = [[NSMutableDictionary alloc] init];
	}
	userDefaults[[self.start description]] = [self asPropertyList];
	[[NSUserDefaults standardUserDefaults] setObject:userDefaults forKey:ALL_RESULTS_KEY];
	[[NSUserDefaults	standardUserDefaults] synchronize];
}

#pragma mark - Initializaion

- (instancetype)init
{
	self = [super init];
	if (self) {
		_start = [NSDate date];
		_end = _start;
	}
	return self;
}

@end
