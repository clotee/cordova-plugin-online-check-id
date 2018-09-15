//
//  indentifyCardUtil.h
//  STIDCardDemoApp
//
//  Created by star diao on 2018/9/4.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <STIDCardReader/STIDCardReader.h>

@interface indentifyCardUtil : CDVPlugin {
    NSMutableDictionary* getIDCardMessageCallbacks;
    STIDCardReader *scaleManager;

}

@property (strong, nonatomic) NSMutableSet *peripherals;
@property (strong, nonatomic) CBCentralManager *manager;

- (void)getIDCardMessage:(CDVInvokedUrlCommand *)command;
- (void)startScareCard;

@end
