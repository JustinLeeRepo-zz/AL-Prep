//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Justin Lee on 6/23/16.
//  Copyright © 2016 Justin Lee. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
	self.gameType = @"Playing Cards";
	return [[PlayingCardDeck alloc] init];
}

- (NSAttributedString *)titleForCard:(Card *)card
{
	NSAttributedString *title = [[NSAttributedString alloc] initWithString:card.isChosen ? card.contents : @""];
	return title;
}

-(UIImage *)backgroundImageForCard:(Card *)card
{
	return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
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
