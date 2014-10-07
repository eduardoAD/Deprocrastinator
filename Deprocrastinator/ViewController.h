//
//  ViewController.h
//  Deprocrastinator
//
//  Created by Eduardo Alvarado Díaz on 10/6/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoItem.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@property (strong, nonatomic) IBOutlet UITextField *todoText;

@property (strong, nonatomic) IBOutlet UIButton *editButton;

@property NSMutableArray *todoArray;

@property ToDoItem *toDoItem;

@property BOOL editButtonToggled;

@end

