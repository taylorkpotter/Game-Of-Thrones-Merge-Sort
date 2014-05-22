//
//  ViewController.m
//  MergeSort
//
//  Created by Taylor Potter on 5/21/14.
//  Copyright (c) 2014 potter.io. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
#import "Character.h"

@interface ViewController () <UICollectionViewDataSource>
@property (strong, nonatomic) NSMutableArray *characterList;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@end

@implementation ViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupArray];
//    [self mergeSort:_characterList];

  
}

- (BOOL)canBecomeFirstResponder
{
  return YES;
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  [self becomeFirstResponder];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
  NSLog(@"Shake");
  if (motion == UIEventSubtypeMotionShake) {
//    [self randomizeArray:_characterList];
    _characterList = [NSMutableArray arrayWithArray:[self mergeSort:_characterList]];
    [_collectionView performBatchUpdates:^{
      [_collectionView reloadItemsAtIndexPaths:_collectionView.indexPathsForVisibleItems];
    } completion:^(BOOL finished) {
      
    }];
  }
}
- (void)setupArray
{
  _characterList = [NSMutableArray new];
  for (int i = 0; i < 100; i++)
  {
    NSString *imageName = [NSString stringWithFormat:@"%d.png",i];
    Character *newCharacter = [[Character alloc] initWithImageNamed:imageName heightIndex:i];
    [_characterList addObject:newCharacter];
  }
  
  [self randomizeArray:_characterList];
  
}

-(NSArray *)mergeSort:(NSArray *)unsortedArray
{
  NSLog(@"Unsorted Array: %@", unsortedArray);
  if ([unsortedArray count] < 2)
  {
    return unsortedArray;
  }
  long middle = ([unsortedArray count]/2);
  NSRange left = NSMakeRange(0, middle);
  NSRange right = NSMakeRange(middle, ([unsortedArray count] - middle));
  NSArray *rightArr = [unsortedArray subarrayWithRange:right];
  NSArray *leftArr = [unsortedArray subarrayWithRange:left];
  //Or iterate through the unsortedArray and create your left and right array
  //for left array iteration starts at index =0 and stops at middle, for right array iteration starts at midde and end at the end of the unsorted array
  NSArray *resultArray =[self merge:[self mergeSort:leftArr] andRight:[self mergeSort:rightArr]];
  
  NSLog(@"Sorted Array: %@", resultArray);
  return resultArray;
}

-(NSArray *)merge:(NSArray *)leftArr andRight:(NSArray *)rightArr
{
  NSMutableArray *result = [[NSMutableArray alloc] init];
  int right = 0;
  int left = 0;
  while (left < [leftArr count] && right < [rightArr count])
  {
    if ([[leftArr objectAtIndex:left] heightIndex] < [[rightArr objectAtIndex:right] heightIndex])
    {
      [result addObject:[leftArr objectAtIndex:left++]];
    }
    else
    {
      [result addObject:[rightArr objectAtIndex:right++]];
    }
  }
  NSRange leftRange = NSMakeRange(left, ([leftArr count] - left));
  NSRange rightRange = NSMakeRange(right, ([rightArr count] - right));
  NSArray *newRight = [rightArr subarrayWithRange:rightRange];
  NSArray *newLeft = [leftArr subarrayWithRange:leftRange];
  newLeft = [result arrayByAddingObjectsFromArray:newLeft];
  return [newLeft arrayByAddingObjectsFromArray:newRight];
}


-(void)randomizeArray:(NSMutableArray *)arrayToRandomize
{
  NSUInteger count = [arrayToRandomize count];
  for (NSUInteger i=0; i<count; i++) {
    NSInteger nElements = count - i;
    NSInteger n = arc4random_uniform((u_int16_t)nElements) + i;
    [arrayToRandomize exchangeObjectAtIndex:i withObjectAtIndex:n];
  }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return _characterList.count;
  
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  CustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
  
  Character *character = _characterList[indexPath.row];
  
  cell.cellImageView.image = nil;
  if (character.image) {
    cell.cellImageView.image = character.image;
  }
  
  return cell;
}

@end
