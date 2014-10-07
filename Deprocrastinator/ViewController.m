//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Eduardo Alvarado Díaz on 10/6/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "ViewController.h"
#import "ToDoItem.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property NSMutableArray *priorityColors;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.todoArray = [[NSMutableArray alloc] init];
    self.editButtonToggled = NO;

    //add a left swipe gesture recognizer - Delete Action
    UISwipeGestureRecognizer *recognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [recognizerLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.myTableView addGestureRecognizer:recognizerLeft];

    //add a right swipe gesture recognizer - Change background color Action
    UISwipeGestureRecognizer *recognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [recognizerRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.myTableView addGestureRecognizer:recognizerRight];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.todoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];

    ToDoItem *item = [self.todoArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [item itemText];
    if (item.completed) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.backgroundColor = [self.priorityColors objectAtIndex:indexPath.row];

    return cell;
}

- (IBAction)onAddButtonPressed:(id)sender {
    if (![self.todoText.text  isEqual: @""]) {

        ToDoItem *item = [[ToDoItem alloc]init];
        item.itemText = [self.todoText text];
        item.completed = NO;
        item.priority = 0;

        [self.todoArray addObject:item];

        self.todoText.text = @"";
        [self priorityColorArray];
        [self.myTableView reloadData];
    }
}

- (IBAction)onEditButtonPressed:(id)sender {
    if (!self.editButtonToggled) {
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        self.editButtonToggled = YES;
    }else{
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        self.editButtonToggled = NO;

        NSMutableArray *toDelete = [[NSMutableArray alloc]init];
        for (ToDoItem *itemSelected in self.todoArray) {

            if (itemSelected.completed) {
                [toDelete addObject:itemSelected];
            }
        }
        [self.todoArray removeObjectsInArray:toDelete];
        [self priorityColorArray];
        [self.myTableView reloadData];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ToDoItem *itemSelected = [self.todoArray objectAtIndex:indexPath.row];
    itemSelected.completed = !itemSelected.completed;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


- (void) handleSwipe: (UISwipeGestureRecognizer *)gestureRecongizer {
    CGPoint location = [gestureRecongizer locationInView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:location];
    if (indexPath) {
        ToDoItem *itemSelected = [self.todoArray objectAtIndex:indexPath.row];
        if (gestureRecongizer.direction == UISwipeGestureRecognizerDirectionLeft) {
            //Delete Action
            [self.todoArray removeObject:itemSelected];
        }else if (gestureRecongizer.direction == UISwipeGestureRecognizerDirectionRight) {
            //Change background color Action
            //NSLog(@"right swipe, priority: %d",itemSelected.priority);
            if (itemSelected.priority == 0 ) {
                itemSelected.priority = 1;
            }else if (itemSelected.priority == 1 ) {
                itemSelected.priority = 2;
            }else if (itemSelected.priority == 2 ) {
                itemSelected.priority = 0;
            }else{
                itemSelected.priority = 0;
            }
        }
        [self.myTableView reloadData];
    }
}

- (void) priorityColorArray{
    [self.priorityColors removeAllObjects];
    UIColor *color;

    for (ToDoItem *item in self.todoArray) {
        if (item.priority == 0 ) {
            color = [UIColor greenColor];
        }else if (item.priority == 1 ) {
            color = [UIColor yellowColor];
        }else if (item.priority == 2 ) {
            color = [UIColor redColor];
        }else{
            color = [UIColor greenColor];
        }
        [self.priorityColors addObject:color];
    }
}


@end
