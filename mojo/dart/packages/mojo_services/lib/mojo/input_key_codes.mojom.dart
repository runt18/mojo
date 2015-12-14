// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library input_key_codes_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;

class KeyboardCode extends bindings.MojoEnum {
  static const KeyboardCode back = const KeyboardCode._(8);
  static const KeyboardCode tab = const KeyboardCode._(9);
  static const KeyboardCode clear = const KeyboardCode._(12);
  static const KeyboardCode return_ = const KeyboardCode._(13);
  static const KeyboardCode shift = const KeyboardCode._(16);
  static const KeyboardCode control = const KeyboardCode._(17);
  static const KeyboardCode menu = const KeyboardCode._(18);
  static const KeyboardCode pause = const KeyboardCode._(19);
  static const KeyboardCode capital = const KeyboardCode._(20);
  static const KeyboardCode kana = const KeyboardCode._(21);
  static const KeyboardCode hangul = const KeyboardCode._(21);
  static const KeyboardCode junja = const KeyboardCode._(23);
  static const KeyboardCode final_ = const KeyboardCode._(24);
  static const KeyboardCode hanja = const KeyboardCode._(25);
  static const KeyboardCode kanji = const KeyboardCode._(25);
  static const KeyboardCode escape = const KeyboardCode._(27);
  static const KeyboardCode convert = const KeyboardCode._(28);
  static const KeyboardCode nonconvert = const KeyboardCode._(29);
  static const KeyboardCode accept = const KeyboardCode._(30);
  static const KeyboardCode modechange = const KeyboardCode._(31);
  static const KeyboardCode space = const KeyboardCode._(32);
  static const KeyboardCode prior = const KeyboardCode._(33);
  static const KeyboardCode next = const KeyboardCode._(34);
  static const KeyboardCode end = const KeyboardCode._(35);
  static const KeyboardCode home = const KeyboardCode._(36);
  static const KeyboardCode left = const KeyboardCode._(37);
  static const KeyboardCode up = const KeyboardCode._(38);
  static const KeyboardCode right = const KeyboardCode._(39);
  static const KeyboardCode down = const KeyboardCode._(40);
  static const KeyboardCode select = const KeyboardCode._(41);
  static const KeyboardCode print = const KeyboardCode._(42);
  static const KeyboardCode execute = const KeyboardCode._(43);
  static const KeyboardCode snapshot = const KeyboardCode._(44);
  static const KeyboardCode insert = const KeyboardCode._(45);
  static const KeyboardCode delete = const KeyboardCode._(46);
  static const KeyboardCode help = const KeyboardCode._(47);
  static const KeyboardCode num0 = const KeyboardCode._(48);
  static const KeyboardCode num1 = const KeyboardCode._(49);
  static const KeyboardCode num2 = const KeyboardCode._(50);
  static const KeyboardCode num3 = const KeyboardCode._(51);
  static const KeyboardCode num4 = const KeyboardCode._(52);
  static const KeyboardCode num5 = const KeyboardCode._(53);
  static const KeyboardCode num6 = const KeyboardCode._(54);
  static const KeyboardCode num7 = const KeyboardCode._(55);
  static const KeyboardCode num8 = const KeyboardCode._(56);
  static const KeyboardCode num9 = const KeyboardCode._(57);
  static const KeyboardCode a = const KeyboardCode._(65);
  static const KeyboardCode b = const KeyboardCode._(66);
  static const KeyboardCode c = const KeyboardCode._(67);
  static const KeyboardCode d = const KeyboardCode._(68);
  static const KeyboardCode e = const KeyboardCode._(69);
  static const KeyboardCode f = const KeyboardCode._(70);
  static const KeyboardCode g = const KeyboardCode._(71);
  static const KeyboardCode h = const KeyboardCode._(72);
  static const KeyboardCode i = const KeyboardCode._(73);
  static const KeyboardCode j = const KeyboardCode._(74);
  static const KeyboardCode k = const KeyboardCode._(75);
  static const KeyboardCode l = const KeyboardCode._(76);
  static const KeyboardCode m = const KeyboardCode._(77);
  static const KeyboardCode n = const KeyboardCode._(78);
  static const KeyboardCode o = const KeyboardCode._(79);
  static const KeyboardCode p = const KeyboardCode._(80);
  static const KeyboardCode q = const KeyboardCode._(81);
  static const KeyboardCode r = const KeyboardCode._(82);
  static const KeyboardCode s = const KeyboardCode._(83);
  static const KeyboardCode t = const KeyboardCode._(84);
  static const KeyboardCode u = const KeyboardCode._(85);
  static const KeyboardCode v = const KeyboardCode._(86);
  static const KeyboardCode w = const KeyboardCode._(87);
  static const KeyboardCode x = const KeyboardCode._(88);
  static const KeyboardCode y = const KeyboardCode._(89);
  static const KeyboardCode z = const KeyboardCode._(90);
  static const KeyboardCode lwin = const KeyboardCode._(91);
  static const KeyboardCode command = const KeyboardCode._(91);
  static const KeyboardCode rwin = const KeyboardCode._(92);
  static const KeyboardCode apps = const KeyboardCode._(93);
  static const KeyboardCode sleep = const KeyboardCode._(95);
  static const KeyboardCode numpaD0 = const KeyboardCode._(96);
  static const KeyboardCode numpaD1 = const KeyboardCode._(97);
  static const KeyboardCode numpaD2 = const KeyboardCode._(98);
  static const KeyboardCode numpaD3 = const KeyboardCode._(99);
  static const KeyboardCode numpaD4 = const KeyboardCode._(100);
  static const KeyboardCode numpaD5 = const KeyboardCode._(101);
  static const KeyboardCode numpaD6 = const KeyboardCode._(102);
  static const KeyboardCode numpaD7 = const KeyboardCode._(103);
  static const KeyboardCode numpaD8 = const KeyboardCode._(104);
  static const KeyboardCode numpaD9 = const KeyboardCode._(105);
  static const KeyboardCode multiply = const KeyboardCode._(106);
  static const KeyboardCode add = const KeyboardCode._(107);
  static const KeyboardCode separator = const KeyboardCode._(108);
  static const KeyboardCode subtract = const KeyboardCode._(109);
  static const KeyboardCode decimal = const KeyboardCode._(110);
  static const KeyboardCode divide = const KeyboardCode._(111);
  static const KeyboardCode f1 = const KeyboardCode._(112);
  static const KeyboardCode f2 = const KeyboardCode._(113);
  static const KeyboardCode f3 = const KeyboardCode._(114);
  static const KeyboardCode f4 = const KeyboardCode._(115);
  static const KeyboardCode f5 = const KeyboardCode._(116);
  static const KeyboardCode f6 = const KeyboardCode._(117);
  static const KeyboardCode f7 = const KeyboardCode._(118);
  static const KeyboardCode f8 = const KeyboardCode._(119);
  static const KeyboardCode f9 = const KeyboardCode._(120);
  static const KeyboardCode f10 = const KeyboardCode._(121);
  static const KeyboardCode f11 = const KeyboardCode._(122);
  static const KeyboardCode f12 = const KeyboardCode._(123);
  static const KeyboardCode f13 = const KeyboardCode._(124);
  static const KeyboardCode f14 = const KeyboardCode._(125);
  static const KeyboardCode f15 = const KeyboardCode._(126);
  static const KeyboardCode f16 = const KeyboardCode._(127);
  static const KeyboardCode f17 = const KeyboardCode._(128);
  static const KeyboardCode f18 = const KeyboardCode._(129);
  static const KeyboardCode f19 = const KeyboardCode._(130);
  static const KeyboardCode f20 = const KeyboardCode._(131);
  static const KeyboardCode f21 = const KeyboardCode._(132);
  static const KeyboardCode f22 = const KeyboardCode._(133);
  static const KeyboardCode f23 = const KeyboardCode._(134);
  static const KeyboardCode f24 = const KeyboardCode._(135);
  static const KeyboardCode numlock = const KeyboardCode._(144);
  static const KeyboardCode scroll = const KeyboardCode._(145);
  static const KeyboardCode lshift = const KeyboardCode._(160);
  static const KeyboardCode rshift = const KeyboardCode._(161);
  static const KeyboardCode lcontrol = const KeyboardCode._(162);
  static const KeyboardCode rcontrol = const KeyboardCode._(163);
  static const KeyboardCode lmenu = const KeyboardCode._(164);
  static const KeyboardCode rmenu = const KeyboardCode._(165);
  static const KeyboardCode browserBack = const KeyboardCode._(166);
  static const KeyboardCode browserForward = const KeyboardCode._(167);
  static const KeyboardCode browserRefresh = const KeyboardCode._(168);
  static const KeyboardCode browserStop = const KeyboardCode._(169);
  static const KeyboardCode browserSearch = const KeyboardCode._(170);
  static const KeyboardCode browserFavorites = const KeyboardCode._(171);
  static const KeyboardCode browserHome = const KeyboardCode._(172);
  static const KeyboardCode volumeMute = const KeyboardCode._(173);
  static const KeyboardCode volumeDown = const KeyboardCode._(174);
  static const KeyboardCode volumeUp = const KeyboardCode._(175);
  static const KeyboardCode mediaNextTrack = const KeyboardCode._(176);
  static const KeyboardCode mediaPrevTrack = const KeyboardCode._(177);
  static const KeyboardCode mediaStop = const KeyboardCode._(178);
  static const KeyboardCode mediaPlayPause = const KeyboardCode._(179);
  static const KeyboardCode mediaLaunchMail = const KeyboardCode._(180);
  static const KeyboardCode mediaLaunchMediaSelect = const KeyboardCode._(181);
  static const KeyboardCode mediaLaunchApP1 = const KeyboardCode._(182);
  static const KeyboardCode mediaLaunchApP2 = const KeyboardCode._(183);
  static const KeyboardCode oem1 = const KeyboardCode._(186);
  static const KeyboardCode oemPlus = const KeyboardCode._(187);
  static const KeyboardCode oemComma = const KeyboardCode._(188);
  static const KeyboardCode oemMinus = const KeyboardCode._(189);
  static const KeyboardCode oemPeriod = const KeyboardCode._(190);
  static const KeyboardCode oem2 = const KeyboardCode._(191);
  static const KeyboardCode oem3 = const KeyboardCode._(192);
  static const KeyboardCode oem4 = const KeyboardCode._(219);
  static const KeyboardCode oem5 = const KeyboardCode._(220);
  static const KeyboardCode oem6 = const KeyboardCode._(221);
  static const KeyboardCode oem7 = const KeyboardCode._(222);
  static const KeyboardCode oem8 = const KeyboardCode._(223);
  static const KeyboardCode oem102 = const KeyboardCode._(226);
  static const KeyboardCode processkey = const KeyboardCode._(229);
  static const KeyboardCode packet = const KeyboardCode._(231);
  static const KeyboardCode dbeSbcschar = const KeyboardCode._(243);
  static const KeyboardCode dbeDbcschar = const KeyboardCode._(244);
  static const KeyboardCode attn = const KeyboardCode._(246);
  static const KeyboardCode crsel = const KeyboardCode._(247);
  static const KeyboardCode exsel = const KeyboardCode._(248);
  static const KeyboardCode ereof = const KeyboardCode._(249);
  static const KeyboardCode play = const KeyboardCode._(250);
  static const KeyboardCode zoom = const KeyboardCode._(251);
  static const KeyboardCode noname = const KeyboardCode._(252);
  static const KeyboardCode pA1 = const KeyboardCode._(253);
  static const KeyboardCode oemClear = const KeyboardCode._(254);
  static const KeyboardCode unknown = const KeyboardCode._(0);
  static const KeyboardCode altgr = const KeyboardCode._(225);

