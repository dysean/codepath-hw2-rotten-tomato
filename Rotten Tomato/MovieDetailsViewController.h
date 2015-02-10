//
//  MovieDetailsViewController.h
//  Rotten Tomato
//
//  Created by Sean Dy on 2/8/15.
//  Copyright (c) 2015 Sean Dy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailsViewController : UIViewController <UITextViewDelegate>
@property (weak,nonatomic) NSDictionary *movie;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak,nonatomic) NSURL *img;
@end
