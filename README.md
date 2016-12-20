# MacLive
develop a livestreaming mac app

1） NSTableView 的使用，和iOS上有一定区别，iOS是就写好了继承scrollView，但是这里是没有继承scrollview的内容；所以，NSTableView是需要对应的wraperview来进行包裹。

2） 注意返回高度，以及：
  - (nullable id)tableView:(NSTableView *)tableView objectValueForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row
  {
      return nil;
  }
  这个方法一定要实现，即使返回nil，具体和iOS的区别还需要要理解清楚。
