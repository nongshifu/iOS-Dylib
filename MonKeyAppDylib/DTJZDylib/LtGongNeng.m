#import <WebKit/WebKit.h>
#import "LtShengMing.h"
#import <CaptainHook/CaptainHook.h>
#import <UIKit/UIKit.h>
#import <Cycript/Cycript.h>
#import "SCLAlertView.h"
#import "LtShengMing.h"
#import <dlfcn.h>
//默认 存放辅助更新的配置文件txt的 域名/目录
#define homeurl @"https://iosgods.cn/html/game/"
//默认辅助更新的配置文件
#define gamejson @"game.json"

static NSString *MUFENGKEY  =   @"MUFENG";

@implementation NSObject (hook)
//1下载动态库
- (BOOL)xzdylib;
{
    @autoreleasepool {
        //获取应用ID
        // 取得沙盒目录
        NSString *localPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        //获取info.plist
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *BundID = [infoDictionary objectForKey:@"CFBundleIdentifier"];
        NSLog(@"🆚BundID=\n%@\n",BundID);
        //通过应用ID查询游戏目录game.json获取到dylib地址
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",homeurl,gamejson];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
        NSError *error;
        NSDictionary *game = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSString *gameurl = [game objectForKey:BundID];
        //得到dylib地址
        NSLog(@"🆚游戏Dylib是:\n %@",gameurl);
        // https://iosgods.cn/html/game/MonKeyApp.dylib
        //从url中截取动态库名字
        NSString *dylibname = [gameurl substringFromIndex:29];
        // 要检查的文件目录
        NSLog(@"🆚动态库名字是:\n %@",dylibname);
        NSString *filePath = [localPath  stringByAppendingPathComponent:dylibname];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:filePath]) {
            NSLog(@"dylib存在");
            [NSObject xzjson];
        }
        else {
            
            
            NSLog(@"dylib不存在");
            //开始下载
            NSString *pinjieurl =[NSString stringWithFormat:@"%@%@",homeurl,dylibname];
            NSURL *url = [NSURL URLWithString:pinjieurl];
            
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            NSURLSession *session = [NSURLSession sharedSession];
            NSURLSessionDownloadTask *downloadTaskdylib = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error)
            {
                NSLog(@"dylib缓存成功= %@", location);
                    //转移文件
                NSString *cache = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)  lastObject];
                NSString *filePath = [cache stringByAppendingPathComponent:response.suggestedFilename];
                        
                NSLog(@"1111111🆚下载dylib完成 = %@",filePath);
                NSURL *toURL = [NSURL fileURLWithPath:filePath];
                [[NSFileManager defaultManager] moveItemAtURL:location toURL:toURL error:nil];
                if (error) {
                        return;
                    } else
                    {
                        
                        //提示下载成功
                        [NSObject xzjson];
                    }
                    
                }];
            [downloadTaskdylib resume];
        }
        
        return 0;
    }
    
}
//2下载json
- (BOOL)xzjson;
{
    @autoreleasepool {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *BundID = [infoDictionary objectForKey:@"CFBundleIdentifier"];
        NSLog(@"🆚BundID=\n%@\n",BundID);
        //通过应用ID查询游戏目录game.json获取到dylib地址
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",homeurl,gamejson];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
        NSError *error;
        NSDictionary *game = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSString *gameurl = [game objectForKey:BundID];
        //得到dylib地址 https://iosgods.cn/html/game/MonKeyApp.dylib
        //从url中截取动态库名字
        NSString *dylibname = [gameurl substringFromIndex:29];
        NSString*txt = [dylibname stringByReplacingOccurrencesOfString:@".dylib"withString:@".txt"];
        NSLog(@"得到txt名字🆚%@", txt);
        //每次启动下载 存在就跳过
        NSString *pinjieurl =[NSString stringWithFormat:@"%@%@",homeurl,txt];
        NSURL *url = [NSURL URLWithString:pinjieurl];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDownloadTask *downloadTasktxt = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error)
        {
            NSLog(@"txt缓存成功= %@", location);
                //转移文件
            NSString *cache = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)  lastObject];
            NSString *filePath = [cache stringByAppendingPathComponent:response.suggestedFilename];
                    
            NSLog(@"222222🆚下载txt完成 = %@",filePath);
            NSURL *toURL = [NSURL fileURLWithPath:filePath];
            [[NSFileManager defaultManager] moveItemAtURL:location toURL:toURL error:nil];
            if (error) {
                    return;
                } else
                {
                    //下载json完成
                    [NSObject jxjson];
                }
                
            }];
        [downloadTasktxt resume];
        return 0;
    }
    
}

