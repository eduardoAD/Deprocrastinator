//
//  ToDoItem.h
//  Deprocrastinator
//
//  Created by Eduardo Alvarado Díaz on 10/6/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToDoItem : NSObject
@property NSString *itemText;
@property BOOL completed;
@property int priority;
@end
