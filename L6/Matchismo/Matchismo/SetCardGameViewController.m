//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Justin Lee on 6/23/16.
//  Copyright © 2016 Justin Lee. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (Deck *)createDeck
{
	self.gameType = @"Set Cards";
	return [[SetCardDeck alloc] init];
}

- (NSAttributedString *)titleForCard:(Card *)card
{
	//should only have setcards in this controller
	SetCard *setCard = (SetCard *)card;
	NSString *symbol = [self symbolForCard:setCard];
	UIColor *color = [self colorForCard:setCard];
	NSDictionary *attributes = [self attributesForCard:setCard withColor:color];
	return [[NSAttributedString alloc] initWithString:symbol attributes:attributes];
}

- (NSString *)symbolForCard:(SetCard *)setCard
{
	NSString *symbol = @"";
	if ([setCard.symbol isEqualToString:@"oval"]) symbol = @"●";
	else if ([setCard.symbol isEqualToString:@"squiggle"]) symbol = @"▲";
	else if ([setCard.symbol isEqualToString:@"diamond"]) symbol = @"■";
	symbol = [symbol stringByPaddingToLength:setCard.number withString:symbol startingAtIndex:0];
	return symbol;
}

- (UIColor *)colorForCard:(SetCard *)setCard
{
	UIColor *color;
	if ([setCard.color isEqualToString:@"red"]) color = [UIColor redColor];
	else if ([setCard.color isEqualToString:@"green"]) color = [UIColor greenColor];
	else if ([setCard.color isEqualToString:@"purple"]) color = [UIColor purpleColor];
	return color;
}

- (NSDictionary *)attributesForCard:(SetCard *)setCard withColor:(UIColor *)color
{
	NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
	[attributes setObject:color forKey:NSForegroundColorAttributeName];
	if ([setCard.shading isEqualToString:@"solid"]) {
		[attributes setObject:@-5 forKey:NSStrokeWidthAttributeName];
	} else if ([setCard.shading isEqualToString:@"striped"]) {
		[attributes addEntriesFromDictionary:@{NSStrokeWidthAttributeName: @-5,
											   NSStrokeColorAttributeName: color,
											   NSForegroundColorAttributeName: [color colorWithAlphaComponent:0.3]}];
	} else if ([setCard.shading isEqualToString:@"open"]) {
		[attributes setObject:@5 forKey:NSStrokeWidthAttributeName];
	}
	return attributes;
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
	return [UIImage imageNamed:card.chosen? @"selectedSetCard" : @"setCard"];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self updateUI];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
