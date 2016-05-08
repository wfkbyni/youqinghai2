//
//  ZTextViewCell.m
//  youqinghai
//
//  Created by snailz on 16/4/6.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZTextViewCell.h"
#import <UzysAssetsPickerController/UzysAssetsPickerController.h>
@interface ZTextViewCell()<UIActionSheetDelegate,UzysAssetsPickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIButton *_addImageBtn;
}

@property(nonatomic,strong)NSMutableArray *imagesURL;//存储要上传的图片路径
@property(nonatomic,strong) NSMutableArray *imageNames;
@property(nonatomic,weak) UIView *picView;
@end
@implementation ZTextViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    // Initialization code
}
-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        self.placeholder.hidden = NO;
    }else{
        self.placeholder.hidden = YES;
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location>=200&&![text isEqualToString:@""])
    {
        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您已输入200个字" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    else
    {
        return YES;
    }
}
/**
 *  设置上传图片组件
 *
 *  @param photo <#photo description#>
 */
-(void)setPhoto:(NSString *)photo
{
    if (!self.images) {
        self.images = [NSMutableArray array];
    }
    
    UIView *picView = [[UIView alloc]initWithFrame:CGRectMake(12, imageViewH, [UIScreen mainScreen].bounds.size.width-24, ImageH)];
    [self.contentView addSubview:picView];
    _picView = picView;
    
    _addImageBtn = [[UIButton alloc]init];
    _addImageBtn.frame = CGRectMake(5, 0, ImageH, ImageH);
    _addImageBtn.backgroundColor  = [UIColor colorWithWhite:0.902 alpha:1.000];
    [_addImageBtn setImage:[UIImage imageNamed:@"blackcamera"] forState:UIControlStateNormal];
    [_addImageBtn addTarget:self action:@selector(pickImageAction) forControlEvents:UIControlEventTouchUpInside];
    _addImageBtn.layer.borderWidth = 1;
    _addImageBtn.layer.borderColor = [UIColor colorWithWhite:0.800 alpha:1.000].CGColor;
    [self.picView addSubview:_addImageBtn];
  [self showImages];
}
/**
 *  上传选项
 */
-(void)pickImageAction
{
    [self endEditing:YES];
    if (self.images.count >=6) {
        UIAlertView *av= [[UIAlertView alloc]initWithTitle:@"提示" message:@"上传不能超过6张" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [av show];
        return;
    }
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"上传图片"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"相机", @"相册",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.controller.view];
}
//显示图片
-(void)showImages{
    if (self.images.count>=4) {
        self.picView.frame = CGRectMake(12, imageViewH, SCREEN_WIDTH-24, ImageH+5+ImageH);
    }else{
        self.picView.frame = CGRectMake(12, imageViewH, [UIScreen mainScreen].bounds.size.width-24, ImageH);
    }
    if (self.picView.subviews.count>0) {
        
        for (UIView *iv in self.picView.subviews) {
            if ([iv isMemberOfClass:[UIButton class]]) {
                continue;//是添加按钮，不删除
            }
            [iv removeFromSuperview];
        }
        
    }
    if (self.images.count==0) {
        _addImageBtn.frame = CGRectMake(5, 0, ImageH, ImageH);
        return;
    }
    
    CGFloat startX = 5;
    CGRect frame = CGRectMake(startX, 0, ImageH, ImageH);
    
    for (int i = 0; i < self.images.count; i++) {
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds=YES;
        iv.frame = frame;
        iv.image = self.images[i];
        iv.userInteractionEnabled =YES;
        //self.lastImageView = iv;
        frame.origin.x = frame.origin.x + frame.size.width + 5;
        
        if (frame.origin.x> (SCREEN_WIDTH-ImageH)) {
            frame.origin.x = startX;
            
            frame.origin.y = frame.origin.y+ImageH + 5;
        }
        
        [self.picView addSubview:iv];
        
        UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(ImageH-30, -15, 44, 44)];
        //deleteBtn.backgroundColor = [UIColor greenColor];
        [deleteBtn setImage:[UIImage imageNamed:@"delete_01"] forState:UIControlStateNormal];
        deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(11, 11, 11, 11);
        
        [deleteBtn addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchDown];
        deleteBtn.tag = i;//标记， 删除用
        deleteBtn.userInteractionEnabled = YES;
        [iv addSubview:deleteBtn];
        
        if ((int)self.images.count-1 == i) {//把添加按钮防灾图片最后
            CGRect fra = _addImageBtn.frame;
            fra.origin.x = frame.origin.x;
            fra.origin.y = frame.origin.y;
            _addImageBtn.frame = fra;
        }
    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==2) {
        return;
    }
    if (buttonIndex  == 0) {
        UIImagePickerController * imagePickerC = [[UIImagePickerController alloc]init];
        imagePickerC.delegate = self;
        imagePickerC.allowsEditing = YES;
        imagePickerC.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.controller  presentViewController:imagePickerC animated:YES completion:nil];
    }else if (buttonIndex == 1){
        UzysAssetsPickerController *picker = [[UzysAssetsPickerController alloc] init];
        
         picker.delegate = self;
         picker.maximumNumberOfSelectionPhoto = 9-(self.images.count+3);
      
        [self.controller  presentViewController:picker animated:YES completion:nil];
    }

}
#pragma mark - UzysAssetsPickerControllerDelegate
- (void)uzysAssetsPickerController:(UzysAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    __weak typeof(self) weakSelf = self;
    NSString * assetPropertyType = (NSString *)[assets[0] valueForProperty:@"ALAssetPropertyType"];
    if([assetPropertyType isEqualToString:@"ALAssetTypePhoto"]) //Photo
    {
        [assets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ALAsset *representation = obj;
            UIImage *img = [UIImage imageWithCGImage:representation.defaultRepresentation.fullScreenImage
                            ];
            if (weakSelf.images.count) {
                [weakSelf.images insertObject:img atIndex:weakSelf.images.count - 1];
            }else{
                [weakSelf.images addObject:img];
            }
            
            //            *stop = YES;
        }];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.imageBlcok) {
            self.imageBlcok(self.images);
        }
        
    });
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"%@",info);
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *img = info[UIImagePickerControllerEditedImage];
       
        if (self.images.count) {
            [self.images insertObject:img atIndex:self.images.count - 1];
        }else{
            [self.images addObject:img];
        }
        if (self.imageBlcok) {
            self.imageBlcok(self.images);
        }
    }];
}
-(void)deleteImage:(UIButton *)btn{
    
    if (self.images.count==0) {
        return;
    }
    //删除掉
    [self.images removeObjectAtIndex:btn.tag];
//    [self.imagesURL removeObjectAtIndex:btn.tag];
//    [self.imageNames removeObjectAtIndex:btn.tag];
    [self showImages];
    if (self.imageBlcok) {
        self.imageBlcok(self.images);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (self.TextBlcok) {
        self.TextBlcok(textView.text);
        
    }
}
@end
