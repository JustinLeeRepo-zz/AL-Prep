//
//  ViewController.m
//  SuperCard
//
//  Created by Justin Lee on 6/24/16.
//  Copyright © 2016 Justin Lee. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;

@end

@implementation ViewController
- (IBAction)swipe:(UISwipeGestureRecognizer *)sender
{
	self.playingCardView.faceUp = !self.playingCardView.faceUp;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.playingCardView.suit = @"♥";
	self.playingCardView.rank = 13;
	
	[self.playingCardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.playingCardView action:@selector(pinch:)]]; 
}

@end
