// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:_mojo_services/mojo/files/types.mojom.dart' as types;

//
// Implementation of Directory, File, and RandomAccessFile for Mojo.
//

OSError _OSErrorFromError(types.Error error) {
  assert(error != null);
  return new OSError(error.toString(), error.toJson());
}

String _ensurePathIsRelative(String path) {
  while (path.startsWith('/')) {
    // Trim off the leading '/'.
    path = path.substring(1);
  }
  return path;
}

patch class _Directory {
  // We start at the root of the file system.
  static String _currentDirectoryPath = '/';

  /* patch */ Future<Directory> create({bool recursive: false}) async {
    if (recursive) {
      return exists().then((exists) {
        if (exists) return this;
        if (path != parent.path) {
          return parent.create(recursive: true).then((_) {
            return create();
          });
        } else {
          return create();
        }
      });
    }
    DirectoryProxy rootDirectory = await _getRootDirectory();
    int flags =
        types.kOpenFlagRead | types.kOpenFlagWrite | types.kOpenFlagCreate;
    var response =
        await rootDirectory.responseOrError(
            rootDirectory.ptr.openDirectory(_ensurePathIsRelative(path),
                                            null,
                                            flags));
    if (response.error != types.Error.ok) {
      throw _OSErrorFromError(response.error);
    }
    return this;
  }

  /* patch */ Future<Directory> createTemp([String prefix]) async {
    DirectoryProxy rootDirectory = await _getRootDirectory();
    // Create directory and fail if it already exists.
    int flags = types.kOpenFlagRead | types.kOpenFlagWrite |
                types.kOpenFlagCreate | types.kOpenFlagExclusive;
    String tempPath = '$path/$prefix';
    while (true) {
      var response =
          await rootDirectory.responseOrError(
              rootDirectory.ptr.openDirectory(tempPath, null, flags));
      if (response.error == types.Error.ok) {
        // Success.
        break;
      }
      // Alter the path and try again.
      // TODO(johnmccutchan): Append a randomly generated character.
      tempPath = tempPath + 'a';
    }
    return new Directory(tempPath);
  }

  /* patch */ Future<bool> exists() async {
    DirectoryProxy rootDirectory = await _getRootDirectory();
    int flags = types.kOpenFlagRead | types.kOpenFlagWrite;
    var response =
        await await rootDirectory.responseOrError(
            rootDirectory.ptr.openDirectory(_ensurePathIsRelative(path),
                                            null,
                                            flags));
    // If we can open it, it exists.
    return response.error == types.Error.ok;
  }

  /* patch */ static _current() {
    return _currentDirectoryPath;
  }

  /* patch */ static _setCurrent(path) {
    _currentDirectoryPath = path;
  }

  /* patch */ static _createTemp(String path) {
    throw new UnimplementedError();
  }

  /* patch */ static String _systemTemp() {
    return 'tmp';
  }

  /* patch */ static _exists(String path) {
    throw new UnimplementedError();
  }

  /* patch */ static _create(String path) {
    throw new UnimplementedError();
  }

  /* patch */ static _deleteNative(String path, bool recursive) {
    throw new UnimplementedError();
  }

  /* patch */ static _rename(String path, String newPath) {
    throw new UnimplementedError();
  }

  /* patch */ static List _list(String path, bool recursive, bool followLinks) {
    throw new UnimplementedError();
  }
}


patch class _File {
  /* patch */ Future<bool> exists() async {
    DirectoryProxy rootDirectory = await _getRootDirectory();
    int flags = types.kOpenFlagRead;
    var response =
        await rootDirectory.responseOrError(
            rootDirectory.ptr.openFile(_ensurePathIsRelative(path),
                                       null,
                                       flags));
    // If we can open it, it exists.
    return response.error == types.Error.ok;
  }

  Future<File> create({bool recursive: false}) async {
    if (recursive) {
      // Create any parent directories.
      await parent.create(recursive: true);
    }
    DirectoryProxy rootDirectory = await _getRootDirectory();
    int flags = types.kOpenFlagWrite | types.kOpenFlagCreate;
    var response =
        await rootDirectory.responseOrError(
            rootDirectory.ptr.openFile(_ensurePathIsRelative(path),
                                       null,
                                       flags));
    if (response.error != types.Error.ok) {
      throw _OSErrorFromError(response.error);
    }
    return this;
  }

  /* patch */ static _exists(String path) {
    throw new UnimplementedError();
  }

  /* patch */ static _create(String path) {
    throw new UnimplementedError();
  }

  /* patch */ static _createLink(String path, String target) {
    throw new UnimplementedError();
  }

  /* patch */ static _linkTarget(String path) {
    throw new UnimplementedError();
  }

  /* patch */ static _deleteNative(String path) {
    throw new UnimplementedError();
  }

  /* patch */ static _deleteLinkNative(String path) {
    throw new UnimplementedError();
  }

  /* patch */ static _rename(String oldPath, String newPath) {
    throw new UnimplementedError();
  }

  /* patch */ static _renameLink(String oldPath, String newPath) {
    throw new UnimplementedError();
  }

  /* patch */ static _copy(String oldPath, String newPath) {
    throw new UnimplementedError();
  }

  /* patch */ static _lengthFromPath(String path) {
    throw new UnimplementedError();
  }

  /* patch */ static _lastModified(String path) {
    throw new UnimplementedError();
  }

  /* patch */ static _open(String path, int mode) {
    throw new UnimplementedError();
  }

  /* patch */ static int _openStdio(int fd) {
    throw new UnimplementedError();
  }
}

patch class FileStat {
  /* patch */ static _statSync(String path) {
  }
}


patch class FileSystemEntity {
  /* patch */ static _getType(String path, bool followLinks) {
    throw new UnimplementedError();
  }
  /* patch */ static _identical(String path1, String path2) {
    throw new UnimplementedError();
  }
  /* patch */ static _resolveSymbolicLinks(String path) {
    throw new UnimplementedError();
  }
}

patch class _Link {
}


patch class _RandomAccessFile {
  /* patch */ static int _close(int id) {
    throw new UnimplementedError();
  }

  /* patch */ static int _getFD(int id) {
    throw new UnimplementedError();
  }

  /* patch */ static _readByte(int id) {
    throw new UnimplementedError();
  }

  /* patch */ static _read(int id, int bytes) {
    throw new UnimplementedError();
  }

  /* patch */ static _readInto(int id, List<int> buffer, int start, int end) {
    throw new UnimplementedError();
  }

  /* patch */ static _writeByte(int id, int value) {
    throw new UnimplementedError();
  }

  /* patch */ static _writeFrom(int id, List<int> buffer, int start, int end) {
    throw new UnimplementedError();
  }

  /* patch */ static _position(int id) {
    throw new UnimplementedError();
  }

  /* patch */ static _setPosition(int id, int position) {
    throw new UnimplementedError();
  }

  /* patch */ static _truncate(int id, int length) {
    throw new UnimplementedError();
  }

  /* patch */ static _length(int id) {
    throw new UnimplementedError();
  }

  /* patch */ static _flush(int id) {
    throw new UnimplementedError();
  }

  /* patch */ static _lock(int id, int lock, int start, int end) {
    throw new UnimplementedError();
  }
}
