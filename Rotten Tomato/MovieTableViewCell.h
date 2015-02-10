//
//  MovieTableViewCell.h
//  Rotten Tomato
//
//  Created by Sean Dy on 2/4/15.
//  Copyright (c) 2015 Sean Dy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;

@end
