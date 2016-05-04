//
//  VOAssetCell.h
//  VOImagePicker
//
//  Created by Katsuma Tanaka on 2015/04/03.
//  Copyright (c) 2015 Katsuma Tanaka. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VOVideoIndicatorView;

@interface VOAssetCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet VOVideoIndicatorView *videoIndicatorView;

@property (nonatomic, assign) BOOL showsOverlayViewWhenSelected;

@end
