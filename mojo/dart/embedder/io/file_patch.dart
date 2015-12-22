// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:_mojo_services/mojo/files/types.mojom.dart' as types;

//
// Implementation of Directory, File, and RandomAccessFile for Mojo.
//

// Helper to convert from mojo:files error to OSError.
OSError _OSErrorFromError(types.Error error) {
  assert(error != null);
  return new OSError(error.toString(), error.toJson());
}

// All paths in mojo:files are relative to the root directory. This helper
// strips away any leading slashes.
String _ensurePathIsRelative(String path) {
  while (path.startsWith('/')) {
    // Trim off the leading '/'.
    path = path.substring(1);
  }
  return path;
}

// The mojo implementation of dart:io does not support any synchronous
// file operations. This helper throws an unsupported error.
dynamic _onSyncOperation() {
  throw new UnsupportedError(
      "Synchronous operations are not supported by this embedder");
}

// Convert from mojo:files Timespec to DateTime.
DateTime _dateTimeFromTimespec(types.Timespec ts) {
  if (ts == null) {
    // Dawn of time.
    return new DateTime.fromMillisecondsSinceEpoch(0);
  }
  int microseconds = ts.seconds * Duration.MICROSECONDS_PER_SECOND;
  microseconds += ts.nanoseconds ~/ 1000;
  return new DateTime.fromMicrosecondsSinceEpoch(microseconds);
}

