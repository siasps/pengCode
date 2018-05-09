//
//  BackgroundView.m
//  DemoTable
//
//  Created by Max on 2017/4/26.
//  Copyright © 2017年 maxzhang. All rights reserved.
//

#import "BackgroundView.h"
#import "TopView.h"
#import "FirstTableView.h"
#import "SecondTableView.h"
#import "ViewController.h"

#ifndef kScreen_Width
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#endif

#ifndef kScreen_Height
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#endif

@implementation BackgroundView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        [self addGestureRecognizer:tapGesture];
        
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
        
        [self addGestureRecognizer:panGesture];
        
    }
    return self;
}


#pragma mark - 重载系统的hitTest方法

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    if (event.type == UIEventTypeRemoteControl) {
//        
//        NSLog(@"移动");
//    
//    }
//    
////    if (event.type == UIEventTypeMotion){
////
////        NSLog(@"其他");
////
////    }
//    
//    
//    //        return [super hitTest:point withEvent:event];
//
//    
//    ViewController *currentVC = (ViewController *)self.nextResponder;
//    currentVC.printPoint = point;
//    if ([self.topView pointInside:point withEvent:event]) {
//        self.scrollView.scrollEnabled = NO;
//        if (self.scrollView.contentOffset.x < kScreen_Width *0.5) {
//            return self.firstTableView;
//        } else {
//            return self.secondTableView;
//        }
//    } else {
//        self.scrollView.scrollEnabled = YES;
//        return [super hitTest:point withEvent:event];
//    }
//}


#pragma mark - 添加手势的相应方法

- (void)tapGestureAction:(UITapGestureRecognizer *)gesture
{
    CGPoint point = [gesture locationInView:self.topView];
    if (CGRectContainsPoint(self.topView.leftBtnFrame, point)) {
        if (self.scrollView.contentOffset.x > 0.5 * kScreen_Width) {
            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
            self.topView.selectedItemIndex = 0;
        }
    } else if (CGRectContainsPoint(self.topView.rightBtnFrame, point)) {
        if (self.scrollView.contentOffset.x < 0.5 * kScreen_Width) {
            [self.scrollView setContentOffset:CGPointMake(kScreen_Width, 0) animated:NO];
            self.topView.selectedItemIndex = 1;
        }
    }
}



- (void)panGestureAction:(UIPanGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        self.tableViewOfffset_y = self.firstTableView.contentOffset.y;
        
    }else if (gesture.state == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [gesture translationInView:self];
        
        float y = self.tableViewOfffset_y -translation.y;
        
        NSLog(@"%.2f",y);

        if (y < 0) {
            
            float offset =   35 - (kScreen_Width -y)*(kScreen_Width -y)/kScreen_Width/kScreen_Width*35;
            CGPoint point = CGPointMake(0, offset);
            [self.firstTableView setContentOffset:point];
            [self.secondTableView setContentOffset:point];
            
        }else{
            CGPoint point = CGPointMake(0, y);
            [self.firstTableView setContentOffset:point];
            [self.secondTableView setContentOffset:point];

        }
        
    }else if (gesture.state == UIGestureRecognizerStateEnded){
        
        CGPoint translation = [gesture translationInView:self];
        
        float y = self.tableViewOfffset_y -translation.y;
        
            if (y < 0) {
                
                y = 0;
                CGPoint point = CGPointMake(0, 0);
                [self.firstTableView setContentOffset:point animated:YES];
                [self.secondTableView setContentOffset:point animated:YES];
            }
        
        NSLog(@"%.2f",y);
    }
}

@end
