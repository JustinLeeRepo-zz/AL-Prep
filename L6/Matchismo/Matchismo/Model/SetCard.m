//
//  SetCard.m
//  Matchismo
//
//  Created by Justin Lee on 6/23/16.
//  Copyright © 2016 Justin Lee. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

@synthesize color = _color, symbol = _symbol, shading = _shading;

- (NSString *)contents
{
	return [NSString stringWithFormat:@"%@%@%@%d", self.color, self.symbol, self.shading, self.number];
}

- (NSString *)color
{
	return _color ?: @"?";
}

- (void)setColor:(NSString *)color
{
	if ([[SetCard validColors] containsObject:color]) {
		_color = color;
	}
}

- (NSString *)symbol
{
	return _symbol ?: @"?";
}

- (void)setSymbol:(NSString *)symbol
{
	if ([[SetCard validSymbols] containsObject:symbol]) {
		_symbol = symbol;
	}
}

- (NSString *)shading
{
	return _symbol ?: @"?";
}

- (void)setShading:(NSString *)shading
{
	if ([[SetCard validShadings] containsObject:shading]) {
		_shading = shading;
	}
}

+ (NSArray *)validColors
{
	return @[@"red", @"green", @"purple"];
}

+ (NSArray *)validSymbols
{
	return @[@"diamond", @"squiggle", @"oval"];
}

+ (NSArray *)validShadings
{
	return @[@"solid", @"striped", @"open"];
}

+(NSUInteger)maxNumber { return 3; };

- (int)match:(NSArray *)otherCards
{
	int score = 0;
	
	return score;
}

@end
