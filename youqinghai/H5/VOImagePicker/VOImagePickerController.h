//
//  VOImagePickerController.h
//  VOImagePicker
//
//  Created by Katsuma Tanaka on 2015/04/03.
//  Copyright (c) 2015 Katsuma Tanaka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
 
@class VOImagePickerController;

@protocol VOImagePickerControllerDelegate <NSObject>

@optional
- (void)vo_imagePickerController:(VOImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets;
- (void)vo_imagePickerControllerDidCancel:(VOImagePickerController *)imagePickerController;

- (BOOL)vo_imagePickerController:(VOImagePickerController *)imagePickerController shouldSelectAsset:(PHAsset *)asset;
- (void)vo_imagePickerController:(VOImagePickerController *)imagePickerController didSelectAsset:(PHAsset *)asset;
- (void)vo_imagePickerController:(VOImagePickerController *)imagePickerController didDeselectAsset:(PHAsset *)asset;

@end

typedef NS_ENUM(NSUInteger, VOImagePickerMediaType) {
    VOImagePickerMediaTypeAny = 0,
    VOImagePickerMediaTypeImage,
    VOImagePickerMediaTypeVideo
};

@interface VOImagePickerController : UIViewController

@property (nonatomic, weak) id<VOImagePickerControllerDelegate> delegate;

@property (nonatomic, copy) NSArray *assetCollectionSubtypes;
@property (nonatomic, assign) VOImagePickerMediaType mediaType;

@property (nonatomic, assign) BOOL allowsMultipleSelection;
@property (nonatomic, assign) NSUInteger minimumNumberOfSelection;
@property (nonatomic, assign) NSUInteger maximumNumberOfSelection;

@property (nonatomic, copy) NSString *prompt;
@property (nonatomic, assign) BOOL showsNumberOfSelectedAssets;

@property (nonatomic, assign) NSUInteger numberOfColumnsInPortrait;
@property (nonatomic, assign) NSUInteger numberOfColumnsInLandscape;

@end
