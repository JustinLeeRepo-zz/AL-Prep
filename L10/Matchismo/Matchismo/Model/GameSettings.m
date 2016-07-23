//
//  GameSettings.m
//  Matchismo
//
//  Created by Justin Lee on 6/29/16.
//  Copyright © 2016 Justin Lee. All rights reserved.
//

#import "GameSettings.h"

@implementation GameSettings

#define GAME_SETTINGS_KEY @"Game_Settings_Key"
#define MATCHBONUS_KEY @"MatchBonus_Key"
#define MISMATCHPENALTY_KEY @"MismatchPenalty_Key"
#define CHOOSECOST_KEY @"ChooseCost_Key"

- (int)intValueForKey:(NSString *)key withDefault:(int)defaultValue
{
	NSDictionary *settings = [[NSUserDefaults standardUserDefaults] dictionaryForKey:GAME_SETTINGS_KEY];
	if (!settings) return defaultValue;
	if (![[settings allKeys] containsObject:key]) return defaultValue;
	return [settings[key] intValue];
}

- (int)matchBonus
{
	return [self intValueForKey:MATCHBONUS_KEY withDefault:4];
}

- (int)mismatchPenalth
{
	return [self intValueForKey:MISMATCHPENALTY_KEY withDefault:2];
}

- (int)chooseCost
{
	return [self intValueForKey:CHOOSECOST_KEY withDefault:1];
}

- (void)setIntValue:(int)value forKey:(NSString *)key
{
	NSMutableDictionary *settings = [[[NSUserDefaults standardUserDefaults]dictionaryForKey:GAME_SETTINGS_KEY] mutableCopy];
	if (!settings) {
		settings = [[NSMutableDictionary alloc] init];
	}
	settings[key] = @(value);
	[[NSUserDefaults standardUserDefaults] setObject:settings forKey:GAME_SETTINGS_KEY];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setMatchBonus:(int)matchBonus
{
	[self setIntValue:matchBonus forKey:MATCHBONUS_KEY];
}

- (void)setMismatchPenalth:(int)mismatchPenalth
{
	[self setIntValue:mismatchPenalth forKey:MISMATCHPENALTY_KEY];
}

- (void)setChooseCost:(int)chooseCost
{
	[self setIntValue:chooseCost forKey:CHOOSECOST_KEY];
}

@end
