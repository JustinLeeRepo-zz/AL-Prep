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

- (NSTimeInterval)duration
{
	return [self.end timeIntervalSinceDate:self.start];
}

- (void)setScore:(int)score
{
	_score = score;
	self.end = [NSDate date];
	[self synchronize];
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

- (instancetype)initFromPropertyList:(id)propertyList
{
	self = [self init];
	if (self) {
		if ([propertyList isKindOfClass:[NSDictionary class]]) {
			NSDictionary *pList = (NSDictionary *)propertyList;
			_start = pList[START_KEY];
			_end = pList[END_KEY];
			_score = [pList[SCORE_KEY] intValue];
			_gameType = pList[GAME_KEY];
			if (!_start || !_end) self = nil;
		}
	}
	return self;
}

+ (NSArray *)allGameResults
{
	NSMutableArray *allGameResults = [[NSMutableArray alloc] init];
	
	for (id pList in [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] allValues]) {
		GameResult *gameResult = [[GameResult alloc] initFromPropertyList:pList];
		[allGameResults addObject:gameResult];
		
	}

	return allGameResults;
}

- (NSComparisonResult)compareScore:(GameResult *)gameResult
{
	return [@(self.score) compare:@(gameResult.score)];
}

- (NSComparisonResult)compareDuration:(GameResult *)gameResult
{
	return [@(self.duration) compare:@(gameResult.duration)];
}

@end
