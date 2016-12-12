//
//  utils.c
//  glcrypto
//
//  Created by Sergej Jaskiewicz on 17.11.2016.
//
//

#include <stdio.h>
#include "utils.h"

CU_BOOL compare_files(FILE *file1, FILE *file2) {
    
    int current_byte1, current_byte2;
    
    if (file1 == NULL && file2 == NULL) {
        return CU_TRUE;
    }
    
    if (file1 == NULL || file2 == NULL) {
        return CU_FALSE;
    }
    
    current_byte1 = getc(file1);
    current_byte2 = getc(file2);
    
    while ((current_byte1 != EOF) && (current_byte2 != EOF) && (current_byte1 == current_byte2)) {
        current_byte1 = getc(file1);
        current_byte2 = getc(file2);
    }
    
    if (current_byte1 == current_byte2) {
        return CU_TRUE;
    } else {
        return CU_FALSE;
    }
}

CU_BOOL compare_files_at_paths(const char *file_path1, const char *file_path2) {
    
    FILE *file1, *file2;
    
    file1 = fopen(file_path1, "r");
    file2 = fopen(file_path2, "r");
    
    if (file1 == NULL) {
        fprintf(stderr, "Could not open the file at path: %s", file_path1);
        return CU_FALSE;
    }
    
    if (file2 == NULL) {
        fprintf(stderr, "Could not open the file at path: %s", file_path2);
        return CU_FALSE;
    }
    
    return compare_files(file1, file2);
}