//解析服务器json
- (BOOL)jxjson;//4
{
    @autoreleasepool {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *BundID = [infoDictionary objectForKey:@"CFBundleIdentifier"];
        NSLog(@"🆚BundID=\n%@\n",BundID);
        //通过应用ID查询游戏目录game.json获取到dylib地址
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",homeurl,gamejson];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
        NSError *error;
        NSDictionary *game = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSString *gameurl = [game objectForKey:BundID];
        //得到dylib地址 https://iosgods.cn/html/game/MonKeyApp.dylib
        //从url中截取动态库名字
        NSString *dylibname = [gameurl substringFromIndex:29];
        NSString*txt = [dylibname stringByReplacingOccurrencesOfString:@".dylib"withString:@".txt"];
        NSLog(@"得到txt名字🆚%@", txt);
        //解析服务器版本
        NSString *txturl = [NSString stringWithFormat:@"%@%@",homeurl,txt];
        NSData *data1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:txturl]];
        NSDictionary *json1 = [NSJSONSerialization JSONObjectWithData:data1 options:kNilOptions error:&error];
        NSArray *webbanben = [json1 objectForKey:@"banben"];
        NSLog(@"333333🆚服务器版本: %@",webbanben);
        
        
        //解析本地版本
        
        NSString *jsonPath = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),txt];
        NSData *data2 = [NSData dataWithContentsOfFile:jsonPath];
        NSDictionary *json2 = [NSJSONSerialization JSONObjectWithData:data2 options:kNilOptions error:&error];
        
        NSArray *bdbanben = [json2 objectForKey:@"banben"];
        NSLog(@"4444444🆚当前版本: %@",bdbanben);
        //对比版本
        [self versionCompareOldStr:(NSString *)bdbanben andNewStr: (NSString *)webbanben];
        return 0;
    }
    
}
//对比本都和web   //5
- (BOOL)versionCompareOldStr:(NSString *)bdbanben andNewStr: (NSString *)webbanben
{
    @autoreleasepool
    {
        if ([bdbanben compare:webbanben options:NSNumericSearch] == NSOrderedSame)
        {
            //版本相等如何有说明 就提示说明
            NSLog(@"555BBBB🆚等于服务器版本无需更新");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
                NSString *BundID = [infoDictionary objectForKey:@"CFBundleIdentifier"];
                NSLog(@"🆚BundID=\n%@\n",BundID);
                //通过应用ID查询游戏目录game.json获取到dylib地址
                NSString *urlStr = [NSString stringWithFormat:@"%@%@",homeurl,gamejson];
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
                NSError *error;
                NSDictionary *game = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                NSString *gameurl = [game objectForKey:BundID];
                //得到dylib地址 https://iosgods.cn/html/game/MonKeyApp.dylib
                //从url中截取动态库名字
                NSString *dylibname = [gameurl substringFromIndex:29];
                NSString*txt = [dylibname stringByReplacingOccurrencesOfString:@".dylib"withString:@".txt"];
                NSLog(@"得到txt名字🆚%@", txt);
                NSString *txturl = [NSString stringWithFormat:@"%@%@",homeurl,txt];
                NSData *txtdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:txturl]];
                NSDictionary *txtjson = [NSJSONSerialization JSONObjectWithData:txtdata options:kNilOptions error:&error];
                NSString *shuoming = [txtjson objectForKey:@"shuoming"];
                if (shuoming.length>5) {
                    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                    
                    [alert addButton:@"进入游戏" actionBlock:^{
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [NSObject jzdylib];
                        });
                       
                    }];
                    [alert addTimerToButtonIndex:0 reverse:YES];
                    [alert addButton:@"退出游戏" actionBlock:^{
                        exit(0);
                    }];
                    [alert showInfo:@"公告" subTitle:shuoming closeButtonTitle:@"确定" duration:10];
                } else {
                    [NSObject jzdylib];
                    return;
                }
                
                
            });
            
            return 0;
        }else
        {
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            NSString *BundID = [infoDictionary objectForKey:@"CFBundleIdentifier"];
            NSLog(@"🆚BundID=\n%@\n",BundID);
            //通过应用ID查询游戏目录game.json获取到dylib地址
            NSString *urlStr = [NSString stringWithFormat:@"%@%@",homeurl,gamejson];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
            NSError *error;
            NSDictionary *game = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSString *gameurl = [game objectForKey:BundID];
            //得到dylib地址 https://iosgods.cn/html/game/MonKeyApp.dylib
            //从url中截取动态库名字
            NSString *dylibname = [gameurl substringFromIndex:29];
            NSString*txt = [dylibname stringByReplacingOccurrencesOfString:@".dylib"withString:@".txt"];
            NSLog(@"得到txt名字🆚%@", txt);
            //解析服务器版本
            NSString *txturl = [NSString stringWithFormat:@"%@%@",homeurl,txt];
            NSData *data1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:txturl]];
            
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data1 options:kNilOptions error:&error];
            
            NSString *gonggao = [json objectForKey:@"gonggao"];
            NSString *deburl = [json objectForKey:@"deburl"];
            //更新提示并且删除
            //如果本地版本大于服务器版本
            NSLog(@"555AAAA🆚版本不匹配更新");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                
                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                [alert addTimerToButtonIndex:0 reverse:YES];
                [alert addButton:@"在线更新" actionBlock:^{
                    
                    [NSObject scwenjian];
                    
                    
                    
                }];
                [alert addButton:@"官网更新" actionBlock:^{
                    NSString *urlStr = [NSString stringWithFormat:@"%@", deburl];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
                    
                    
                }];
                [alert addButton:@"取消更新" actionBlock:^{
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [NSObject jzdylib];
                    });
                   
                }];
                [alert showSuccess:@"辅助更新" subTitle:gonggao closeButtonTitle:nil duration:10];
            });
            return 0;}
        
    }
    
}

