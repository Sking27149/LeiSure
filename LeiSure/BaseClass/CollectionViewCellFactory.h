//
//  CollectionViewCellFactory.h
//  LeiSure
//
//  Created by lanou on 16/6/15.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseCollectionViewCell.h"

@interface CollectionViewCellFactory : NSObject

//统一创建方法 由于cell需要重用 所以要把重用所需的参数都传进来
+ (BaseCollectionViewCell *)CellWithCollectionView:(UICollectionView *)collectionView Identifier:(NSString *)identifier IndexPath:(NSIndexPath *)indexPath;

@end
