//
//  ViewController.m
//  RarArchive
//
//  Created by Abel on 16/9/6.
//  Copyright © 2016年 杨南. All rights reserved.
//

#import "ViewController.h"
#import "YNUnrar4iOS.h"

@interface ViewController ()
{
    NSString *unZipPath;
    NSArray *files;
}

@property (retain,nonatomic)NSString *filePath;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self openRAR];
}
- (void)openRAR
{
    
    NSMutableArray *arrayData = [NSMutableArray array];
    //创建文件的路径
    NSString  *filePath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"rar"];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    unZipPath=documentPath;
    //创建解压路径
   
    //    NSLog(@"name is %@",name);
   
    
    //    NSLog(@"unzipPath2222 is %@",unZipPath);
    //
    //     NSLog(@"_filePath is %@",_filePath);
    
    YNUnrar4iOS *rar=[[YNUnrar4iOS alloc]init];
    BOOL sec=[rar unrarOpenFile:filePath];
    //    NSLog(@"%d",sec);
    if(sec)
    {
        BOOL secLoad=[rar unrarFileTo:unZipPath overWrite:YES];
        //        NSLog(@"%d",secLoad);
        if(secLoad)
        {
            NSFileManager *fm=[NSFileManager defaultManager];
            files= [fm subpathsAtPath:unZipPath];
            NSLog(@"unzipPath2222 is %@",unZipPath);
            for(int i=0;i<files.count;i++)
            {
                NSString *path =  [NSString stringWithFormat:@"%@/%@",unZipPath,files[i]];
                NSData *data = [NSData dataWithContentsOfFile:path];
                if(data != nil&&!([files[i] hasPrefix:@"."]))
                {
                    [arrayData addObject:files[i]];
                }
            }
            
        }
        
    }
    [rar unrarCloseFile];
    NSLog(@"array = %@",arrayData);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
