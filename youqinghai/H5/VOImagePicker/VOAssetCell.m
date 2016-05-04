//
//  VOAssetCell.m
//  VOImagePicker
//
//  Created by Katsuma Tanaka on 2015/04/03.
//  Copyright (c) 2015 Katsuma Tanaka. All rights reserved.
//

#import "VOAssetCell.h"

@interface VOAssetCell ()

@property (weak, nonatomic) IBOutlet UIView *overlayView;

@end

@implementation VOAssetCell

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    // Show/hide overlay view
    self.overlayView.hidden = !(selected && self.showsOverlayViewWhenSelected);
}

@end
