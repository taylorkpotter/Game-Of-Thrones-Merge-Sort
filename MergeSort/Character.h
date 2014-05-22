//
//  Character.h
//  MergeSort
//
//  Created by Taylor Potter on 5/22/14.
//  Copyright (c) 2014 potter.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Character : NSObject

@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, readonly) NSInteger heightIndex;

- (instancetype)initWithImageNamed:(NSString *)imageName heightIndex:(NSInteger)heightIndex;

@end