  const KeyboardCode._(int v) : super(v);

  static const Map<String, KeyboardCode> valuesMap = const {
    "back": back,
    "tab": tab,
    "clear": clear,
    "return_": return_,
    "shift": shift,
    "control": control,
    "menu": menu,
    "pause": pause,
    "capital": capital,
    "kana": kana,
    "hangul": hangul,
    "junja": junja,
    "final_": final_,
    "hanja": hanja,
    "kanji": kanji,
    "escape": escape,
    "convert": convert,
    "nonconvert": nonconvert,
    "accept": accept,
    "modechange": modechange,
    "space": space,
    "prior": prior,
    "next": next,
    "end": end,
    "home": home,
    "left": left,
    "up": up,
    "right": right,
    "down": down,
    "select": select,
    "print": print,
    "execute": execute,
    "snapshot": snapshot,
    "insert": insert,
    "delete": delete,
    "help": help,
    "num0": num0,
    "num1": num1,
    "num2": num2,
    "num3": num3,
    "num4": num4,
    "num5": num5,
    "num6": num6,
    "num7": num7,
    "num8": num8,
    "num9": num9,
    "a": a,
    "b": b,
    "c": c,
    "d": d,
    "e": e,
    "f": f,
    "g": g,
    "h": h,
    "i": i,
    "j": j,
    "k": k,
    "l": l,
    "m": m,
    "n": n,
    "o": o,
    "p": p,
    "q": q,
    "r": r,
    "s": s,
    "t": t,
    "u": u,
    "v": v,
    "w": w,
    "x": x,
    "y": y,
    "z": z,
    "lwin": lwin,
    "command": command,
    "rwin": rwin,
    "apps": apps,
    "sleep": sleep,
    "numpaD0": numpaD0,
    "numpaD1": numpaD1,
    "numpaD2": numpaD2,
    "numpaD3": numpaD3,
    "numpaD4": numpaD4,
    "numpaD5": numpaD5,
    "numpaD6": numpaD6,
    "numpaD7": numpaD7,
    "numpaD8": numpaD8,
    "numpaD9": numpaD9,
    "multiply": multiply,
    "add": add,
    "separator": separator,
    "subtract": subtract,
    "decimal": decimal,
    "divide": divide,
    "f1": f1,
    "f2": f2,
    "f3": f3,
    "f4": f4,
    "f5": f5,
    "f6": f6,
    "f7": f7,
    "f8": f8,
    "f9": f9,
    "f10": f10,
    "f11": f11,
    "f12": f12,
    "f13": f13,
    "f14": f14,
    "f15": f15,
    "f16": f16,
    "f17": f17,
    "f18": f18,
    "f19": f19,
    "f20": f20,
    "f21": f21,
    "f22": f22,
    "f23": f23,
    "f24": f24,
    "numlock": numlock,
    "scroll": scroll,
    "lshift": lshift,
    "rshift": rshift,
    "lcontrol": lcontrol,
    "rcontrol": rcontrol,
    "lmenu": lmenu,
    "rmenu": rmenu,
    "browserBack": browserBack,
    "browserForward": browserForward,
    "browserRefresh": browserRefresh,
    "browserStop": browserStop,
    "browserSearch": browserSearch,
    "browserFavorites": browserFavorites,
    "browserHome": browserHome,
    "volumeMute": volumeMute,
    "volumeDown": volumeDown,
    "volumeUp": volumeUp,
    "mediaNextTrack": mediaNextTrack,
    "mediaPrevTrack": mediaPrevTrack,
    "mediaStop": mediaStop,
    "mediaPlayPause": mediaPlayPause,
    "mediaLaunchMail": mediaLaunchMail,
    "mediaLaunchMediaSelect": mediaLaunchMediaSelect,
    "mediaLaunchApP1": mediaLaunchApP1,
    "mediaLaunchApP2": mediaLaunchApP2,
    "oem1": oem1,
    "oemPlus": oemPlus,
    "oemComma": oemComma,
    "oemMinus": oemMinus,
    "oemPeriod": oemPeriod,
    "oem2": oem2,
    "oem3": oem3,
    "oem4": oem4,
    "oem5": oem5,
    "oem6": oem6,
    "oem7": oem7,
    "oem8": oem8,
    "oem102": oem102,
    "processkey": processkey,
    "packet": packet,
    "dbeSbcschar": dbeSbcschar,
    "dbeDbcschar": dbeDbcschar,
    "attn": attn,
    "crsel": crsel,
    "exsel": exsel,
    "ereof": ereof,
    "play": play,
    "zoom": zoom,
    "noname": noname,
    "pA1": pA1,
    "oemClear": oemClear,
    "unknown": unknown,
    "altgr": altgr,
  };
  static const List<KeyboardCode> values = const [
    back,
    tab,
    clear,
    return_,
    shift,
    control,
    menu,
    pause,
    capital,
    kana,
    hangul,
    junja,
    final_,
    hanja,
    kanji,
    escape,
    convert,
    nonconvert,
    accept,
    modechange,
    space,
    prior,
    next,
    end,
    home,
    left,
    up,
    right,
    down,
    select,
    print,
    execute,
    snapshot,
    insert,
    delete,
    help,
    num0,
    num1,
    num2,
    num3,
    num4,
    num5,
    num6,
    num7,
    num8,
    num9,
    a,
    b,
    c,
    d,
    e,
    f,
    g,
    h,
    i,
    j,
    k,
    l,
    m,
    n,
    o,
    p,
    q,
    r,
    s,
    t,
    u,
    v,
    w,
    x,
    y,
    z,
    lwin,
    command,
    rwin,
    apps,
    sleep,
    numpaD0,
    numpaD1,
    numpaD2,
    numpaD3,
    numpaD4,
    numpaD5,
    numpaD6,
    numpaD7,
    numpaD8,
    numpaD9,
    multiply,
    add,
    separator,
    subtract,
    decimal,
    divide,
    f1,
    f2,
    f3,
    f4,
    f5,
    f6,
    f7,
    f8,
    f9,
    f10,
    f11,
    f12,
    f13,
    f14,
    f15,
    f16,
    f17,
    f18,
    f19,
    f20,
    f21,
    f22,
    f23,
    f24,
    numlock,
    scroll,
    lshift,
    rshift,
    lcontrol,
    rcontrol,
    lmenu,
    rmenu,
    browserBack,
    browserForward,
    browserRefresh,
    browserStop,
    browserSearch,
    browserFavorites,
    browserHome,
    volumeMute,
    volumeDown,
    volumeUp,
    mediaNextTrack,
    mediaPrevTrack,
    mediaStop,
    mediaPlayPause,
    mediaLaunchMail,
    mediaLaunchMediaSelect,
    mediaLaunchApP1,
    mediaLaunchApP2,
    oem1,
    oemPlus,
    oemComma,
    oemMinus,
    oemPeriod,
    oem2,
    oem3,
    oem4,
    oem5,
    oem6,
    oem7,
    oem8,
    oem102,
    processkey,
    packet,
    dbeSbcschar,
    dbeDbcschar,
    attn,
    crsel,
    exsel,
    ereof,
    play,
    zoom,
    noname,
    pA1,
    oemClear,
    unknown,
    altgr,
  ];

