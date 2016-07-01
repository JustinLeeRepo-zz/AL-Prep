//
//  ImageViewController.m
//  Imaginarium
//
//  Created by Justin Lee on 7/1/16.
//  Copyright © 2016 Justin Lee. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;

@end

@implementation ImageViewController

- (UIImageView *)imageView
{
	if (!_imageView) _imageView = [[UIImageView alloc] init];
	return _imageView;
}

@end