// Convert from mojo:files FileType to FileSystemEntityType.
FileSystemEntityType _fileSystemEntityTypeFromFileType(types.FileType ft) {
  if (ft == types.FileType.unknown) {
    return FileSystemEntityType.NOT_FOUND;
  } else if (ft == types.FileType.regularFile) {
    return FileSystemEntityType.FILE;
  } else if (ft == types.FileType.directory) {
    return FileSystemEntityType.DIRECTORY;
  }
  throw new UnimplementedError();
  return FileSystemEntityType.NOT_FOUND;
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

  /* patch */ void createSync({bool recursive: false}) => _onSyncOperation();

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

  /* patch */ Directory createTempSync([String prefix]) => _onSyncOperation();

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

  /* patch */ bool existsSync() => _onSyncOperation();

  /* patch */ Stream<FileSystemEntity> list({bool recursive: false,
                                            bool followLinks: true}) {
    _DirectoryLister directoryLister = new _DirectoryLister(path, recursive);
    StreamController streamController = new StreamController();
    directoryLister.list(streamController);
    return streamController.stream;
  }

  /* patch */ List listSync({bool recursive: false,
                             bool followLinks: true}) {
    return _onSyncOperation();
  }

  /* patch */ Future<FileStat> stat() {
    return FileStat.stat(path);
  }

  /* patch */ FileStat statSync() => _onSyncOperation();

  /* patch */ Future<Directory> rename(String newPath) async {
    DirectoryProxy rootDirectory = await _getRootDirectory();
    var response = await rootDirectory.responseOrError(
        rootDirectory.ptr.rename(_ensurePathIsRelative(path),
                                 _ensurePathIsRelative(newPath)));
    if (response.error != types.Error.ok) {
      throw _OSErrorFromError(response.error);
    }
    return new Directory(newPath);
  }

  /* patch */ Directory renameSync(String newPath) => _onSyncOperation();

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


class _DirectoryLister {
  final String _path;
  final bool _recursive;
  final List<String> _directoriesToList = new List<String>();

  _DirectoryLister(this._path, this._recursive);

  list(StreamController streamController) async {
    _directoriesToList.add(_path);

    DirectoryProxy rootDirectory = await _getRootDirectory();
    int flags = types.kOpenFlagRead | types.kOpenFlagWrite;

    while (_directoriesToList.length > 0) {
      // Remove head.
      String path = _directoriesToList.removeAt(0);
      // Open directory.
      DirectoryProxy directory = new DirectoryProxy.unbound();
      var response =
          await rootDirectory.responseOrError(
              rootDirectory.ptr.openDirectory(_ensurePathIsRelative(path),
                                              directory,
                                              flags));
      if (response.error != types.Error.ok) {
        // Skip if we can't open it.
        continue;
      }
      // Read contents.
      var readResponse = await directory.responseOrError(directory.ptr.read());
      // We are done with the directory now.
      directory.close(immediate: true);
      if (readResponse.error != types.Error.ok) {
        // Skip if we can't read it.
        continue;
      }
      List<types.DirectoryEntry> directoryContents =
          readResponse.directoryContents;
      for (types.DirectoryEntry entry in directoryContents) {
        String childPath = '$path/${entry.name}';
        if (entry.type == types.FileType.directory) {
          if (_recursive) {
            if ((entry.name != '.') && (entry.name != '..')) {
              _directoriesToList.add(childPath);
            }
          }
          streamController.add(new Directory(childPath));
        } else {
          streamController.add(new File(childPath));
        }
      }
    }
    streamController.close();
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

  /* patch */ bool existsSync() => _onSyncOperation();

  /* patch */ FileStat statSync() => _onSyncOperation();

  /* patch */ Future<File> create({bool recursive: false}) async {
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

  /* patch */ void createSync({bool recursive: false}) => _onSyncOperation();

  /* patch */ Future<File> rename(String newPath) async {
    DirectoryProxy rootDirectory = await _getRootDirectory();
    var response = await rootDirectory.responseOrError(
        rootDirectory.ptr.rename(_ensurePathIsRelative(path),
                                 _ensurePathIsRelative(newPath)));
    if (response.error != types.Error.ok) {
      throw _OSErrorFromError(response.error);
    }
    return new File(newPath);
  }

  /* patch */ File renameSync(String newPath) => _onSyncOperation();

  /* patch */ Future<File> copy(String newPath) {
    // TODO(johnmccutchan)
    throw new UnimplementedError();
  }

  /* patch */ File copySync(String newPath) => _onSyncOperation();

  /* patch */ Future<RandomAccessFile> open({FileMode mode: FileMode.READ}) {
    // TODO(johnmccutchan)
    throw new UnimplementedError();
  }

  /* patch */ Future<int> length() {
    // TODO(johnmccutchan)
    throw new UnimplementedError();
  }

  /* patch */ int lengthSync() => _onSyncOperation();

  /* patch */ Future<DateTime> lastModified() {
    // TODO(johnmccutchan)
    throw new UnimplementedError();
  }

  /* patch */ DateTime lastModifiedSync() => _onSyncOperation();

  /* patch */ RandomAccessFile openSync({FileMode mode: FileMode.READ}) {
    return _onSyncOperation();
  }

  /* patch */ Stream<List<int>> openRead([int start, int end]) {
    // TODO(johnmccutchan)
    throw new UnimplementedError();
  }

  /* patch */ IOSink openWrite({FileMode mode: FileMode.WRITE,
                                Encoding encoding: UTF8}) {
    // TODO(johnmccutchan)
    throw new UnimplementedError();
  }

  /* patch */ Future<List<int>> readAsBytes() {
    // TODO(johnmccutchan)
    throw new UnimplementedError();
  }

  /* patch */ List<int> readAsBytesSync() => _onSyncOperation();

  /* patch */ Future<String> readAsString({Encoding encoding: UTF8}) {
    // TODO(johnmccutchan)
    throw new UnimplementedError();
  }

  /* patch */ String readAsStringSync({Encoding encoding: UTF8}) {
    return _onSyncOperation();
  }

  /* patch */ List<String> readAsLinesSync({Encoding encoding: UTF8}) {
    return _onSyncOperation();
  }

  /* patch */ Future<File> writeAsBytes(List<int> bytes,
                                        {FileMode mode: FileMode.WRITE,
                                         bool flush: false}) {
    // TODO(johnmccutchan)
    throw new UnimplementedError();
  }

  /* patch */ void writeAsBytesSync(List<int> bytes,
                                    {FileMode mode: FileMode.WRITE,
                                     bool flush: false}) {
    _onSyncOperation();
  }

  /* patch */ void writeAsStringSync(String contents,
                                     {FileMode mode: FileMode.WRITE,
                                      Encoding encoding: UTF8,
                                      bool flush: false}) {
    _onSyncOperation();
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
  /* patch */ static FileStat statSync(String path) {
    return _onSyncOperation();
  }

  /* patch */ static Future<FileStat> stat(String path) async {
    DirectoryProxy rootDirectory = await _getRootDirectory();
    int flags = types.kOpenFlagRead | types.kOpenFlagWrite;
    DirectoryProxy directory = new DirectoryProxy.unbound();
    var response =
        await await rootDirectory.responseOrError(
            rootDirectory.ptr.openDirectory(_ensurePathIsRelative(path),
                                            directory,
                                            flags));
    if (response.error != types.Error.ok) {
      throw _OSErrorFromError(response.error);
    }
    var statResponse = await directory.responseOrError(directory.ptr.stat());
    // We are done with the directory now.
    directory.close(immediate: true);
    if (statResponse.error != types.Error.ok) {
      throw _OSErrorFromError(response.error);
    }
    types.FileInformation fileInformation = statResponse.fileInformation;
    DateTime modified = _dateTimeFromTimespec(fileInformation.mtime);
    DateTime accessed = _dateTimeFromTimespec(fileInformation.atime);
    int size = fileInformation.size;
    const userReadWriteExecutableUnixMode = 0x1c0;
    FileSystemEntityType fset =
        _fileSystemEntityTypeFromFileType(fileInformation.type);
    return new FileStat._internal(modified,
                                  modified,
                                  accessed,
                                  fset,
                                  userReadWriteExecutableUnixMode,
                                  size);
  }

  /* patch */ static _statSync(String path) {
    _onSyncOperation();
  }
}


patch class FileSystemEntity {
  /* patch */ Future<String> resolveSymbolicLinks() {
    // TODO(johnmccutchan): Canonicalize path before returning.
    return path;
  }

  /* patch */ String resolveSymbolicLinksSync() {
    return _onSyncOperation();
  }

  /* patch */ Future<FileSystemEntity> delete({bool recursive: false}) async {
    DirectoryProxy rootDirectory = await _getRootDirectory();
    int flags = recursive ? types.kDeleteFlagRecursive : 0;
    var response = await rootDirectory.responseOrError(
        rootDirectory.ptr.delete(_ensurePathIsRelative(path), flags));
    if (response.error != types.Error.ok) {
      throw _OSErrorFromError(response.error);
    }
    return this;
  }

  /* patch */ void deleteSync({bool recursive: false}) {
    _onSyncOperation();
  }

  /* patch */ Stream<FileSystemEvent> watch({int events: FileSystemEvent.ALL,
                                             bool recursive: false}) {
    throw new UnsupportedError(
        "File system watch is not supported by this embedder");
  }

  /* patch */ static Future<bool> identical(String path1, String path2) {
    // TODO(johnmccutchan): Canonicalize paths before comparing.
    return path1 == path2;
  }

  /* patch */ static bool identicalSync(String path1, String path2) {
    return _onSyncOperation();
  }

  /* patch */ static Future<FileSystemEntityType> type(
      String path, {bool followLinks: true}) async {
    FileStat fs = await FileStat.stat(path);
    return fs.type;
  }

  /* patch */ static FileSystemEntityType typeSync(
      String path, {bool followLinks: true}) {
      return _onSyncOperation();
  }

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
