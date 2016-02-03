// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library sample_import_mojom;

import 'dart:async';
import 'dart:collection';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;

class Shape extends bindings.MojoEnum {
  static const Shape rectangle = const Shape._(1);
  static const Shape circle = const Shape._(2);
  static const Shape triangle = const Shape._(3);
  static const Shape last = const Shape._(3);

  const Shape._(int v) : super(v);

  static const Map<String, Shape> valuesMap = const {
    "rectangle": rectangle,
    "circle": circle,
    "triangle": triangle,
    "last": last,
  };
  static const List<Shape> values = const [
    rectangle,
    circle,
    triangle,
    last,
  ];

  static Shape valueOf(String name) => valuesMap[name];

  factory Shape(int v) {
    switch (v) {
      case 1:
        return rectangle;
      case 2:
        return circle;
      case 3:
        return triangle;
      case 3:
        return last;
      default:
        return null;
    }
  }

  static Shape decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    Shape result = new Shape(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum Shape.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case rectangle:
        return 'Shape.rectangle';
      case circle:
        return 'Shape.circle';
      case triangle:
        return 'Shape.triangle';
      case last:
        return 'Shape.last';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

mojom_types.MojomEnum _sampleImportShape() {
  return new mojom_types.MojomEnum()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'Shape'
      ..fullIdentifier = 'imported.Shape')
    ..values = <mojom_types.EnumValue>[
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Rectangle')
        ..enumTypeKey = 'sample_import_Shape__'
        ..intValue = 1,
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Circle')
        ..enumTypeKey = 'sample_import_Shape__'
        ..intValue = 2,
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Triangle')
        ..enumTypeKey = 'sample_import_Shape__'
        ..intValue = 3,
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Last')
        ..enumTypeKey = 'sample_import_Shape__'
        ..intValue = 3,];
}

class AnotherShape extends bindings.MojoEnum {
  static const AnotherShape rectangle = const AnotherShape._(10);
  static const AnotherShape circle = const AnotherShape._(11);
  static const AnotherShape triangle = const AnotherShape._(12);

  const AnotherShape._(int v) : super(v);

  static const Map<String, AnotherShape> valuesMap = const {
    "rectangle": rectangle,
    "circle": circle,
    "triangle": triangle,
  };
  static const List<AnotherShape> values = const [
    rectangle,
    circle,
    triangle,
  ];

  static AnotherShape valueOf(String name) => valuesMap[name];

  factory AnotherShape(int v) {
    switch (v) {
      case 10:
        return rectangle;
      case 11:
        return circle;
      case 12:
        return triangle;
      default:
        return null;
    }
  }

  static AnotherShape decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    AnotherShape result = new AnotherShape(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum AnotherShape.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case rectangle:
        return 'AnotherShape.rectangle';
      case circle:
        return 'AnotherShape.circle';
      case triangle:
        return 'AnotherShape.triangle';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

mojom_types.MojomEnum _sampleImportAnotherShape() {
  return new mojom_types.MojomEnum()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'AnotherShape'
      ..fullIdentifier = 'imported.AnotherShape')
    ..values = <mojom_types.EnumValue>[
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Rectangle')
        ..enumTypeKey = 'sample_import_AnotherShape__'
        ..intValue = 10,
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Circle')
        ..enumTypeKey = 'sample_import_AnotherShape__'
        ..intValue = 11,
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Triangle')
        ..enumTypeKey = 'sample_import_AnotherShape__'
        ..intValue = 12,];
}

class YetAnotherShape extends bindings.MojoEnum {
  static const YetAnotherShape rectangle = const YetAnotherShape._(20);
  static const YetAnotherShape circle = const YetAnotherShape._(21);
  static const YetAnotherShape triangle = const YetAnotherShape._(22);

  const YetAnotherShape._(int v) : super(v);

  static const Map<String, YetAnotherShape> valuesMap = const {
    "rectangle": rectangle,
    "circle": circle,
    "triangle": triangle,
  };
  static const List<YetAnotherShape> values = const [
    rectangle,
    circle,
    triangle,
  ];

  static YetAnotherShape valueOf(String name) => valuesMap[name];

  factory YetAnotherShape(int v) {
    switch (v) {
      case 20:
        return rectangle;
      case 21:
        return circle;
      case 22:
        return triangle;
      default:
        return null;
    }
  }

  static YetAnotherShape decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    YetAnotherShape result = new YetAnotherShape(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum YetAnotherShape.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case rectangle:
        return 'YetAnotherShape.rectangle';
      case circle:
        return 'YetAnotherShape.circle';
      case triangle:
        return 'YetAnotherShape.triangle';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

mojom_types.MojomEnum _sampleImportYetAnotherShape() {
  return new mojom_types.MojomEnum()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'YetAnotherShape'
      ..fullIdentifier = 'imported.YetAnotherShape')
    ..values = <mojom_types.EnumValue>[
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Rectangle')
        ..enumTypeKey = 'sample_import_YetAnotherShape__'
        ..intValue = 20,
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Circle')
        ..enumTypeKey = 'sample_import_YetAnotherShape__'
        ..intValue = 21,
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Triangle')
        ..enumTypeKey = 'sample_import_YetAnotherShape__'
        ..intValue = 22,];
}



class Point extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int x = 0;
  int y = 0;

  Point() : super(kVersions.last.size);

  static Point deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Point decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Point result = new Point();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      result.x = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.y = decoder0.decodeInt32(12);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(x, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "x of struct Point: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(y, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "y of struct Point: $e";
      rethrow;
    }
  }

