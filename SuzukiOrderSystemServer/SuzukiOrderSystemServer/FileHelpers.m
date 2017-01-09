//
//  FileHelpers.m
//  AirOrder
//
//  Created by Suzuki Hideharu on 2016/05/09.
//  Copyright © 2016年 Suzuki.Works. All rights reserved.
//

#import "FileHelpers.h"

//Documentsディレクトリの中のfilenameへのフルパスを返す
NSString *pathInDocumentDirectory(NSString *filename)
{
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                       NSUserDomainMask,
                                                                       YES) objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:filename];
}