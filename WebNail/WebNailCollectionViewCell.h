//
//  WebNailCollectionViewCell.h
//  WebNail
//
//  Created by iamchiwon on 2015. 10. 27..
//  Copyright © 2015년 iamchiwon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebNailCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;

@end