  String toString() {
    return "Point("
           "x: $x" ", "
           "y: $y" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["x"] = x;
    map["y"] = y;
    return map;
  }
}

mojom_types.MojomStruct _sampleImportPoint() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'Point'
      ..fullIdentifier = 'imported.Point')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'X')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int32),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Y')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int32),];
}


class _ImportedInterfaceDoSomethingParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _ImportedInterfaceDoSomethingParams() : super(kVersions.last.size);

  static _ImportedInterfaceDoSomethingParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ImportedInterfaceDoSomethingParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ImportedInterfaceDoSomethingParams result = new _ImportedInterfaceDoSomethingParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    encoder.getStructEncoderAtOffset(kVersions.last);
  }

  String toString() {
    return "_ImportedInterfaceDoSomethingParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

mojom_types.MojomStruct _sampleImportImportedInterfaceDoSomethingParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'ImportedInterfaceDoSomethingParams'
      ..fullIdentifier = 'imported.ImportedInterface_DoSomething_Params')
    ..fields = <mojom_types.StructField>[];
}


const int _ImportedInterface_doSomethingName = 0;

mojom_types.MojomInterface _sampleImportImportedInterface() {
  return new mojom_types.MojomInterface()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'ImportedInterface'
      ..fullIdentifier = 'imported.ImportedInterface')
    ..interfaceName = 'ImportedInterface'
    ..methods = <int, mojom_types.MojomMethod>{
      _ImportedInterface_doSomethingName: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'DoSomething')
        ..ordinal = _ImportedInterface_doSomethingName
        ..parameters = _sampleImportImportedInterfaceDoSomethingParams(),
    };
}

class _ImportedInterfaceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      _sampleImportImportedInterface();

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      getAllMojomTypeDefinitions()[typeKey];

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      getAllMojomTypeDefinitions();
}

abstract class ImportedInterface {
  static const String serviceName = null;
  void doSomething();
}


class _ImportedInterfaceProxyImpl extends bindings.Proxy {
  _ImportedInterfaceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ImportedInterfaceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ImportedInterfaceProxyImpl.unbound() : super.unbound();

  static _ImportedInterfaceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ImportedInterfaceProxyImpl"));
    return new _ImportedInterfaceProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _ImportedInterfaceServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  String toString() {
    var superString = super.toString();
    return "_ImportedInterfaceProxyImpl($superString)";
  }
}


class _ImportedInterfaceProxyCalls implements ImportedInterface {
  _ImportedInterfaceProxyImpl _proxyImpl;

  _ImportedInterfaceProxyCalls(this._proxyImpl);
    void doSomething() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ImportedInterfaceDoSomethingParams();
      _proxyImpl.sendMessage(params, _ImportedInterface_doSomethingName);
    }
}


class ImportedInterfaceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  ImportedInterface ptr;

  ImportedInterfaceProxy(_ImportedInterfaceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ImportedInterfaceProxyCalls(proxyImpl);

  ImportedInterfaceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ImportedInterfaceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ImportedInterfaceProxyCalls(impl);
  }

  ImportedInterfaceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ImportedInterfaceProxyImpl.fromHandle(handle) {
    ptr = new _ImportedInterfaceProxyCalls(impl);
  }

  ImportedInterfaceProxy.unbound() :
      impl = new _ImportedInterfaceProxyImpl.unbound() {
    ptr = new _ImportedInterfaceProxyCalls(impl);
  }

  factory ImportedInterfaceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ImportedInterfaceProxy p = new ImportedInterfaceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ImportedInterfaceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ImportedInterfaceProxy"));
    return new ImportedInterfaceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => ImportedInterface.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "ImportedInterfaceProxy($impl)";
  }
}


class ImportedInterfaceStub extends bindings.Stub {
  ImportedInterface _impl = null;

  ImportedInterfaceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ImportedInterfaceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ImportedInterfaceStub.unbound() : super.unbound();

  static ImportedInterfaceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ImportedInterfaceStub"));
    return new ImportedInterfaceStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _ImportedInterface_doSomethingName:
        var params = _ImportedInterfaceDoSomethingParams.deserialize(
            message.payload);
        _impl.doSomething();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  ImportedInterface get impl => _impl;
  set impl(ImportedInterface d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ImportedInterfaceStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _ImportedInterfaceServiceDescription();
}


Map<String, mojom_types.UserDefinedType> _initDescriptions() {
  var map = new HashMap<String, mojom_types.UserDefinedType>();
  map["sample_import_Shape__"] =
    new mojom_types.UserDefinedType()
      ..enumType = _sampleImportShape();
  map["sample_import_AnotherShape__"] =
    new mojom_types.UserDefinedType()
      ..enumType = _sampleImportAnotherShape();
  map["sample_import_YetAnotherShape__"] =
    new mojom_types.UserDefinedType()
      ..enumType = _sampleImportYetAnotherShape();
  map["sample_import_Point__"] =
    new mojom_types.UserDefinedType()
      ..structType = _sampleImportPoint();
  map["sample_import_ImportedInterface_DoSomething_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _sampleImportImportedInterfaceDoSomethingParams();
  map["sample_import_ImportedInterface__"] =
    new mojom_types.UserDefinedType()
      ..interfaceType = _sampleImportImportedInterface();
  return map;
}

var _mojomDesc;
Map<String, mojom_types.UserDefinedType> getAllMojomTypeDefinitions() {
  if (_mojomDesc == null) {
    _mojomDesc = _initDescriptions();
  }
  return _mojomDesc;
}

