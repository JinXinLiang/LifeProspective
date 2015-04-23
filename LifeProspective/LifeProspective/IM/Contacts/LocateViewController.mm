//
//  LocateViewController.m
//  BmobIMDemo
//
//  Created by Bmob on 14-7-21.
//  Copyright (c) 2014年 bmob. All rights reserved.
//

#import "LocateViewController.h"
#import "BMapKit.h"
#import "CommonUtil.h"
#import "ChatViewController.h"

@interface LocateViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
//{
////    BMKMapView                  *_mapView;     //百度地图
//    BMKLocationService          *_locService;  //定位
//    BMKGeoCodeSearch            *_geocodesearch;//地理编码
//    CLLocationCoordinate2D      _currentLocationCoordinate2D;//当前百度坐标
//    NSMutableString             *_addressString;//当前地理位置
//}

@property (nonatomic, strong)BMKMapView *mapView; //百度地图
@property (nonatomic, strong)BMKLocationService *locService;
@property (nonatomic, strong)BMKGeoCodeSearch *geocodesearch;
@property (nonatomic, assign)CLLocationCoordinate2D currentLocationCoordinate2D;
@property (nonatomic, strong)NSMutableString *addressString;
@end

@implementation LocateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.navigationItem.titleView  = [CommonUtil navigationTitleViewWithTitle:@"位置"];
        self.addressString = [[NSMutableString alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *rightButton                  = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame                      = CGRectMake(0, 0, 50, 44);
    [[rightButton titleLabel] setFont:[UIFont systemFontOfSize:15]];
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem             = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    ;
    //地图
    self.mapView                   = [[BMKMapView alloc] init];
    self.mapView.frame             = CGRectMake(0, ViewOriginY, SCREENWIDTH, SCREENHEIGHT - ViewOriginY);
    self.mapView.zoomLevel         = 17.0f;
    [self.view addSubview:self.mapView];

    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    [BMKLocationService setLocationDistanceFilter:100.f];
    //定位服务
    self.locService                = [[BMKLocationService alloc]init];
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyBest];
    self.mapView.userTrackingMode  = BMKUserTrackingModeFollow;
    self.mapView.showsUserLocation = YES;
    [self.locService startUserLocationService];
    
//    [self.locService startUserLocationService];
//    self.mapView.showsUserLocation = NO;
    
    
    //初始化BMKLocationService
    //启动LocationService
    self.geocodesearch = [[BMKGeoCodeSearch alloc]init];
    self.currentLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0);
  

    //geo
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.mapView viewWillAppear];
    self.mapView.delegate       = self;
    self.geocodesearch.delegate = self;
    self.locService.delegate       = self;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.mapView viewWillDisappear];
    self.mapView.delegate       = nil;
    self.geocodesearch.delegate = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)goback{
    [self.locService stopUserLocationService];
    self.locService.delegate = nil;
    [super goback];
}

-(void)dealloc{
    
}

-(void)send{
    [self goback];
    ChatViewController *tmpCvc = (ChatViewController *)[self.navigationController topViewController];
    [tmpCvc location:self.currentLocationCoordinate2D address:self.addressString];
    self.addressString = nil;
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    [self.mapView updateLocationData:userLocation];
    [self.locService stopUserLocationService];
    //现在的坐标
    CLLocationCoordinate2D coor                         = [[userLocation location] coordinate];
    self.currentLocationCoordinate2D                        = coor;
    //反geo地理编码
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint          = coor;
    [self.geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [self.mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher
                           result:(BMKReverseGeoCodeResult *)result
                        errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        if (result.address) {
            [self.addressString setString:result.address];
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }
    }
    
}
//定位失败

-(void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    
    NSLog(@"定位错误%@",error);
    
//    isMap=2;
    
    [mapView setShowsUserLocation:NO];
    
}

@end
