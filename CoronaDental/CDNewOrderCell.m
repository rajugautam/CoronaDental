//
//  CDNewOrderCell.m
//  CoronaDental
//
//  Created by Raju Gautam on 06/06/15.
//  Copyright (c) 2015 Raju Gautam. All rights reserved.
//

#import "CDNewOrderCell.h"

@implementation CDNewOrderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
            // Initialization code
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        _bannerView = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        [_bannerView setImage:[UIImage imageNamed:@"start-new-order.jpg"]];
        [self.contentView addSubview:_bannerView];
        
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        backgroundView.backgroundColor = [UIColor whiteColor];
        [self setBackgroundView:backgroundView];
        
        
    }
    return self;
}


#pragma mark - Layout Configuration Views
- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect frame = CGRectInset([self bounds], 0.0f, 0.0f);
    
    [_bannerView setFrame:CGRectMake(CGRectGetMinX(frame) + 10, 9.0f, CGRectGetWidth(frame) - 20, 82)];
}

- (void)orderBtnClicked : (id)sender {
    
}

@end
