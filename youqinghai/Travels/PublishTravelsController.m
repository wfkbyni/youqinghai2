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
#import "TravelsViewModel.h"

@interface PublishTravelsController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,VOImagePickerControllerDelegate,QBImagePickerControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    NSMutableArray *collectionData;
    TravelsViewModel *viewModel;
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
    viewModel = [TravelsViewModel new];
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
    [_yyTextView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)submitAction:(id)sender{
    
    [_yyTextView resignFirstResponder];
    
    if (_yyTextView.text.length == 0) {
        [self.view makeToast:@"游记内容不能为空"];
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    RACSignal *signal = [viewModel publishTravelsWithContent:@"abcd" withFiles:collectionData];
    [signal subscribeNext:^(ResponseBaseData *data) {
        if (data.result_code == 0) {
            [self.navigationController.view makeToast:@"游记发表成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
    } error:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
        [self.view makeToast:[error.userInfo objectForKey:@"message"]];
    }];
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
    if (imageView) {
        [imageView removeFromSuperview];
        imageView = nil;
    }
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [self viewWidth], [self viewWidth])];
    imageView.tag = 1000 + indexPath.row;
    [cell.contentView addSubview:imageView];
    
    UIButton *deleteBtn = [cell viewWithTag:indexPath.row + 100];
    if (deleteBtn) {
        [deleteBtn removeFromSuperview];
        deleteBtn = nil;
    }
    deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(CGRectGetMaxX(imageView.frame) - 20, CGRectGetMinX(imageView.frame), 20, 20);
    [deleteBtn setImage:[UIImage imageNamed:@"delete_01"] forState:UIControlStateNormal];
    [cell.contentView addSubview:deleteBtn];
    deleteBtn.tag = indexPath.row + 100;
    [deleteBtn addTarget:self action:@selector(deleteImageView:) forControlEvents:UIControlEventTouchUpInside];
    
    if (collectionData.count == indexPath.row) {
        
        deleteBtn.hidden = YES;
        [imageView setImage:[UIImage imageNamed:@"游记_发布_06"]];
    }else{
        deleteBtn.hidden = NO;
        [imageView setImage:collectionData[indexPath.row]];
    }
    
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (collectionData.count == indexPath.row) {
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
}

- (void)deleteImageView:(UIButton *)sender{
    NSInteger tag = sender.tag - 100;
    
    NSObject *obj = collectionData[tag];
    if (obj) {
        
        [collectionData removeObject:obj];
        
        [self changeCollectionViewHeight];
        
        [self.myCollectionView reloadData];
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    @autoreleasepool {
        CGSize imageSize = image.size;
        CGFloat scale = MIN(MIN(kScreenSize.width/imageSize.width, kScreenSize.height / imageSize.height) * 3, 1);
        image = [self scaleImage:image toScale:scale];
        
        [collectionData addObject:image];
        
        [self changeCollectionViewHeight];
        
        [self.myCollectionView reloadData];
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
        @autoreleasepool {
            [assets enumerateObjectsUsingBlock:^(ALAsset *aAsset, NSUInteger idx, BOOL *stop) {
                ALAssetRepresentation *rep = [aAsset defaultRepresentation];
                CGImageRef ref = [rep fullResolutionImage];
                if (ref) {
                    UIImage *image = [[UIImage alloc] initWithCGImage:ref];
                    CGSize imageSize = image.size;
                    CGFloat scale = MIN(MIN(kScreenSize.width/imageSize.width, kScreenSize.height / imageSize.height) * 3, 1);
                    image = [self scaleImage:image toScale:scale];
                    
                    [collectionData addObject:image];
                }
                else{
                    
                }

            }];
            
            
            [self changeCollectionViewHeight];
            
            [self.myCollectionView reloadData];
        }
        
    }];
}


#pragma mark - VOImagePickerControllerDelegate

- (void)vo_imagePickerControllerDidCancel:(VOImagePickerController *)imagePickerController{
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

- (void)vo_imagePickerController:(VOImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets{
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
    [assets enumerateObjectsUsingBlock:^(PHAsset *aAsset, NSUInteger idx, BOOL *stop) {
        CGFloat scale = MIN(MIN(kScreenSize.width/aAsset.pixelWidth, kScreenSize.height / aAsset.pixelHeight) * 3, 1);
        CGSize targetSize = CGSizeMake(aAsset.pixelWidth * scale, aAsset.pixelHeight * scale);
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;            options.synchronous = NO;
        options.networkAccessAllowed = YES;
        options.progressHandler = ^(double progress, NSError *error, BOOL *stop, NSDictionary *info) {
            YQHLog(@"%f", progress);
        };
        [[PHImageManager defaultManager] requestImageForAsset:aAsset targetSize:targetSize contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info){
            YQHLog(@"before size:%@",NSStringFromCGSize(result.size));
            
            CGSize imageSize = result.size;
            CGFloat scale = MIN(MIN(kScreenSize.width/imageSize.width, kScreenSize.height / imageSize.height) * 3, 1);
            result = [self scaleImage:result toScale:scale];
            
            YQHLog(@"after size:%@",NSStringFromCGSize(result.size));
            
            [collectionData addObject:result];
            
            [self changeCollectionViewHeight];
            
            [self.myCollectionView reloadData];

        }];
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
