//
//  MovieDetailsViewController.m
//  Rotten Tomato
//
//  Created by Sean Dy on 2/8/15.
//  Copyright (c) 2015 Sean Dy. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import "MoviesViewController.h"
#import "UIImageView+AFNetworking.h"


@interface MovieDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextView *textView;



@end

@implementation MovieDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSURL *imgURL = [self getOriURL:self.movie[@"posters"][@"thumbnail"]];
    [self.posterImageView setImageWithURL:imgURL];
    
    self.textView.selectable = FALSE;

    self.titleLabel.text = self.movie[@"title"];
    
    //self.textView.delegate = self;
    
    self.textView.text = self.movie[@"synopsis"];
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scroll");
}


-(NSURL *) getOriURL:(NSString *) url {
    //Sorry, I can't figure out how to reuse this and I don't want to waste time figuring it out.
    NSString *orig_img_url = [NSString stringWithFormat:@"%@%@",[url substringToIndex:url.length -7],@"ori.jpg"];
    NSURL *imgURL = [NSURL URLWithString:orig_img_url];
    return imgURL;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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



