//
//  PublishTravelsController.m
//  youqinghai
//
//  Created by 舒永超 on 16/4/26.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "PublishTravelsController.h"
#import "YYTextView.h"
#include <AVFoundation/AVFoundation.h>
#import "VOImagePickerController.h"
#import "QBImagePickerController.h"

@interface PublishTravelsController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,VOImagePickerControllerDelegate,QBImagePickerControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    NSMutableArray *collectionData;
}

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) YYTextView *yyTextView;
@property (nonatomic, strong) UICollectionView *myCollectionView;

@end

@implementation PublishTravelsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发布";
    
    [self.view setBackgroundColor:[UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.00]];
    
    [self navBarButtonItem];
    
    [self commonTableView];
 
    collectionData = [NSMutableArray array];
}

- (void)navBarButtonItem{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(submitAction:)];
}

- (void)commonTableView{
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, kScreenSize.width, CGRectGetHeight(self.view.bounds))];
    [_myTableView setScrollEnabled:NO];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    [_myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    
    [self.view addSubview:_myTableView];
}

- (void)cancelAction:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)submitAction:(id)sender{
    [self.view makeToast:@"开发中"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 120.0f;
    }
    return 120.0f;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        
        _yyTextView = [cell viewWithTag:1000];
        if (!_yyTextView) {
            _yyTextView = self.yyTextView;
            _yyTextView.tag = 1000;
            [cell.contentView addSubview:_yyTextView];
        }
        
        return cell;
        
    }else if(indexPath.row == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        _myCollectionView = [cell viewWithTag:2000];
        if (!_myCollectionView) {
            _myCollectionView = self.myCollectionView;
            _myCollectionView.tag = 2000;
            [cell.contentView addSubview:_myCollectionView];
        }
        
        return cell;
    }
    return nil;
}

- (YYTextView *)yyTextView{
    if (!_yyTextView) {
        _yyTextView = [[YYTextView alloc] initWithFrame:CGRectMake(10, 0, kScreenSize.width - 20, 120)];
        [_yyTextView setPlaceholderText:@"说说您想给大家分享的内容吧!"];
        [_yyTextView setPlaceholderFont:[UIFont systemFontOfSize:14.0f]];
        [_yyTextView setFont:[UIFont systemFontOfSize:14.0f]];
    }
    
    return _yyTextView;
}

- (UICollectionView *)myCollectionView{
    if (!_myCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake([self viewWidth], [self viewWidth]);
        layout.minimumInteritemSpacing = 5;
        layout.minimumLineSpacing = 5;
        
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 0) collectionViewLayout:layout];
        [_myCollectionView setBackgroundColor:[UIColor whiteColor]];
        [self changeCollectionViewHeight];
        _myCollectionView.dataSource = self;
        _myCollectionView.delegate = self;
        
        [_myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewCell"];
    }
    
    return _myCollectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return collectionData.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    
    UIImageView *imageView = [cell viewWithTag:1000 + indexPath.row];
    if (!imageView) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [self viewWidth], [self viewWidth])];
        imageView.tag = 1000 + indexPath.row;
        [cell.contentView addSubview:imageView];
    }
    
    if (collectionData.count == indexPath.row) {
        
    }else{
        [imageView sd_setImageWithURL:[NSURL URLWithString:collectionData[indexPath.row]]];
    }
    
    [imageView setBackgroundColor:[UIColor colorWithRed:arc4random_uniform(255.0f) / 255.0f green:arc4random_uniform(255.0f) / 255.0f blue:arc4random_uniform(255.0f) / 255.0f alpha:1]];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (([UIDevice currentDevice].systemVersion.floatValue > 8.0)) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self choosePhotoActionWithType:0];
        }];
        UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"手机相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self choosePhotoActionWithType:1];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:takePhotoAction];
        [alertController addAction:albumAction];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else{
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图片"
                                                                 delegate:self
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"拍照", @"手机相册", nil];
        [actionSheet showInView:self.view];
    }
}

#define rowCount 5
#define lineSpacing 5
- (CGFloat)viewWidth{
    
    CGFloat width = (kScreenSize.width - lineSpacing * (rowCount + 1)) / rowCount;
    
    return width;
}

