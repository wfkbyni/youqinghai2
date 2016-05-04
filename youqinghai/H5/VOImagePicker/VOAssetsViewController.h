//
//  VOAssetsViewController.h
//  VOImagePicker
//
//  Created by Katsuma Tanaka on 2015/04/03.
//  Copyright (c) 2015 Katsuma Tanaka. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VOImagePickerController;
@class PHAssetCollection;

@interface VOAssetsViewController : UICollectionViewController

@property (nonatomic, weak) VOImagePickerController *imagePickerController;
@property (nonatomic, strong) PHAssetCollection *assetCollection;

@end
