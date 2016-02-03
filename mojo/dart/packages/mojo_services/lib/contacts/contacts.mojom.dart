// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library contacts_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class Contact extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int id = 0;
  String name = null;

  Contact() : super(kVersions.last.size);

  static Contact deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Contact decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Contact result = new Contact();

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
      
      result.id = decoder0.decodeInt64(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.name = decoder0.decodeString(16, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt64(id, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "id of struct Contact: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(name, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "name of struct Contact: $e";
      rethrow;
    }
  }

  String toString() {
    return "Contact("
           "id: $id" ", "
           "name: $name" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["id"] = id;
    map["name"] = name;
    return map;
  }
}




class _ContactsServiceGetCountParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String filter = null;

  _ContactsServiceGetCountParams() : super(kVersions.last.size);

  static _ContactsServiceGetCountParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ContactsServiceGetCountParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ContactsServiceGetCountParams result = new _ContactsServiceGetCountParams();

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
      
      result.filter = decoder0.decodeString(8, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(filter, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "filter of struct _ContactsServiceGetCountParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ContactsServiceGetCountParams("
           "filter: $filter" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["filter"] = filter;
    return map;
  }
}




class ContactsServiceGetCountResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int count = 0;

  ContactsServiceGetCountResponseParams() : super(kVersions.last.size);

  static ContactsServiceGetCountResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ContactsServiceGetCountResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ContactsServiceGetCountResponseParams result = new ContactsServiceGetCountResponseParams();

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
      
      result.count = decoder0.decodeUint64(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint64(count, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "count of struct ContactsServiceGetCountResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ContactsServiceGetCountResponseParams("
           "count: $count" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["count"] = count;
    return map;
  }
}




