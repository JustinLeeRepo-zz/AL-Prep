//
//  ViewController.m
//  Dropit
//
//  Created by Justin Lee on 6/27/16.
//  Copyright © 2016 Justin Lee. All rights reserved.
//

#import "DropitViewController.h"

@interface DropitViewController ()
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *gravity;
@property (nonatomic, strong) UICollisionBehavior *collider;

@end

@implementation DropitViewController

- (UIDynamicAnimator *)animator
{
	if (!_animator) _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.gameView];
	return _animator;
}

- (UIGravityBehavior *)gravity
{
	if (!_gravity) {
		_gravity = [[UIGravityBehavior alloc] init];
		_gravity.magnitude = 0.9;
		[self.animator addBehavior:_gravity];
	}
	return _gravity;
}

- (UICollisionBehavior *)collider
{
	if (!_collider) {
		_collider = [[UICollisionBehavior alloc] init];
		_collider.translatesReferenceBoundsIntoBoundary = YES;
		[self.animator addBehavior:_collider];
	}
	return _collider;
}

static const CGSize DROP_SIZE = { 40, 40 };

- (IBAction)tap:(UITapGestureRecognizer *)sender
{
	[self drop];
}

- (void)drop
{
	CGRect frame;
	frame.origin = CGPointZero;
	frame.size = DROP_SIZE;
	int x = (arc4random() % (int)self.gameView.bounds.size.width) / DROP_SIZE.width;
	frame.origin.x =  x * DROP_SIZE.width;
	
	UIView *dropView = [[UIView alloc] initWithFrame:frame];
	dropView.backgroundColor = [self randomColor];
	
	[self.gameView addSubview:dropView];
	
	[self.gravity addItem:dropView];
	[self.collider addItem:dropView];
	
}

- (UIColor *)randomColor
{
	switch (arc4random() % 5) {
		case 0: return [UIColor greenColor];
		case 1: return [UIColor blueColor];
		case 2: return [UIColor orangeColor];
		case 3: return [UIColor redColor];
		case 4: return [UIColor purpleColor];
	}
	return [UIColor blackColor];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
