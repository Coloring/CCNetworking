//
//  ViewController.m
//  WHWNetWorking
//
//  Created by mac on 16/5/26.
//  Copyright © 2016年 Coloring. All rights reserved.
//

#import "ViewController.h"
#import "ProductModel.h"
#import "ProductServer.h"
#import "UIImageView+AFNetworking.h"
#import "AFImageDownloader.h"
#import "UIActivityIndicatorView+AFNetworking.h"
#import "AFAutoPurgingImageCache.h"


#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 20, 80, 40)];
    [button setTitle:@"Request" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor lightGrayColor];
    [button addTarget:self action:@selector(loadDate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 80, 40)];
    [button1 setTitle:@"removeImage" forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor lightGrayColor];
    [button1 addTarget:self action:@selector(removeImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 200, 300, 200)];
    imageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:imageView];
    
    
    
    NSURL *imgURL = [NSURL URLWithString:@"http://c.hiphotos.baidu.com/zhidao/pic/item/a6efce1b9d16fdfa95c7a1cab78f8c5494ee7b6e.jpg"];
    
    __block UIImageView *imgView = imageView;
    
    [imageView setImageWithURLRequest:[NSURLRequest requestWithURL:imgURL] placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
       
        NSLog(@"%@", request);
        
        imgView.image = image;
        
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        
    }];
    
    //AFNetWorking下给UIImageView添加旋转小转轮
    AFImageDownloadReceipt *af_activeImageDownloadReceipt = objc_getAssociatedObject(imageView, @selector(af_activeImageDownloadReceipt));
    
    
    
    NSURLSessionTask *afTask = af_activeImageDownloadReceipt.task;
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
//    activityView.backgroundColor = [UIColor redColor];
    [imageView addSubview:activityView];
    activityView.center = CGPointMake(imageView.frame.size.width/2, imageView.frame.size.height/2);
    [activityView setAnimatingWithStateOfTask:afTask];


    
    
}

- (void)removeImage {
    NSLog(@"removeImage");
    


    
//    [[UIImageView sharedImageDownloader].imageCache removeAllImages];
    
    NSLog(@"%lu", (unsigned long)[NSURLCache sharedURLCache].currentDiskUsage);
    NSLog(@"%lu", (unsigned long)[NSURLCache sharedURLCache].currentMemoryUsage);
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}


- (void)loadDate {
    [ProductServer whwQuanPostsWithBlock:^(NSArray *posts, NSError *error) {
        if (!error) {            
            NSLog(@"%@", posts);
            for (ProductModel *temp in posts) {
                    NSLog(@"%@",temp.goodsName);
            }
        } else {
            NSLog(@"%@", error);
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
