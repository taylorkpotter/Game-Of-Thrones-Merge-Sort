//
//  Character.m
//  MergeSort
//
//  Created by Taylor Potter on 5/22/14.
//  Copyright (c) 2014 potter.io. All rights reserved.
//

#import "Character.h"

@interface Character ()

@property (nonatomic, readwrite) NSInteger heightIndex;
@property (nonatomic, strong) UIImageView *imageViewForCharacter;
@end

@implementation Character

- (instancetype)initWithImageNamed:(NSString *)imageName heightIndex:(NSInteger)heightIndex
{
  if (self = [super init]) {
    self.imageName = imageName;
    self.heightIndex = heightIndex;
    self.image = [UIImage imageNamed:imageName];
  }
  
  return self;
}


@end
