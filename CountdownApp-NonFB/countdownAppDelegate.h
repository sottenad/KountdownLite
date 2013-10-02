//
//  countdownAppDelegate.h
//  CountdownApp-NonFB
//
//  Created by Steve Ottenad on 10/1/13.
//  Copyright (c) 2013 Steve Ottenad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface countdownAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
