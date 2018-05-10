# nestScrollView
nested tableView slide fluency
项目中需要用到UIScrollView嵌套UItableView嵌套交互问题，顺便网上搜了下的demo，地址
https://github.com/maxzhang123/nestScrollView
写的非常具有借鉴意义，容易理解，可扩展性强。

但是，发现作者的topView由于重写触摸方法，不能够放点击事件，本人在原作上修改，以适应项目需要，改后的topView可以放置按触发事件，在此记个笔记。

BackgroundView中添加滑动手势

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
