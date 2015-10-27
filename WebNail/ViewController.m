//
//  ViewController.m
//  WebNail
//
//  Created by iamchiwon on 2015. 10. 27..
//  Copyright © 2015년 iamchiwon. All rights reserved.
//

#import "ViewController.h"
#import "WebNailGetter.h"
#import "WebNailCollectionViewCell.h"

@interface ViewController () <UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet UICollectionView *nailCollectionView;
@property (weak, nonatomic) IBOutlet UIView *nailView;

@property (strong, nonatomic) NSMutableArray *datasource;
@property (strong, nonatomic) WebNailGetter *getter;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datasource= [NSMutableArray array];
    self.getter= [[WebNailGetter alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onResignKeyboard:(id)sender {
    [self.addressField resignFirstResponder];
}

- (IBAction)onGetImage:(id)sender {
    [self.datasource addObject:self.addressField.text];
    [self.nailCollectionView reloadData];
    
    [self.addressField resignFirstResponder];
    self.addressField.text= @"";
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datasource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WebNailCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"WebNailCollectionViewCell" forIndexPath:indexPath];
    
    NSUInteger index= indexPath.row;
    cell.urlLabel.text= self.datasource[index];
    [self.getter getImageWithAddress:cell.urlLabel.text
                          onComplete:^(NSString *url, UIImage *nail) {
                              cell.urlLabel.text= url;
                              cell.thumbnailImageView.image= nail;
                          }];
    
    return cell;
}


@end
