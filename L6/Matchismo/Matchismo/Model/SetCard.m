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

+ (NSUInteger)maxNumber { return 3; };

- (int)match:(NSArray *)otherCards
{
	int score = 0;
	
	if ([otherCards count] == self.numOfCardsToMatch - 1) {
		NSMutableArray *colorArray = [[NSMutableArray alloc] init];
		NSMutableArray *symbolArray = [[NSMutableArray alloc] init];
		NSMutableArray *shadingArray = [[NSMutableArray alloc] init];
		NSMutableArray *numberArray = [[NSMutableArray alloc] init];
		
		[colorArray addObject:self.color];
		[symbolArray addObject:self.symbol];
		[shadingArray addObject:self.shading];
		[numberArray addObject:@(self.number)];
		
		for (id card in otherCards) {
			if ([card isKindOfClass:[SetCard class]]) {
				SetCard *otherCard = (SetCard *)card;
				
				if (![colorArray containsObject:otherCard.color]) {
					[colorArray addObject:otherCard.color];
				}
				if (![symbolArray containsObject:otherCard.symbol]) {
					[symbolArray addObject:otherCard.symbol];
				}
				if (![shadingArray containsObject:otherCard.shading]) {
					[shadingArray addObject:otherCard.shading];
				}
				if (![numberArray containsObject:@(otherCard.number)]) {
					[numberArray addObject:@(otherCard.number)];
				}
				
			}
		}
		
		if (([colorArray count] == 1 || [colorArray count] == self.numOfCardsToMatch) &&
			([symbolArray count] == 1 || [symbolArray count] == self.numOfCardsToMatch) &&
			([shadingArray count] == 1 || [shadingArray count] == self.numOfCardsToMatch) &&
			([numberArray count] == 1 || [numberArray count] == self.numOfCardsToMatch)){
			score = 4;;
		}
		
	}
	
	return score;
}

- (instancetype)init {
	self = [super init];
	
	if (self) {
		self.numOfCardsToMatch = 3;
	}
	return self;
}

@end
