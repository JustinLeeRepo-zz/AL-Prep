//
//  DropitBehavior.m
//  Dropit
//
//  Created by Justin Lee on 6/27/16.
//  Copyright © 2016 Justin Lee. All rights reserved.
//

#import "DropitBehavior.h"

@interface DropitBehavior()

@property (nonatomic, strong) UIGravityBehavior *gravity;
@property (nonatomic, strong) UICollisionBehavior *collider;
@property (nonatomic, strong) UIDynamicItemBehavior *animationOptions;

@end

@implementation DropitBehavior

- (UIGravityBehavior *)gravity
{
	if (!_gravity) {
		_gravity = [[UIGravityBehavior alloc] init];
		_gravity.magnitude = 0.9;
	}
	return _gravity;
}

- (UICollisionBehavior *)collider
{
	if (!_collider) {
		_collider = [[UICollisionBehavior alloc] init];
		_collider.translatesReferenceBoundsIntoBoundary = YES;
	}
	return _collider;
}

- (UIDynamicItemBehavior *)animationOptions
{
	if (!_animationOptions) {
		_animationOptions = [[UIDynamicItemBehavior alloc] init];
		_animationOptions.allowsRotation = NO;
	}
	return _animationOptions;
}

- (void)addItem:(id<UIDynamicItem>)item
{
	[self.gravity addItem:item];
	[self.collider addItem:item];
	[self.animationOptions addItem:item];
}

- (void)removeItem:(id<UIDynamicItem>)item
{
	[self.gravity removeItem:item];
	[self.collider removeItem:item];
	[self.animationOptions addItem:item];
}

- (instancetype)init
{
	self = [super init];
	[self addChildBehavior:self.gravity];
	[self addChildBehavior:self.collider];
	return self;
}

@end