class _ContactsServiceGetParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String filter = null;
  int offset = 0;
  int limit = 0;

  _ContactsServiceGetParams() : super(kVersions.last.size);

  static _ContactsServiceGetParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ContactsServiceGetParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ContactsServiceGetParams result = new _ContactsServiceGetParams();

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
      
      result.filter = decoder0.decodeString(8, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.offset = decoder0.decodeUint32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.limit = decoder0.decodeUint32(20);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(filter, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "filter of struct _ContactsServiceGetParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(offset, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "offset of struct _ContactsServiceGetParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(limit, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "limit of struct _ContactsServiceGetParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ContactsServiceGetParams("
           "filter: $filter" ", "
           "offset: $offset" ", "
           "limit: $limit" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["filter"] = filter;
    map["offset"] = offset;
    map["limit"] = limit;
    return map;
  }
}




class ContactsServiceGetResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<Contact> contacts = null;

  ContactsServiceGetResponseParams() : super(kVersions.last.size);

  static ContactsServiceGetResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ContactsServiceGetResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ContactsServiceGetResponseParams result = new ContactsServiceGetResponseParams();

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
      
      var decoder1 = decoder0.decodePointer(8, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.contacts = new List<Contact>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.contacts[i1] = Contact.decode(decoder2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      if (contacts == null) {
        encoder0.encodeNullPointer(8, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(contacts.length, 8, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < contacts.length; ++i0) {
          encoder1.encodeStruct(contacts[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "contacts of struct ContactsServiceGetResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ContactsServiceGetResponseParams("
           "contacts: $contacts" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["contacts"] = contacts;
    return map;
  }
}




class _ContactsServiceGetEmailsParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int id = 0;

  _ContactsServiceGetEmailsParams() : super(kVersions.last.size);

  static _ContactsServiceGetEmailsParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ContactsServiceGetEmailsParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ContactsServiceGetEmailsParams result = new _ContactsServiceGetEmailsParams();

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
      
      result.id = decoder0.decodeInt64(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt64(id, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "id of struct _ContactsServiceGetEmailsParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ContactsServiceGetEmailsParams("
           "id: $id" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["id"] = id;
    return map;
  }
}




class ContactsServiceGetEmailsResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<String> emails = null;

  ContactsServiceGetEmailsResponseParams() : super(kVersions.last.size);

  static ContactsServiceGetEmailsResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ContactsServiceGetEmailsResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ContactsServiceGetEmailsResponseParams result = new ContactsServiceGetEmailsResponseParams();

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
      
      var decoder1 = decoder0.decodePointer(8, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.emails = new List<String>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.emails[i1] = decoder1.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      if (emails == null) {
        encoder0.encodeNullPointer(8, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(emails.length, 8, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < emails.length; ++i0) {
          encoder1.encodeString(emails[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "emails of struct ContactsServiceGetEmailsResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ContactsServiceGetEmailsResponseParams("
           "emails: $emails" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["emails"] = emails;
    return map;
  }
}




class _ContactsServiceGetPhotoParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int id = 0;
  bool highResolution = false;

  _ContactsServiceGetPhotoParams() : super(kVersions.last.size);

  static _ContactsServiceGetPhotoParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ContactsServiceGetPhotoParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ContactsServiceGetPhotoParams result = new _ContactsServiceGetPhotoParams();

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
      
      result.id = decoder0.decodeInt64(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.highResolution = decoder0.decodeBool(16, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt64(id, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "id of struct _ContactsServiceGetPhotoParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(highResolution, 16, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "highResolution of struct _ContactsServiceGetPhotoParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ContactsServiceGetPhotoParams("
           "id: $id" ", "
           "highResolution: $highResolution" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["id"] = id;
    map["highResolution"] = highResolution;
    return map;
  }
}




class ContactsServiceGetPhotoResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String photoUrl = null;

  ContactsServiceGetPhotoResponseParams() : super(kVersions.last.size);

  static ContactsServiceGetPhotoResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ContactsServiceGetPhotoResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ContactsServiceGetPhotoResponseParams result = new ContactsServiceGetPhotoResponseParams();

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
      
      result.photoUrl = decoder0.decodeString(8, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(photoUrl, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "photoUrl of struct ContactsServiceGetPhotoResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ContactsServiceGetPhotoResponseParams("
           "photoUrl: $photoUrl" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["photoUrl"] = photoUrl;
    return map;
  }
}




const int _ContactsService_getCountName = 0;
const int _ContactsService_getName = 1;
const int _ContactsService_getEmailsName = 2;
const int _ContactsService_getPhotoName = 3;



class _ContactsServiceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class ContactsService {
  static const String serviceName = "contacts::ContactsService";
  dynamic getCount(String filter,[Function responseFactory = null]);
  dynamic get(String filter,int offset,int limit,[Function responseFactory = null]);
  dynamic getEmails(int id,[Function responseFactory = null]);
  dynamic getPhoto(int id,bool highResolution,[Function responseFactory = null]);
}


class _ContactsServiceProxyImpl extends bindings.Proxy {
  _ContactsServiceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ContactsServiceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ContactsServiceProxyImpl.unbound() : super.unbound();

  static _ContactsServiceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ContactsServiceProxyImpl"));
    return new _ContactsServiceProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _ContactsServiceServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _ContactsService_getCountName:
        var r = ContactsServiceGetCountResponseParams.deserialize(
            message.payload);
        if (!message.header.hasRequestId) {
          proxyError("Expected a message with a valid request Id.");
          return;
        }
        Completer c = completerMap[message.header.requestId];
        if (c == null) {
          proxyError(
              "Message had unknown request Id: ${message.header.requestId}");
          return;
        }
        completerMap.remove(message.header.requestId);
        if (c.isCompleted) {
          proxyError("Response completer already completed");
          return;
        }
        c.complete(r);
        break;
      case _ContactsService_getName:
        var r = ContactsServiceGetResponseParams.deserialize(
            message.payload);
        if (!message.header.hasRequestId) {
          proxyError("Expected a message with a valid request Id.");
          return;
        }
        Completer c = completerMap[message.header.requestId];
        if (c == null) {
          proxyError(
              "Message had unknown request Id: ${message.header.requestId}");
          return;
        }
        completerMap.remove(message.header.requestId);
        if (c.isCompleted) {
          proxyError("Response completer already completed");
          return;
        }
        c.complete(r);
        break;
      case _ContactsService_getEmailsName:
        var r = ContactsServiceGetEmailsResponseParams.deserialize(
            message.payload);
        if (!message.header.hasRequestId) {
          proxyError("Expected a message with a valid request Id.");
          return;
        }
        Completer c = completerMap[message.header.requestId];
        if (c == null) {
          proxyError(
              "Message had unknown request Id: ${message.header.requestId}");
          return;
        }
        completerMap.remove(message.header.requestId);
        if (c.isCompleted) {
          proxyError("Response completer already completed");
          return;
        }
        c.complete(r);
        break;
      case _ContactsService_getPhotoName:
        var r = ContactsServiceGetPhotoResponseParams.deserialize(
            message.payload);
        if (!message.header.hasRequestId) {
          proxyError("Expected a message with a valid request Id.");
          return;
        }
        Completer c = completerMap[message.header.requestId];
        if (c == null) {
          proxyError(
              "Message had unknown request Id: ${message.header.requestId}");
          return;
        }
        completerMap.remove(message.header.requestId);
        if (c.isCompleted) {
          proxyError("Response completer already completed");
          return;
        }
        c.complete(r);
        break;
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  String toString() {
    var superString = super.toString();
    return "_ContactsServiceProxyImpl($superString)";
  }
}


class _ContactsServiceProxyCalls implements ContactsService {
  _ContactsServiceProxyImpl _proxyImpl;

  _ContactsServiceProxyCalls(this._proxyImpl);
    dynamic getCount(String filter,[Function responseFactory = null]) {
      var params = new _ContactsServiceGetCountParams();
      params.filter = filter;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _ContactsService_getCountName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic get(String filter,int offset,int limit,[Function responseFactory = null]) {
      var params = new _ContactsServiceGetParams();
      params.filter = filter;
      params.offset = offset;
      params.limit = limit;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _ContactsService_getName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic getEmails(int id,[Function responseFactory = null]) {
      var params = new _ContactsServiceGetEmailsParams();
      params.id = id;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _ContactsService_getEmailsName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic getPhoto(int id,bool highResolution,[Function responseFactory = null]) {
      var params = new _ContactsServiceGetPhotoParams();
      params.id = id;
      params.highResolution = highResolution;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _ContactsService_getPhotoName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class ContactsServiceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  ContactsService ptr;

  ContactsServiceProxy(_ContactsServiceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ContactsServiceProxyCalls(proxyImpl);

  ContactsServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ContactsServiceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ContactsServiceProxyCalls(impl);
  }

  ContactsServiceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ContactsServiceProxyImpl.fromHandle(handle) {
    ptr = new _ContactsServiceProxyCalls(impl);
  }

  ContactsServiceProxy.unbound() :
      impl = new _ContactsServiceProxyImpl.unbound() {
    ptr = new _ContactsServiceProxyCalls(impl);
  }

  factory ContactsServiceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ContactsServiceProxy p = new ContactsServiceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ContactsServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ContactsServiceProxy"));
    return new ContactsServiceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => ContactsService.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "ContactsServiceProxy($impl)";
  }
}


class ContactsServiceStub extends bindings.Stub {
  ContactsService _impl = null;

  ContactsServiceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ContactsServiceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ContactsServiceStub.unbound() : super.unbound();

  static ContactsServiceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ContactsServiceStub"));
    return new ContactsServiceStub.fromEndpoint(endpoint);
  }


  ContactsServiceGetCountResponseParams _ContactsServiceGetCountResponseParamsFactory(int count) {
    var mojo_factory_result = new ContactsServiceGetCountResponseParams();
    mojo_factory_result.count = count;
    return mojo_factory_result;
  }
  ContactsServiceGetResponseParams _ContactsServiceGetResponseParamsFactory(List<Contact> contacts) {
    var mojo_factory_result = new ContactsServiceGetResponseParams();
    mojo_factory_result.contacts = contacts;
    return mojo_factory_result;
  }
  ContactsServiceGetEmailsResponseParams _ContactsServiceGetEmailsResponseParamsFactory(List<String> emails) {
    var mojo_factory_result = new ContactsServiceGetEmailsResponseParams();
    mojo_factory_result.emails = emails;
    return mojo_factory_result;
  }
  ContactsServiceGetPhotoResponseParams _ContactsServiceGetPhotoResponseParamsFactory(String photoUrl) {
    var mojo_factory_result = new ContactsServiceGetPhotoResponseParams();
    mojo_factory_result.photoUrl = photoUrl;
    return mojo_factory_result;
  }

  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _ContactsService_getCountName:
        var params = _ContactsServiceGetCountParams.deserialize(
            message.payload);
        var response = _impl.getCount(params.filter,_ContactsServiceGetCountResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _ContactsService_getCountName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _ContactsService_getCountName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _ContactsService_getName:
        var params = _ContactsServiceGetParams.deserialize(
            message.payload);
        var response = _impl.get(params.filter,params.offset,params.limit,_ContactsServiceGetResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _ContactsService_getName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _ContactsService_getName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _ContactsService_getEmailsName:
        var params = _ContactsServiceGetEmailsParams.deserialize(
            message.payload);
        var response = _impl.getEmails(params.id,_ContactsServiceGetEmailsResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _ContactsService_getEmailsName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _ContactsService_getEmailsName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _ContactsService_getPhotoName:
        var params = _ContactsServiceGetPhotoParams.deserialize(
            message.payload);
        var response = _impl.getPhoto(params.id,params.highResolution,_ContactsServiceGetPhotoResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _ContactsService_getPhotoName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _ContactsService_getPhotoName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  ContactsService get impl => _impl;
  set impl(ContactsService d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ContactsServiceStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _ContactsServiceServiceDescription();
}