- (void)changeCollectionViewHeight{
    NSInteger row = collectionData.count / rowCount + 1;
    
    CGRect frame = _myCollectionView.frame;
    frame.size.height = row * [self viewWidth] + (row + 1) * lineSpacing;
    _myCollectionView.frame = frame;
}



#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    return [self choosePhotoActionWithType:buttonIndex];
}
- (void)choosePhotoActionWithType:(NSInteger)type{
    if (type == 0) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if(authStatus == AVAuthorizationStatusDenied){
            if (([UIDevice currentDevice].systemVersion.floatValue > 8.0)) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"系统提示" message:@"请在“设置-隐私-相机”页面开启应用程序访问权限" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"系统提示"
                                                                message:@"请在“设置-隐私-相机”页面开启应用程序访问权限"
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"确定", nil];
                [alert show];
            }
            return;
        }
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.modalPresentationStyle = UIModalPresentationCurrentContext;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            [self.navigationController presentViewController:imagePicker
                                                                        animated:YES
                                                                      completion:nil];
        }
        else{
            YQHLog(@"%@",@"当前相机不可用");
        }
    }else if (type == 1) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            if ([UIDevice currentDevice].systemVersion.floatValue > 8.0) {
                VOImagePickerController *imagePicker = [[VOImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.allowsMultipleSelection = YES;
                imagePicker.mediaType = VOImagePickerMediaTypeImage;
                imagePicker.maximumNumberOfSelection = 9 - collectionData.count;
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
            else{
                QBImagePickerController *imagePicker = [[QBImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.allowsMultipleSelection = YES;
                imagePicker.filterType = QBImagePickerControllerFilterTypePhotos;
                imagePicker.maximumNumberOfSelection = 9 - collectionData.count;
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
        }
        else{
            YQHLog(@"%@",@"当前相机不可用");
        }
    }
}


#pragma mark - UIImagePickerControllerDelegate
- (NSString *)UUID{
    CFUUIDRef puuid        = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result      = (__bridge_transfer NSString *)uuidString;
    CFRelease(puuid);
    return result;
}

- (NSString*)documentDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    @autoreleasepool {
        NSData *finalImageData = UIImageJPEGRepresentation(image, 0.8);
        if(finalImageData == nil){
            finalImageData = UIImagePNGRepresentation(image);
        }
        
        NSString *fileName = [[self UUID] stringByAppendingString:@".jpg"];
        NSArray *pathComponents = @[[self documentDirectory],fileName];
        
        NSString *filePath = [[NSURL fileURLWithPathComponents:pathComponents] path];
        
        [finalImageData writeToFile:filePath
                         atomically:YES];
#ifdef WX_DEBUG
        NSDictionary *fileInfo = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        WXLog(@"fileSize: %.2f MB\nfilePath: %@",[fileInfo[NSFileSize] floatValue] /(1024*1024),filePath);
#endif
        NSURL *url = [NSURL fileURLWithPath:filePath];
        if (!collectionData) {
            collectionData = [NSMutableArray arrayWithObject:@[url.absoluteString]];
        }
        else{
            collectionData = [NSMutableArray arrayWithObjects:[collectionData arrayByAddingObject:url.absoluteString], nil];
        }
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - QBImagePickerControllerDelegate

- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController{
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets
{
    [imagePickerController dismissViewControllerAnimated:YES completion:^{
        //[self.view showLoadingHudWithText:nil];
        __block NSMutableArray *signals = [NSMutableArray array];
        @autoreleasepool {
            [assets enumerateObjectsUsingBlock:^(ALAsset *aAsset, NSUInteger idx, BOOL *stop) {
                RACSignal *signal = [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                    ALAssetRepresentation *rep = [aAsset defaultRepresentation];
                    CGImageRef ref = [rep fullResolutionImage];
                    if (ref) {
                        UIImage *image = [[UIImage alloc] initWithCGImage:ref];
                        CGSize imageSize = image.size;
                        CGFloat scale = MIN(MIN(kScreenSize.width/imageSize.width, kScreenSize.height / imageSize.height) * 3, 1);
                        image = [self scaleImage:image toScale:scale];
                        
                        NSData *finalImageData = UIImageJPEGRepresentation(image, 0.8);
                        
                        if(finalImageData == nil){
                            finalImageData = UIImagePNGRepresentation(image);
                        }
                        
                        NSString *fileName = [[self UUID] stringByAppendingString:@".jpg"];
                        NSArray *pathComponents = @[[self documentDirectory],fileName];
                        
                        NSString *filePath = [[NSURL fileURLWithPathComponents:pathComponents] path];
                        
                        [finalImageData writeToFile:filePath
                                         atomically:YES];
#ifdef WX_DEBUG
                        NSDictionary *fileInfo = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
                        WXLog(@"fileSize: %.2f MB\nfilePath: %@",[fileInfo[NSFileSize] floatValue] /(1024*1024),filePath);
#endif
                        NSURL *url = [NSURL fileURLWithPath:filePath];
                        [subscriber sendNext:url.absoluteString];
                        [subscriber sendCompleted];
                    }
                    else{
                        [subscriber sendCompleted];
                    }
                    return nil;
                }] subscribeOn:[RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground]] deliverOn:[RACScheduler mainThreadScheduler]];
                [signals addObject:signal];
            }];
        }
        
        __block NSMutableArray *imageUrls = collectionData.count > 0? [collectionData mutableCopy] :@[].mutableCopy;
        [[[RACSignal merge:signals]
          deliverOn:[RACScheduler mainThreadScheduler]]
         subscribeNext:^(id x) {
             [imageUrls addObject:x];
         } completed:^{
             collectionData = imageUrls;
             
             [self changeCollectionViewHeight];
             [self.myCollectionView reloadData];
         }];
    }];
}


#pragma mark - VOImagePickerControllerDelegate

- (void)vo_imagePickerControllerDidCancel:(VOImagePickerController *)imagePickerController{
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

- (void)vo_imagePickerController:(VOImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets{
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
    __block NSMutableArray *signals = [NSMutableArray array];
    [assets enumerateObjectsUsingBlock:^(PHAsset *aAsset, NSUInteger idx, BOOL *stop) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            CGFloat scale = MIN(MIN(kScreenSize.width/aAsset.pixelWidth, kScreenSize.height / aAsset.pixelHeight) * 3, 1);
            CGSize targetSize = CGSizeMake(aAsset.pixelWidth * scale, aAsset.pixelHeight * scale);
            PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
            options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;            options.synchronous = NO;
            options.networkAccessAllowed = YES;
            options.progressHandler = ^(double progress, NSError *error, BOOL *stop, NSDictionary *info) {
                YQHLog(@"%f", progress);
            };
            [[PHImageManager defaultManager] requestImageForAsset:aAsset targetSize:targetSize contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info){
                YQHLog(@"size:%@",NSStringFromCGSize(result.size));
                NSData *imageData = UIImageJPEGRepresentation(result, 0.8);
                
                if(imageData == nil){
                    imageData = UIImagePNGRepresentation(result);
                }
                NSString *fileName = [[self UUID] stringByAppendingString:@".jpg"];
                NSArray *pathComponents = @[[self documentDirectory],fileName];
                NSString *filePath = [[NSURL fileURLWithPathComponents:pathComponents] path];
                [imageData writeToFile:filePath
                            atomically:YES];
#ifdef WX_DEBUG
                NSDictionary *fileInfo = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
                WXLog(@"fileSize: %.2f MB\nfilePath: %@",[fileInfo[NSFileSize] floatValue] /(1024*1024),filePath);
#endif
                NSURL *url = [NSURL fileURLWithPath:filePath];
                [subscriber sendNext:url.absoluteString];
                [subscriber sendCompleted];
            }];
            return nil;
        }];
        [signals addObject:signal];
    }];

    __block NSMutableArray *imageUrls = collectionData > 0? [collectionData mutableCopy] :@[].mutableCopy;
    [[RACSignal merge:signals] subscribeNext:^(id x) {
        [imageUrls addObject:x];
    } completed:^{
        
        collectionData = imageUrls;
        
        [self changeCollectionViewHeight];
        
        [self.myCollectionView reloadData];
    }];
}

- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scale{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scale, image.size.height * scale));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scale, image.size.height * scale)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
