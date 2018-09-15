//
//  indentifyCardUtil.m
//  STIDCardDemoApp
//
//  Created by star diao on 2018/9/4.
//

#import <Cordova/CDV.h>
#import "indentifyCardUtil.h"

//#define ERROR
#define UDValue(key) [[NSUserDefaults standardUserDefaults]objectForKey:key]
#define SETUDValue(value,key) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key]

#define SERVER @"SERVERIP"  //@"192.168.1.10"//@"222.134.70.138" //
#define PORT @"SERVERPORT" //10002//8088 //

@implementation indentifyCardUtil

@synthesize manager;
@synthesize peripherals;

- (void)pluginInitialize{
    [super pluginInitialize];
    
    peripherals = [NSMutableSet new];
    getIDCardMessageCallbacks = [NSMutableDictionary new];
    
    /**
     *  Description
     */
    if(UDValue(SERVER)== nil){
        SETUDValue(@"senter-online.cn", SERVER);
    }
    
    if(UDValue(PORT) == nil){
        SETUDValue(@"10002", PORT);
    }
    scaleManager = [STIDCardReader instance];
    [scaleManager setServerIp:UDValue(SERVER) andPort:[UDValue(PORT) intValue]];

}


#pragma mark - Cordova PLugin Methods
- (void)getIDCardMessage:(CDVInvokedUrlCommand *)command{
    [scaleManager startScaleCard];
}

-(void)startScareCard{
    BlueManager *bmanager = [BlueManager instance];
    bmanager.deleagte = (id)self;
    if(bmanager.linkedPeripheral == nil){
        [lb_error setText:@"请先选中要连接的蓝牙设备!"];
        [progressView stopAnimating];
    }else{
        if(bmanager.linkedPeripheral.peripheral.state != CBPeripheralStateConnected){
            NSLog(@"蓝牙处于未连接状态,先连接蓝牙!");
            [[BlueManager instance] connectPeripher:bmanager.linkedPeripheral];
        }else{
            NSLog(@"蓝牙处在连接状态,直接进行读卡的操作!");
            [[STIDCardReader instance] setDelegate:(id)self];
            [[STIDCardReader instance] startScaleCard];
        }
    }
}

@end
