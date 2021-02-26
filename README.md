# DTJZDylib  iOS动态加载dylib动态库 实现方便的动态更新
# 为iOS应用程序动态加载dylib
注意：
App动态加载动态库dylib不能通过App Store上架审核
# 使用场景
# 编译成dylib后注入APP签名安装
就可以吧带有功能的dylib放在服务器上 在线更新 省去重新打包签名分发安装
1.如hook某个App
2.如游戏辅助
3.比如有新功能 放到服务器 APP端启动在线更新即可

# 功能详解
# 1.加载调用沙盒目录中的dylib
- (BOOL)dylib
{   //提前吧OsGods.Cn.dylib放到沙盒目录 由于iOS限制 未越狱无法导入沙盒目录 最好放到服务器远程下载
    //从服务器上下载iOsGods.Cn.dylib保存到沙盒目录Documents、Library、tmp (方法自己写哦！)
    
    //获取并调用沙盒目录中下载好的的iOsGods.Cn.dylib动态库
    NSString *frameworkPath = [NSString stringWithFormat:@"%@/Documents/iOsGods.Cn.dylib",NSHomeDirectory()];
    libHandle = NULL;
    //获取并调用沙盒目录中的iOsGods.Cn.dylib动态库
    libHandle = dlopen([frameworkPath cStringUsingEncoding:NSUTF8StringEncoding], RTLD_NOW);
    NSString *str = @"加载iOsGods.Cn失败!";
    
    if (libHandle == NULL) {
        char *error = dlerror();
        NSLog(@"3error: %s", error);
    } else {
        NSLog(@"加载iOsGods.Cn成功打印");
        str = @"加载iOsGods.Cn成功";
        //判断调用成功 这里可写成功后执行的功能
       
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:str message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
    
}

# 2.执行被调用的dylib中的功能
#这是写在被调用iOsGods.Cn.dylib程序中的功能
#如:被调用的动态库.m 有个bsphp功能，被执行后打印 NSLog(@"调用bsphp成功");
#并且弹出提示框：这是luntan程序
#import "PiaoJin.h"
#import <UIKit/UIKit.h>

@implementation PiaoJin

- (void)luntan{
    NSLog(@"调用bsphp成功");
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"这是luntan程序" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}

@end
#这是写在被调用dylib程序中的功能

# 3 .调用上面iOsGods.Cn.dylib里面的功能
- (BOOL)dyluntan{
    Class piaoJinClass = NSClassFromString(@"PiaoJin");//这里的PiaoJin 是iOsGods.Cn.dylib程序中的声明
    if(piaoJinClass){
        //事先要知道有什么方法在这个iOsGods.Cn.dylib中
        id object = [[piaoJinClass alloc] init];
        //由于没有引入相关头文件故通过performSelector调用
        [object performSelector:@selector(luntan)];//这里的luntan是 是iOsGods.Cn.dylib程序中的方法
    }else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"调用方法失败!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];

    }
}

# 4 到此完成！编译本项目生成libMonKeyAppDylib.dylib注入到砸壳后的APP 签名安装
# 安装完毕启动 会加载沙盒目录中iOsGods.Cn.dylib实现具体功能
# 如果iOsGods.Cn.dylib是放在服务器上 写个更新下载方法
# 如更新 从下载上下载新的iOsGods.Cn.dylib 替换沙盒目录中的iOsGods.Cn.dylib

# 调用 完毕！

#