//加载远程辅助
- (BOOL)jzdylib//6
{
    @autoreleasepool {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            NSString *BundID = [infoDictionary objectForKey:@"CFBundleIdentifier"];
            NSLog(@"🆚BundID=\n%@\n",BundID);
            //通过应用ID查询游戏目录game.json获取到dylib地址
            NSString *urlStr = [NSString stringWithFormat:@"%@%@",homeurl,gamejson];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
            NSError *error;
            NSDictionary *game = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSString *gameurl = [game objectForKey:BundID];
            //得到dylib地址
            NSLog(@"🆚游戏Dylib是:\n %@",gameurl);
            // https://iosgods.cn/html/game/MonKeyApp.dylib
            //从url中截取动态库名字
            NSString *dylibname = [gameurl substringFromIndex:29];
            // 要检查的文件目录
            NSLog(@"🆚动态库名字是:\n %@",dylibname);
            NSString *frameworkPath = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),dylibname];
            libHandle = NULL;
            libHandle = dlopen([frameworkPath cStringUsingEncoding:NSUTF8StringEncoding], RTLD_NOW);
            NSString *str = @"加载iOsGods.Cn失败!";
            
            if (libHandle == NULL) {
                char *error = dlerror();
                NSLog(@"3error: %s", error);
            } else {
                NSLog(@"66666🆚加载iOsGods.Cn成功打印");
                str = @"加载iOsGods.Cn成功";
                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                [alert addTimerToButtonIndex:0 reverse:YES];
                [alert showNotice:@"iOsGoDsCn" subTitle:@"辅助加载成功感谢使用" closeButtonTitle:nil duration:1];
               
            }
        });
        
        return 0;
    }
    
    
}
//删除辅助和json
- (BOOL)scwenjian;//7
{
    @autoreleasepool {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *BundID = [infoDictionary objectForKey:@"CFBundleIdentifier"];
        NSLog(@"🆚BundID=\n%@\n",BundID);
        //通过应用ID查询游戏目录game.json获取到dylib地址
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",homeurl,gamejson];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
        NSError *error;
        NSDictionary *game = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSString *gameurl = [game objectForKey:BundID];
        //得到dylib地址
        NSLog(@"🆚游戏Dylib是:\n %@",gameurl);
        // https://iosgods.cn/html/game/MonKeyApp.dylib
        //从url中截取动态库名字
        NSString *dylibname = [gameurl substringFromIndex:29];
        NSString*txtname = [dylibname stringByReplacingOccurrencesOfString:@".dylib"withString:@".txt"];
        NSLog(@"得到txt名字🆚%@", txtname);
        // 要检查的文件目录
        NSLog(@"🆚动态库名字是:\n %@",dylibname);
        NSString *txt = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),txtname];
        NSString *dylib = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),dylibname];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:dylib error:NULL];
        [fileManager removeItemAtPath:txt error:NULL];
        NSLog(@"77777🆚删除dylib和txt成功");
        if ([fileManager removeItemAtPath:txt error:NULL])
        {
            
        }else{
            NSLog(@"8888🆚重新下载");
    //        exit(0);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                @autoreleasepool {
                    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                    [alert addTimerToButtonIndex:0 reverse:YES];
                    [NSObject xzdylib];
                    [alert showWaiting:@"更新" subTitle:@"更新完毕自动加载辅助" closeButtonTitle:@"下载中请稍后" duration:2];
                }
                
                
            });
        }
        return 0;
    }
    
}

@end