  static KeyboardCode valueOf(String name) => valuesMap[name];

  factory KeyboardCode(int v) {
    switch (v) {
      case 8:
        return back;
      case 9:
        return tab;
      case 12:
        return clear;
      case 13:
        return return_;
      case 16:
        return shift;
      case 17:
        return control;
      case 18:
        return menu;
      case 19:
        return pause;
      case 20:
        return capital;
      case 21:
        return kana;
      case 21:
        return hangul;
      case 23:
        return junja;
      case 24:
        return final_;
      case 25:
        return hanja;
      case 25:
        return kanji;
      case 27:
        return escape;
      case 28:
        return convert;
      case 29:
        return nonconvert;
      case 30:
        return accept;
      case 31:
        return modechange;
      case 32:
        return space;
      case 33:
        return prior;
      case 34:
        return next;
      case 35:
        return end;
      case 36:
        return home;
      case 37:
        return left;
      case 38:
        return up;
      case 39:
        return right;
      case 40:
        return down;
      case 41:
        return select;
      case 42:
        return print;
      case 43:
        return execute;
      case 44:
        return snapshot;
      case 45:
        return insert;
      case 46:
        return delete;
      case 47:
        return help;
      case 48:
        return num0;
      case 49:
        return num1;
      case 50:
        return num2;
      case 51:
        return num3;
      case 52:
        return num4;
      case 53:
        return num5;
      case 54:
        return num6;
      case 55:
        return num7;
      case 56:
        return num8;
      case 57:
        return num9;
      case 65:
        return a;
      case 66:
        return b;
      case 67:
        return c;
      case 68:
        return d;
      case 69:
        return e;
      case 70:
        return f;
      case 71:
        return g;
      case 72:
        return h;
      case 73:
        return i;
      case 74:
        return j;
      case 75:
        return k;
      case 76:
        return l;
      case 77:
        return m;
      case 78:
        return n;
      case 79:
        return o;
      case 80:
        return p;
      case 81:
        return q;
      case 82:
        return r;
      case 83:
        return s;
      case 84:
        return t;
      case 85:
        return u;
      case 86:
        return v;
      case 87:
        return w;
      case 88:
        return x;
      case 89:
        return y;
      case 90:
        return z;
      case 91:
        return lwin;
      case 91:
        return command;
      case 92:
        return rwin;
      case 93:
        return apps;
      case 95:
        return sleep;
      case 96:
        return numpaD0;
      case 97:
        return numpaD1;
      case 98:
        return numpaD2;
      case 99:
        return numpaD3;
      case 100:
        return numpaD4;
      case 101:
        return numpaD5;
      case 102:
        return numpaD6;
      case 103:
        return numpaD7;
      case 104:
        return numpaD8;
      case 105:
        return numpaD9;
      case 106:
        return multiply;
      case 107:
        return add;
      case 108:
        return separator;
      case 109:
        return subtract;
      case 110:
        return decimal;
      case 111:
        return divide;
      case 112:
        return f1;
      case 113:
        return f2;
      case 114:
        return f3;
      case 115:
        return f4;
      case 116:
        return f5;
      case 117:
        return f6;
      case 118:
        return f7;
      case 119:
        return f8;
      case 120:
        return f9;
      case 121:
        return f10;
      case 122:
        return f11;
      case 123:
        return f12;
      case 124:
        return f13;
      case 125:
        return f14;
      case 126:
        return f15;
      case 127:
        return f16;
      case 128:
        return f17;
      case 129:
        return f18;
      case 130:
        return f19;
      case 131:
        return f20;
      case 132:
        return f21;
      case 133:
        return f22;
      case 134:
        return f23;
      case 135:
        return f24;
      case 144:
        return numlock;
      case 145:
        return scroll;
      case 160:
        return lshift;
      case 161:
        return rshift;
      case 162:
        return lcontrol;
      case 163:
        return rcontrol;
      case 164:
        return lmenu;
      case 165:
        return rmenu;
      case 166:
        return browserBack;
      case 167:
        return browserForward;
      case 168:
        return browserRefresh;
      case 169:
        return browserStop;
      case 170:
        return browserSearch;
      case 171:
        return browserFavorites;
      case 172:
        return browserHome;
      case 173:
        return volumeMute;
      case 174:
        return volumeDown;
      case 175:
        return volumeUp;
      case 176:
        return mediaNextTrack;
      case 177:
        return mediaPrevTrack;
      case 178:
        return mediaStop;
      case 179:
        return mediaPlayPause;
      case 180:
        return mediaLaunchMail;
      case 181:
        return mediaLaunchMediaSelect;
      case 182:
        return mediaLaunchApP1;
      case 183:
        return mediaLaunchApP2;
      case 186:
        return oem1;
      case 187:
        return oemPlus;
      case 188:
        return oemComma;
      case 189:
        return oemMinus;
      case 190:
        return oemPeriod;
      case 191:
        return oem2;
      case 192:
        return oem3;
      case 219:
        return oem4;
      case 220:
        return oem5;
      case 221:
        return oem6;
      case 222:
        return oem7;
      case 223:
        return oem8;
      case 226:
        return oem102;
      case 229:
        return processkey;
      case 231:
        return packet;
      case 243:
        return dbeSbcschar;
      case 244:
        return dbeDbcschar;
      case 246:
        return attn;
      case 247:
        return crsel;
      case 248:
        return exsel;
      case 249:
        return ereof;
      case 250:
        return play;
      case 251:
        return zoom;
      case 252:
        return noname;
      case 253:
        return pA1;
      case 254:
        return oemClear;
      case 0:
        return unknown;
      case 225:
        return altgr;
      default:
        return null;
    }
  }

