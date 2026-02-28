#include "mapfile.h"
#include "prelink.h"

#ifndef _WIN32
#include <sys/mman.h>
#include <fcntl.h>
#include <unistd.h>
#endif

#include <assert.h>

/* Map a file into virtual memory. */
mapfile_result_t
mapfile_create_mapping(const char* filename, char** buffer,
                       mapfile_handle* handle)
{
#ifdef _WIN32
  HANDLE file_handle;
  HANDLE map_handle;
  DWORD size_low;
  DWORD size_high;
  LPCTSTR filename_wide;
  int filename_length;
  char* filename_copy;
  char* tempname;
  char* ptr;
#else
  struct stat64 st;
#endif

  assert(filename);
  assert(buffer);
  assert(handle);

  /* Open the file. */
#ifdef _WIN32
  tempname = sysroot_file_name (filename, 0);
  if (!tempname)
    return MAPFILE_OPEN_FAILURE;

  /* Turn forward slashes in tempname into backslashes. */
  filename_copy = strdup (tempname);
  if (tempname != filename)
    free (tempname);
  ptr = filename_copy;
  while (ptr = strchr (ptr, '/'))
    *ptr = '\\';

  /* Open the file. */
  file_handle = CreateFileA(filename_copy, GENERIC_READ, FILE_SHARE_READ,
                            NULL, OPEN_EXISTING, 0, NULL);

  free (filename_copy);

  if (file_handle == INVALID_HANDLE_VALUE)
      return MAPFILE_OPEN_FAILURE;
#else
  handle->fd = wrap_open (filename, O_RDONLY);
  if (handle->fd < 0)
    {
      return MAPFILE_OPEN_FAILURE;
    }
#endif

  /* Now examine the file to check it isn't zero-length. */
#ifdef _WIN32
  size_low = GetFileSize(file_handle, &size_high);
  if (size_low == 0 && size_high == 0)
    {
      CloseHandle(file_handle);
      return MAPFILE_ZERO_LENGTH;
    }
#else
  if (fstat64 (handle->fd, &st) < 0 || st.st_size == 0)
    {
      close(handle->fd);
      return MAPFILE_ZERO_LENGTH;
    }
#endif

  /* Map the whole file into memory. */
#ifdef _WIN32
  map_handle = CreateFileMapping(file_handle, NULL, PAGE_READONLY,
                                 0, 0, NULL);
  if (map_handle == NULL)
    {
      CloseHandle(file_handle);
      return MAPFILE_MAP_FAILED;
    }

  handle->buffer = MapViewOfFile(map_handle, FILE_MAP_READ, 0, 0, 0);
  if (handle->buffer == NULL)
    {
      CloseHandle(map_handle);
      CloseHandle(file_handle);
      return MAPFILE_MAP_FAILED;
    }

  handle->file_handle = file_handle;
  handle->map_handle = map_handle;
#else
  handle->buffer = mmap(0, st.st_size, PROT_READ, MAP_SHARED, handle->fd, 0);
  handle->buffer_length = st.st_size;
#endif

  *buffer = (char*) handle->buffer;

  return MAPFILE_SUCCESS;
}

/* Close a file mapping created with mapfile_create_mapping(). */
void
mapfile_close_mapping(mapfile_handle* handle)
{
  assert(handle);

#ifdef _WIN32
  UnmapViewOfFile(handle->buffer);
  CloseHandle(handle->map_handle);
  CloseHandle(handle->file_handle);
#else
  munmap(handle->buffer, handle->buffer_length);
  fsync (handle->fd);
  close(handle->fd);
#endif
}

