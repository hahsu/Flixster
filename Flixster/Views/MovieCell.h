//
//  MovieCell.h
//  Flixster
//
//  Created by Hannah Hsu on 6/27/18.
//  Copyright © 2018 Hannah Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;

@end
