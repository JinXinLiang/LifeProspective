//
//  DetailViewController.m
//  ArticleDetail
//
//  Created by Eiwodetianna on 15/3/2.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DetailViewController.h"
#import "Article.h"
#import "UIColor+AddColor.h"

@interface DetailViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *detailView;


@end

@implementation DetailViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (IS_iOS8) {
        
        self.navigationController.hidesBarsOnSwipe = NO;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.detailView.opaque = NO;
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backgroundView.image = [UIImage imageNamed:@"background"];
    [self.view addSubview:backgroundView];
    [self.view sendSubviewToBack:backgroundView];
    if (IS_iOS8) {
        
        self.navigationController.hidesBarsOnSwipe = YES;
    }
    self.detailView.scrollView.showsVerticalScrollIndicator = NO;
    self.detailView.backgroundColor = [UIColor clearColor];
    self.detailView.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.detailView.opaque = NO;
    NSString *jsString = [NSString stringWithFormat:@"<html> \n"
                          "<head> \n"
                          "<meta name=\"viewport\" content=\"width=device-width-30\">"
                          "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">"
                          "<style type=\"text/css\"> \n"
                          "body {font-size: 15.5; text-align:justify; line-height: 1.5; font-family: Heiti SC; background-color:transparent}\n"
                          "a {text-decoration:none; color: #145b7d}"
                          "</style> \n"
                          "</head> \n"
                          "<body>%@</body> \n"
                          "</html>", self.articleModel.body];
//            NSString *jsString = [NSString stringWithFormat:@"<html> \n"
//                                  "<head> \n"
//                                  "<style type=\"text/css\"> \n"
//                                  "body {font-size: 16.5; text-align:justify; line-height: 1.5; font-family: Heiti SC; color: #3e4145}\n"
//                                  "a {text-decoration:none; color: #145b7d}"
//                                  "</style> \n"
//                                  "</head> \n"
//                                  "<body>%@</body> \n"
//                                  "</html>", self.articleModel.body];
            [self.detailView loadHTMLString:jsString baseURL:nil];
    


}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    //拦截网页图片  并修改图片大小
    [webView stringByEvaluatingJavaScriptFromString:
     [NSString stringWithFormat:@"var script = document.createElement('script');"
      "script.type = 'text/javascript';"
      "script.text = \"function ResizeImages() { "
      "var myimg,oldwidth;"
      "var maxwidth= %f;" //缩放系数,调动这个参数可以改变图片的宽度
      "for(i=0;i <document.images.length;i++){"
      "myimg = document.images[i];"
      "oldwidth = myimg.width;"
      "myimg.width = maxwidth;"
      "myimg.height = myimg.height;"
      "}"
      "}\";"
      "document.getElementsByTagName('head')[0].appendChild(script);", [UIScreen mainScreen].bounds.size.width - 25]];
    
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    //拦截网页图片  并修改图片大小
    [webView stringByEvaluatingJavaScriptFromString:
     [NSString stringWithFormat:@"var script = document.createElement('script');"
      "script.type = 'text/javascript';"
      "script.text = \"function ResizeImages() { "
      "var myimg,oldwidth;"
      "var maxwidth= %f;" //缩放系数,调动这个参数可以改变图片的宽度
      "for(i=0;i <document.images.length;i++){"
      "myimg = document.images[i];"
      "oldwidth = myimg.width;"
      "myimg.width = maxwidth;"
      "myimg.height = myimg.height;"
      "}"
      "}\";"
      "document.getElementsByTagName('head')[0].appendChild(script);", [UIScreen mainScreen].bounds.size.width - 25]];
    
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
