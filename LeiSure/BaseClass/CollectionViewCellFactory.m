//
//  CollectionViewCellFactory.m
//  LeiSure
//
//  Created by lanou on 16/6/15.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "CollectionViewCellFactory.h"

@implementation CollectionViewCellFactory

+ (BaseCollectionViewCell *)CellWithCollectionView:(UICollectionView *)collectionView Identifier:(NSString *)identifier IndexPath:(NSIndexPath *)indexPath {
    
    BaseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    return cell;
}

@end
