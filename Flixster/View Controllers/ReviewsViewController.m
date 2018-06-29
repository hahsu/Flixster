//
//  ReviewsViewController.m
//  Flixster
//
//  Created by Hannah Hsu on 6/29/18.
//  Copyright © 2018 Hannah Hsu. All rights reserved.
//

#import "ReviewsViewController.h"

@interface ReviewsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *reviewLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation ReviewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSNumber *reviewId = self.movie[@"id"];
    NSString *fullURL = [NSString stringWithFormat:@"%@%@%@", @"https://api.themoviedb.org/3/movie/", reviewId, @"/reviews?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        // this chunk is called after network call is finished
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            // TODO: Get the array of movies
            NSArray *reviews = dataDictionary[@"results"];
            if(reviews.count == 0){
                self.reviewLabel.text = @"No reviews available";
            }
            else{
                NSDictionary *movieReview = reviews[0];
                self.reviewLabel.text = movieReview[@"content"];
                [self.reviewLabel sizeToFit];
                CGFloat maxHeight = self.reviewLabel.frame.origin.y + self.reviewLabel.frame.size.height + 40.0;
                self.scrollView.contentSize = CGSizeMake(self.reviewLabel.frame.size.width, maxHeight);
            }
        }
    }];
    [task resume];
    // Do any additional setup after loading the view.
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
