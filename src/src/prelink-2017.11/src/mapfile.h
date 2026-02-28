#ifndef _MAPFILE_H
#define _MAPFILE_H

#ifdef _WIN32
#include <windows.h>
#endif

#include <stdlib.h>
#include <string.h>

/* Result status from mapfile_create_mapping() below. */
typedef enum
{
    MAPFILE_SUCCESS,
    MAPFILE_OPEN_FAILURE,   /* file could not be opened */
    MAPFILE_ZERO_LENGTH,    /* file is zero-length */
    MAPFILE_MAP_FAILED      /* file could be opened but not mapped */
} mapfile_result_t;

/* Information enabling a file mapping to be closed. */
#ifdef _WIN32
typedef struct {
    PVOID buffer;
    HANDLE map_handle;
    HANDLE file_handle;
} mapfile_handle;
#else
typedef struct
{
    char* buffer;
    size_t buffer_length;
    int fd;
} mapfile_handle;
#endif

/* Map a file into virtual memory. */
mapfile_result_t mapfile_create_mapping(const char* filename,
                                        char** buffer,
                                        mapfile_handle* handle);

/* Close a file mapping created with mapfile_create_mapping(). */
void mapfile_close_mapping(mapfile_handle* handle);

#endif