  static KeyboardCode decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    KeyboardCode result = new KeyboardCode(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum KeyboardCode.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case back:
        return 'KeyboardCode.back';
      case tab:
        return 'KeyboardCode.tab';
      case clear:
        return 'KeyboardCode.clear';
      case return_:
        return 'KeyboardCode.return_';
      case shift:
        return 'KeyboardCode.shift';
      case control:
        return 'KeyboardCode.control';
      case menu:
        return 'KeyboardCode.menu';
      case pause:
        return 'KeyboardCode.pause';
      case capital:
        return 'KeyboardCode.capital';
      case kana:
        return 'KeyboardCode.kana';
      case hangul:
        return 'KeyboardCode.hangul';
      case junja:
        return 'KeyboardCode.junja';
      case final_:
        return 'KeyboardCode.final_';
      case hanja:
        return 'KeyboardCode.hanja';
      case kanji:
        return 'KeyboardCode.kanji';
      case escape:
        return 'KeyboardCode.escape';
      case convert:
        return 'KeyboardCode.convert';
      case nonconvert:
        return 'KeyboardCode.nonconvert';
      case accept:
        return 'KeyboardCode.accept';
      case modechange:
        return 'KeyboardCode.modechange';
      case space:
        return 'KeyboardCode.space';
      case prior:
        return 'KeyboardCode.prior';
      case next:
        return 'KeyboardCode.next';
      case end:
        return 'KeyboardCode.end';
      case home:
        return 'KeyboardCode.home';
      case left:
        return 'KeyboardCode.left';
      case up:
        return 'KeyboardCode.up';
      case right:
        return 'KeyboardCode.right';
      case down:
        return 'KeyboardCode.down';
      case select:
        return 'KeyboardCode.select';
      case print:
        return 'KeyboardCode.print';
      case execute:
        return 'KeyboardCode.execute';
      case snapshot:
        return 'KeyboardCode.snapshot';
      case insert:
        return 'KeyboardCode.insert';
      case delete:
        return 'KeyboardCode.delete';
      case help:
        return 'KeyboardCode.help';
      case num0:
        return 'KeyboardCode.num0';
      case num1:
        return 'KeyboardCode.num1';
      case num2:
        return 'KeyboardCode.num2';
      case num3:
        return 'KeyboardCode.num3';
      case num4:
        return 'KeyboardCode.num4';
      case num5:
        return 'KeyboardCode.num5';
      case num6:
        return 'KeyboardCode.num6';
      case num7:
        return 'KeyboardCode.num7';
      case num8:
        return 'KeyboardCode.num8';
      case num9:
        return 'KeyboardCode.num9';
      case a:
        return 'KeyboardCode.a';
      case b:
        return 'KeyboardCode.b';
      case c:
        return 'KeyboardCode.c';
      case d:
        return 'KeyboardCode.d';
      case e:
        return 'KeyboardCode.e';
      case f:
        return 'KeyboardCode.f';
      case g:
        return 'KeyboardCode.g';
      case h:
        return 'KeyboardCode.h';
      case i:
        return 'KeyboardCode.i';
      case j:
        return 'KeyboardCode.j';
      case k:
        return 'KeyboardCode.k';
      case l:
        return 'KeyboardCode.l';
      case m:
        return 'KeyboardCode.m';
      case n:
        return 'KeyboardCode.n';
      case o:
        return 'KeyboardCode.o';
      case p:
        return 'KeyboardCode.p';
      case q:
        return 'KeyboardCode.q';
      case r:
        return 'KeyboardCode.r';
      case s:
        return 'KeyboardCode.s';
      case t:
        return 'KeyboardCode.t';
      case u:
        return 'KeyboardCode.u';
      case v:
        return 'KeyboardCode.v';
      case w:
        return 'KeyboardCode.w';
      case x:
        return 'KeyboardCode.x';
      case y:
        return 'KeyboardCode.y';
      case z:
        return 'KeyboardCode.z';
      case lwin:
        return 'KeyboardCode.lwin';
      case command:
        return 'KeyboardCode.command';
      case rwin:
        return 'KeyboardCode.rwin';
      case apps:
        return 'KeyboardCode.apps';
      case sleep:
        return 'KeyboardCode.sleep';
      case numpaD0:
        return 'KeyboardCode.numpaD0';
      case numpaD1:
        return 'KeyboardCode.numpaD1';
      case numpaD2:
        return 'KeyboardCode.numpaD2';
      case numpaD3:
        return 'KeyboardCode.numpaD3';
      case numpaD4:
        return 'KeyboardCode.numpaD4';
      case numpaD5:
        return 'KeyboardCode.numpaD5';
      case numpaD6:
        return 'KeyboardCode.numpaD6';
      case numpaD7:
        return 'KeyboardCode.numpaD7';
      case numpaD8:
        return 'KeyboardCode.numpaD8';
      case numpaD9:
        return 'KeyboardCode.numpaD9';
      case multiply:
        return 'KeyboardCode.multiply';
      case add:
        return 'KeyboardCode.add';
      case separator:
        return 'KeyboardCode.separator';
      case subtract:
        return 'KeyboardCode.subtract';
      case decimal:
        return 'KeyboardCode.decimal';
      case divide:
        return 'KeyboardCode.divide';
      case f1:
        return 'KeyboardCode.f1';
      case f2:
        return 'KeyboardCode.f2';
      case f3:
        return 'KeyboardCode.f3';
      case f4:
        return 'KeyboardCode.f4';
      case f5:
        return 'KeyboardCode.f5';
      case f6:
        return 'KeyboardCode.f6';
      case f7:
        return 'KeyboardCode.f7';
      case f8:
        return 'KeyboardCode.f8';
      case f9:
        return 'KeyboardCode.f9';
      case f10:
        return 'KeyboardCode.f10';
      case f11:
        return 'KeyboardCode.f11';
      case f12:
        return 'KeyboardCode.f12';
      case f13:
        return 'KeyboardCode.f13';
      case f14:
        return 'KeyboardCode.f14';
      case f15:
        return 'KeyboardCode.f15';
      case f16:
        return 'KeyboardCode.f16';
      case f17:
        return 'KeyboardCode.f17';
      case f18:
        return 'KeyboardCode.f18';
      case f19:
        return 'KeyboardCode.f19';
      case f20:
        return 'KeyboardCode.f20';
      case f21:
        return 'KeyboardCode.f21';
      case f22:
        return 'KeyboardCode.f22';
      case f23:
        return 'KeyboardCode.f23';
      case f24:
        return 'KeyboardCode.f24';
      case numlock:
        return 'KeyboardCode.numlock';
      case scroll:
        return 'KeyboardCode.scroll';
      case lshift:
        return 'KeyboardCode.lshift';
      case rshift:
        return 'KeyboardCode.rshift';
      case lcontrol:
        return 'KeyboardCode.lcontrol';
      case rcontrol:
        return 'KeyboardCode.rcontrol';
      case lmenu:
        return 'KeyboardCode.lmenu';
      case rmenu:
        return 'KeyboardCode.rmenu';
      case browserBack:
        return 'KeyboardCode.browserBack';
      case browserForward:
        return 'KeyboardCode.browserForward';
      case browserRefresh:
        return 'KeyboardCode.browserRefresh';
      case browserStop:
        return 'KeyboardCode.browserStop';
      case browserSearch:
        return 'KeyboardCode.browserSearch';
      case browserFavorites:
        return 'KeyboardCode.browserFavorites';
      case browserHome:
        return 'KeyboardCode.browserHome';
      case volumeMute:
        return 'KeyboardCode.volumeMute';
      case volumeDown:
        return 'KeyboardCode.volumeDown';
      case volumeUp:
        return 'KeyboardCode.volumeUp';
      case mediaNextTrack:
        return 'KeyboardCode.mediaNextTrack';
      case mediaPrevTrack:
        return 'KeyboardCode.mediaPrevTrack';
      case mediaStop:
        return 'KeyboardCode.mediaStop';
      case mediaPlayPause:
        return 'KeyboardCode.mediaPlayPause';
      case mediaLaunchMail:
        return 'KeyboardCode.mediaLaunchMail';
      case mediaLaunchMediaSelect:
        return 'KeyboardCode.mediaLaunchMediaSelect';
      case mediaLaunchApP1:
        return 'KeyboardCode.mediaLaunchApP1';
      case mediaLaunchApP2:
        return 'KeyboardCode.mediaLaunchApP2';
      case oem1:
        return 'KeyboardCode.oem1';
      case oemPlus:
        return 'KeyboardCode.oemPlus';
      case oemComma:
        return 'KeyboardCode.oemComma';
      case oemMinus:
        return 'KeyboardCode.oemMinus';
      case oemPeriod:
        return 'KeyboardCode.oemPeriod';
      case oem2:
        return 'KeyboardCode.oem2';
      case oem3:
        return 'KeyboardCode.oem3';
      case oem4:
        return 'KeyboardCode.oem4';
      case oem5:
        return 'KeyboardCode.oem5';
      case oem6:
        return 'KeyboardCode.oem6';
      case oem7:
        return 'KeyboardCode.oem7';
      case oem8:
        return 'KeyboardCode.oem8';
      case oem102:
        return 'KeyboardCode.oem102';
      case processkey:
        return 'KeyboardCode.processkey';
      case packet:
        return 'KeyboardCode.packet';
      case dbeSbcschar:
        return 'KeyboardCode.dbeSbcschar';
      case dbeDbcschar:
        return 'KeyboardCode.dbeDbcschar';
      case attn:
        return 'KeyboardCode.attn';
      case crsel:
        return 'KeyboardCode.crsel';
      case exsel:
        return 'KeyboardCode.exsel';
      case ereof:
        return 'KeyboardCode.ereof';
      case play:
        return 'KeyboardCode.play';
      case zoom:
        return 'KeyboardCode.zoom';
      case noname:
        return 'KeyboardCode.noname';
      case pA1:
        return 'KeyboardCode.pA1';
      case oemClear:
        return 'KeyboardCode.oemClear';
      case unknown:
        return 'KeyboardCode.unknown';
      case altgr:
        return 'KeyboardCode.altgr';
    }
  }

  int toJson() => mojoEnumValue;
}



