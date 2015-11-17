// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library input_key_codes_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
class KeyboardCode extends bindings.MojoEnum {
  static const BACK = const KeyboardCode._(8);
  static const TAB = const KeyboardCode._(9);
  static const CLEAR = const KeyboardCode._(12);
  static const RETURN = const KeyboardCode._(13);
  static const SHIFT = const KeyboardCode._(16);
  static const CONTROL = const KeyboardCode._(17);
  static const MENU = const KeyboardCode._(18);
  static const PAUSE = const KeyboardCode._(19);
  static const CAPITAL = const KeyboardCode._(20);
  static const KANA = const KeyboardCode._(21);
  static const HANGUL = const KeyboardCode._(21);
  static const JUNJA = const KeyboardCode._(23);
  static const FINAL = const KeyboardCode._(24);
  static const HANJA = const KeyboardCode._(25);
  static const KANJI = const KeyboardCode._(25);
  static const ESCAPE = const KeyboardCode._(27);
  static const CONVERT = const KeyboardCode._(28);
  static const NONCONVERT = const KeyboardCode._(29);
  static const ACCEPT = const KeyboardCode._(30);
  static const MODECHANGE = const KeyboardCode._(31);
  static const SPACE = const KeyboardCode._(32);
  static const PRIOR = const KeyboardCode._(33);
  static const NEXT = const KeyboardCode._(34);
  static const END = const KeyboardCode._(35);
  static const HOME = const KeyboardCode._(36);
  static const LEFT = const KeyboardCode._(37);
  static const UP = const KeyboardCode._(38);
  static const RIGHT = const KeyboardCode._(39);
  static const DOWN = const KeyboardCode._(40);
  static const SELECT = const KeyboardCode._(41);
  static const PRINT = const KeyboardCode._(42);
  static const EXECUTE = const KeyboardCode._(43);
  static const SNAPSHOT = const KeyboardCode._(44);
  static const INSERT = const KeyboardCode._(45);
  static const DELETE = const KeyboardCode._(46);
  static const HELP = const KeyboardCode._(47);
  static const NUM_0 = const KeyboardCode._(48);
  static const NUM_1 = const KeyboardCode._(49);
  static const NUM_2 = const KeyboardCode._(50);
  static const NUM_3 = const KeyboardCode._(51);
  static const NUM_4 = const KeyboardCode._(52);
  static const NUM_5 = const KeyboardCode._(53);
  static const NUM_6 = const KeyboardCode._(54);
  static const NUM_7 = const KeyboardCode._(55);
  static const NUM_8 = const KeyboardCode._(56);
  static const NUM_9 = const KeyboardCode._(57);
  static const A = const KeyboardCode._(65);
  static const B = const KeyboardCode._(66);
  static const C = const KeyboardCode._(67);
  static const D = const KeyboardCode._(68);
  static const E = const KeyboardCode._(69);
  static const F = const KeyboardCode._(70);
  static const G = const KeyboardCode._(71);
  static const H = const KeyboardCode._(72);
  static const I = const KeyboardCode._(73);
  static const J = const KeyboardCode._(74);
  static const K = const KeyboardCode._(75);
  static const L = const KeyboardCode._(76);
  static const M = const KeyboardCode._(77);
  static const N = const KeyboardCode._(78);
  static const O = const KeyboardCode._(79);
  static const P = const KeyboardCode._(80);
  static const Q = const KeyboardCode._(81);
  static const R = const KeyboardCode._(82);
  static const S = const KeyboardCode._(83);
  static const T = const KeyboardCode._(84);
  static const U = const KeyboardCode._(85);
  static const V = const KeyboardCode._(86);
  static const W = const KeyboardCode._(87);
  static const X = const KeyboardCode._(88);
  static const Y = const KeyboardCode._(89);
  static const Z = const KeyboardCode._(90);
  static const LWIN = const KeyboardCode._(91);
  static const COMMAND = const KeyboardCode._(91);
  static const RWIN = const KeyboardCode._(92);
  static const APPS = const KeyboardCode._(93);
  static const SLEEP = const KeyboardCode._(95);
  static const NUMPAD0 = const KeyboardCode._(96);
  static const NUMPAD1 = const KeyboardCode._(97);
  static const NUMPAD2 = const KeyboardCode._(98);
  static const NUMPAD3 = const KeyboardCode._(99);
  static const NUMPAD4 = const KeyboardCode._(100);
  static const NUMPAD5 = const KeyboardCode._(101);
  static const NUMPAD6 = const KeyboardCode._(102);
  static const NUMPAD7 = const KeyboardCode._(103);
  static const NUMPAD8 = const KeyboardCode._(104);
  static const NUMPAD9 = const KeyboardCode._(105);
  static const MULTIPLY = const KeyboardCode._(106);
  static const ADD = const KeyboardCode._(107);
  static const SEPARATOR = const KeyboardCode._(108);
  static const SUBTRACT = const KeyboardCode._(109);
  static const DECIMAL = const KeyboardCode._(110);
  static const DIVIDE = const KeyboardCode._(111);
  static const F1 = const KeyboardCode._(112);
  static const F2 = const KeyboardCode._(113);
  static const F3 = const KeyboardCode._(114);
  static const F4 = const KeyboardCode._(115);
  static const F5 = const KeyboardCode._(116);
  static const F6 = const KeyboardCode._(117);
  static const F7 = const KeyboardCode._(118);
  static const F8 = const KeyboardCode._(119);
  static const F9 = const KeyboardCode._(120);
  static const F10 = const KeyboardCode._(121);
  static const F11 = const KeyboardCode._(122);
  static const F12 = const KeyboardCode._(123);
  static const F13 = const KeyboardCode._(124);
  static const F14 = const KeyboardCode._(125);
  static const F15 = const KeyboardCode._(126);
  static const F16 = const KeyboardCode._(127);
  static const F17 = const KeyboardCode._(128);
  static const F18 = const KeyboardCode._(129);
  static const F19 = const KeyboardCode._(130);
  static const F20 = const KeyboardCode._(131);
  static const F21 = const KeyboardCode._(132);
  static const F22 = const KeyboardCode._(133);
  static const F23 = const KeyboardCode._(134);
  static const F24 = const KeyboardCode._(135);
  static const NUMLOCK = const KeyboardCode._(144);
  static const SCROLL = const KeyboardCode._(145);
  static const LSHIFT = const KeyboardCode._(160);
  static const RSHIFT = const KeyboardCode._(161);
  static const LCONTROL = const KeyboardCode._(162);
  static const RCONTROL = const KeyboardCode._(163);
  static const LMENU = const KeyboardCode._(164);
  static const RMENU = const KeyboardCode._(165);
  static const BROWSER_BACK = const KeyboardCode._(166);
  static const BROWSER_FORWARD = const KeyboardCode._(167);
  static const BROWSER_REFRESH = const KeyboardCode._(168);
  static const BROWSER_STOP = const KeyboardCode._(169);
  static const BROWSER_SEARCH = const KeyboardCode._(170);
  static const BROWSER_FAVORITES = const KeyboardCode._(171);
  static const BROWSER_HOME = const KeyboardCode._(172);
  static const VOLUME_MUTE = const KeyboardCode._(173);
  static const VOLUME_DOWN = const KeyboardCode._(174);
  static const VOLUME_UP = const KeyboardCode._(175);
  static const MEDIA_NEXT_TRACK = const KeyboardCode._(176);
  static const MEDIA_PREV_TRACK = const KeyboardCode._(177);
  static const MEDIA_STOP = const KeyboardCode._(178);
  static const MEDIA_PLAY_PAUSE = const KeyboardCode._(179);
  static const MEDIA_LAUNCH_MAIL = const KeyboardCode._(180);
  static const MEDIA_LAUNCH_MEDIA_SELECT = const KeyboardCode._(181);
  static const MEDIA_LAUNCH_APP1 = const KeyboardCode._(182);
  static const MEDIA_LAUNCH_APP2 = const KeyboardCode._(183);
  static const OEM_1 = const KeyboardCode._(186);
  static const OEM_PLUS = const KeyboardCode._(187);
  static const OEM_COMMA = const KeyboardCode._(188);
  static const OEM_MINUS = const KeyboardCode._(189);
  static const OEM_PERIOD = const KeyboardCode._(190);
  static const OEM_2 = const KeyboardCode._(191);
  static const OEM_3 = const KeyboardCode._(192);
  static const OEM_4 = const KeyboardCode._(219);
  static const OEM_5 = const KeyboardCode._(220);
  static const OEM_6 = const KeyboardCode._(221);
  static const OEM_7 = const KeyboardCode._(222);
  static const OEM_8 = const KeyboardCode._(223);
  static const OEM_102 = const KeyboardCode._(226);
  static const PROCESSKEY = const KeyboardCode._(229);
  static const PACKET = const KeyboardCode._(231);
  static const DBE_SBCSCHAR = const KeyboardCode._(243);
  static const DBE_DBCSCHAR = const KeyboardCode._(244);
  static const ATTN = const KeyboardCode._(246);
  static const CRSEL = const KeyboardCode._(247);
  static const EXSEL = const KeyboardCode._(248);
  static const EREOF = const KeyboardCode._(249);
  static const PLAY = const KeyboardCode._(250);
  static const ZOOM = const KeyboardCode._(251);
  static const NONAME = const KeyboardCode._(252);
  static const PA1 = const KeyboardCode._(253);
  static const OEM_CLEAR = const KeyboardCode._(254);
  static const UNKNOWN = const KeyboardCode._(0);
  static const ALTGR = const KeyboardCode._(225);

  const KeyboardCode._(int v) : super(v);

  static const Map<String, KeyboardCode> valuesMap = const {
    "BACK": BACK,
    "TAB": TAB,
    "CLEAR": CLEAR,
    "RETURN": RETURN,
    "SHIFT": SHIFT,
    "CONTROL": CONTROL,
    "MENU": MENU,
    "PAUSE": PAUSE,
    "CAPITAL": CAPITAL,
    "KANA": KANA,
    "HANGUL": HANGUL,
    "JUNJA": JUNJA,
    "FINAL": FINAL,
    "HANJA": HANJA,
    "KANJI": KANJI,
    "ESCAPE": ESCAPE,
    "CONVERT": CONVERT,
    "NONCONVERT": NONCONVERT,
    "ACCEPT": ACCEPT,
    "MODECHANGE": MODECHANGE,
    "SPACE": SPACE,
    "PRIOR": PRIOR,
    "NEXT": NEXT,
    "END": END,
    "HOME": HOME,
    "LEFT": LEFT,
    "UP": UP,
    "RIGHT": RIGHT,
    "DOWN": DOWN,
    "SELECT": SELECT,
    "PRINT": PRINT,
    "EXECUTE": EXECUTE,
    "SNAPSHOT": SNAPSHOT,
    "INSERT": INSERT,
    "DELETE": DELETE,
    "HELP": HELP,
    "NUM_0": NUM_0,
    "NUM_1": NUM_1,
    "NUM_2": NUM_2,
    "NUM_3": NUM_3,
    "NUM_4": NUM_4,
    "NUM_5": NUM_5,
    "NUM_6": NUM_6,
    "NUM_7": NUM_7,
    "NUM_8": NUM_8,
    "NUM_9": NUM_9,
    "A": A,
    "B": B,
    "C": C,
    "D": D,
    "E": E,
    "F": F,
    "G": G,
    "H": H,
    "I": I,
    "J": J,
    "K": K,
    "L": L,
    "M": M,
    "N": N,
    "O": O,
    "P": P,
    "Q": Q,
    "R": R,
    "S": S,
    "T": T,
    "U": U,
    "V": V,
    "W": W,
    "X": X,
    "Y": Y,
    "Z": Z,
    "LWIN": LWIN,
    "COMMAND": COMMAND,
    "RWIN": RWIN,
    "APPS": APPS,
    "SLEEP": SLEEP,
    "NUMPAD0": NUMPAD0,
    "NUMPAD1": NUMPAD1,
    "NUMPAD2": NUMPAD2,
    "NUMPAD3": NUMPAD3,
    "NUMPAD4": NUMPAD4,
    "NUMPAD5": NUMPAD5,
    "NUMPAD6": NUMPAD6,
    "NUMPAD7": NUMPAD7,
    "NUMPAD8": NUMPAD8,
    "NUMPAD9": NUMPAD9,
    "MULTIPLY": MULTIPLY,
    "ADD": ADD,
    "SEPARATOR": SEPARATOR,
    "SUBTRACT": SUBTRACT,
    "DECIMAL": DECIMAL,
    "DIVIDE": DIVIDE,
    "F1": F1,
    "F2": F2,
    "F3": F3,
    "F4": F4,
    "F5": F5,
    "F6": F6,
    "F7": F7,
    "F8": F8,
    "F9": F9,
    "F10": F10,
    "F11": F11,
    "F12": F12,
    "F13": F13,
    "F14": F14,
    "F15": F15,
    "F16": F16,
    "F17": F17,
    "F18": F18,
    "F19": F19,
    "F20": F20,
    "F21": F21,
    "F22": F22,
    "F23": F23,
    "F24": F24,
    "NUMLOCK": NUMLOCK,
    "SCROLL": SCROLL,
    "LSHIFT": LSHIFT,
    "RSHIFT": RSHIFT,
    "LCONTROL": LCONTROL,
    "RCONTROL": RCONTROL,
    "LMENU": LMENU,
    "RMENU": RMENU,
    "BROWSER_BACK": BROWSER_BACK,
    "BROWSER_FORWARD": BROWSER_FORWARD,
    "BROWSER_REFRESH": BROWSER_REFRESH,
    "BROWSER_STOP": BROWSER_STOP,
    "BROWSER_SEARCH": BROWSER_SEARCH,
    "BROWSER_FAVORITES": BROWSER_FAVORITES,
    "BROWSER_HOME": BROWSER_HOME,
    "VOLUME_MUTE": VOLUME_MUTE,
    "VOLUME_DOWN": VOLUME_DOWN,
    "VOLUME_UP": VOLUME_UP,
    "MEDIA_NEXT_TRACK": MEDIA_NEXT_TRACK,
    "MEDIA_PREV_TRACK": MEDIA_PREV_TRACK,
    "MEDIA_STOP": MEDIA_STOP,
    "MEDIA_PLAY_PAUSE": MEDIA_PLAY_PAUSE,
    "MEDIA_LAUNCH_MAIL": MEDIA_LAUNCH_MAIL,
    "MEDIA_LAUNCH_MEDIA_SELECT": MEDIA_LAUNCH_MEDIA_SELECT,
    "MEDIA_LAUNCH_APP1": MEDIA_LAUNCH_APP1,
    "MEDIA_LAUNCH_APP2": MEDIA_LAUNCH_APP2,
    "OEM_1": OEM_1,
    "OEM_PLUS": OEM_PLUS,
    "OEM_COMMA": OEM_COMMA,
    "OEM_MINUS": OEM_MINUS,
    "OEM_PERIOD": OEM_PERIOD,
    "OEM_2": OEM_2,
    "OEM_3": OEM_3,
    "OEM_4": OEM_4,
    "OEM_5": OEM_5,
    "OEM_6": OEM_6,
    "OEM_7": OEM_7,
    "OEM_8": OEM_8,
    "OEM_102": OEM_102,
    "PROCESSKEY": PROCESSKEY,
    "PACKET": PACKET,
    "DBE_SBCSCHAR": DBE_SBCSCHAR,
    "DBE_DBCSCHAR": DBE_DBCSCHAR,
    "ATTN": ATTN,
    "CRSEL": CRSEL,
    "EXSEL": EXSEL,
    "EREOF": EREOF,
    "PLAY": PLAY,
    "ZOOM": ZOOM,
    "NONAME": NONAME,
    "PA1": PA1,
    "OEM_CLEAR": OEM_CLEAR,
    "UNKNOWN": UNKNOWN,
    "ALTGR": ALTGR,
  };
  static const List<KeyboardCode> values = const [
    BACK,
    TAB,
    CLEAR,
    RETURN,
    SHIFT,
    CONTROL,
    MENU,
    PAUSE,
    CAPITAL,
    KANA,
    HANGUL,
    JUNJA,
    FINAL,
    HANJA,
    KANJI,
    ESCAPE,
    CONVERT,
    NONCONVERT,
    ACCEPT,
    MODECHANGE,
    SPACE,
    PRIOR,
    NEXT,
    END,
    HOME,
    LEFT,
    UP,
    RIGHT,
    DOWN,
    SELECT,
    PRINT,
    EXECUTE,
    SNAPSHOT,
    INSERT,
    DELETE,
    HELP,
    NUM_0,
    NUM_1,
    NUM_2,
    NUM_3,
    NUM_4,
    NUM_5,
    NUM_6,
    NUM_7,
    NUM_8,
    NUM_9,
    A,
    B,
    C,
    D,
    E,
    F,
    G,
    H,
    I,
    J,
    K,
    L,
    M,
    N,
    O,
    P,
    Q,
    R,
    S,
    T,
    U,
    V,
    W,
    X,
    Y,
    Z,
    LWIN,
    COMMAND,
    RWIN,
    APPS,
    SLEEP,
    NUMPAD0,
    NUMPAD1,
    NUMPAD2,
    NUMPAD3,
    NUMPAD4,
    NUMPAD5,
    NUMPAD6,
    NUMPAD7,
    NUMPAD8,
    NUMPAD9,
    MULTIPLY,
    ADD,
    SEPARATOR,
    SUBTRACT,
    DECIMAL,
    DIVIDE,
    F1,
    F2,
    F3,
    F4,
    F5,
    F6,
    F7,
    F8,
    F9,
    F10,
    F11,
    F12,
    F13,
    F14,
    F15,
    F16,
    F17,
    F18,
    F19,
    F20,
    F21,
    F22,
    F23,
    F24,
    NUMLOCK,
    SCROLL,
    LSHIFT,
    RSHIFT,
    LCONTROL,
    RCONTROL,
    LMENU,
    RMENU,
    BROWSER_BACK,
    BROWSER_FORWARD,
    BROWSER_REFRESH,
    BROWSER_STOP,
    BROWSER_SEARCH,
    BROWSER_FAVORITES,
    BROWSER_HOME,
    VOLUME_MUTE,
    VOLUME_DOWN,
    VOLUME_UP,
    MEDIA_NEXT_TRACK,
    MEDIA_PREV_TRACK,
    MEDIA_STOP,
    MEDIA_PLAY_PAUSE,
    MEDIA_LAUNCH_MAIL,
    MEDIA_LAUNCH_MEDIA_SELECT,
    MEDIA_LAUNCH_APP1,
    MEDIA_LAUNCH_APP2,
    OEM_1,
    OEM_PLUS,
    OEM_COMMA,
    OEM_MINUS,
    OEM_PERIOD,
    OEM_2,
    OEM_3,
    OEM_4,
    OEM_5,
    OEM_6,
    OEM_7,
    OEM_8,
    OEM_102,
    PROCESSKEY,
    PACKET,
    DBE_SBCSCHAR,
    DBE_DBCSCHAR,
    ATTN,
    CRSEL,
    EXSEL,
    EREOF,
    PLAY,
    ZOOM,
    NONAME,
    PA1,
    OEM_CLEAR,
    UNKNOWN,
    ALTGR,
  ];

  static KeyboardCode valueOf(String name) => valuesMap[name];

  factory KeyboardCode(int v) {
    switch (v) {
      case 8:
        return BACK;
      case 9:
        return TAB;
      case 12:
        return CLEAR;
      case 13:
        return RETURN;
      case 16:
        return SHIFT;
      case 17:
        return CONTROL;
      case 18:
        return MENU;
      case 19:
        return PAUSE;
      case 20:
        return CAPITAL;
      case 21:
        return KANA;
      case 21:
        return HANGUL;
      case 23:
        return JUNJA;
      case 24:
        return FINAL;
      case 25:
        return HANJA;
      case 25:
        return KANJI;
      case 27:
        return ESCAPE;
      case 28:
        return CONVERT;
      case 29:
        return NONCONVERT;
      case 30:
        return ACCEPT;
      case 31:
        return MODECHANGE;
      case 32:
        return SPACE;
      case 33:
        return PRIOR;
      case 34:
        return NEXT;
      case 35:
        return END;
      case 36:
        return HOME;
      case 37:
        return LEFT;
      case 38:
        return UP;
      case 39:
        return RIGHT;
      case 40:
        return DOWN;
      case 41:
        return SELECT;
      case 42:
        return PRINT;
      case 43:
        return EXECUTE;
      case 44:
        return SNAPSHOT;
      case 45:
        return INSERT;
      case 46:
        return DELETE;
      case 47:
        return HELP;
      case 48:
        return NUM_0;
      case 49:
        return NUM_1;
      case 50:
        return NUM_2;
      case 51:
        return NUM_3;
      case 52:
        return NUM_4;
      case 53:
        return NUM_5;
      case 54:
        return NUM_6;
      case 55:
        return NUM_7;
      case 56:
        return NUM_8;
      case 57:
        return NUM_9;
      case 65:
        return A;
      case 66:
        return B;
      case 67:
        return C;
      case 68:
        return D;
      case 69:
        return E;
      case 70:
        return F;
      case 71:
        return G;
      case 72:
        return H;
      case 73:
        return I;
      case 74:
        return J;
      case 75:
        return K;
      case 76:
        return L;
      case 77:
        return M;
      case 78:
        return N;
      case 79:
        return O;
      case 80:
        return P;
      case 81:
        return Q;
      case 82:
        return R;
      case 83:
        return S;
      case 84:
        return T;
      case 85:
        return U;
      case 86:
        return V;
      case 87:
        return W;
      case 88:
        return X;
      case 89:
        return Y;
      case 90:
        return Z;
      case 91:
        return LWIN;
      case 91:
        return COMMAND;
      case 92:
        return RWIN;
      case 93:
        return APPS;
      case 95:
        return SLEEP;
      case 96:
        return NUMPAD0;
      case 97:
        return NUMPAD1;
      case 98:
        return NUMPAD2;
      case 99:
        return NUMPAD3;
      case 100:
        return NUMPAD4;
      case 101:
        return NUMPAD5;
      case 102:
        return NUMPAD6;
      case 103:
        return NUMPAD7;
      case 104:
        return NUMPAD8;
      case 105:
        return NUMPAD9;
      case 106:
        return MULTIPLY;
      case 107:
        return ADD;
      case 108:
        return SEPARATOR;
      case 109:
        return SUBTRACT;
      case 110:
        return DECIMAL;
      case 111:
        return DIVIDE;
      case 112:
        return F1;
      case 113:
        return F2;
      case 114:
        return F3;
      case 115:
        return F4;
      case 116:
        return F5;
      case 117:
        return F6;
      case 118:
        return F7;
      case 119:
        return F8;
      case 120:
        return F9;
      case 121:
        return F10;
      case 122:
        return F11;
      case 123:
        return F12;
      case 124:
        return F13;
      case 125:
        return F14;
      case 126:
        return F15;
      case 127:
        return F16;
      case 128:
        return F17;
      case 129:
        return F18;
      case 130:
        return F19;
      case 131:
        return F20;
      case 132:
        return F21;
      case 133:
        return F22;
      case 134:
        return F23;
      case 135:
        return F24;
      case 144:
        return NUMLOCK;
      case 145:
        return SCROLL;
      case 160:
        return LSHIFT;
      case 161:
        return RSHIFT;
      case 162:
        return LCONTROL;
      case 163:
        return RCONTROL;
      case 164:
        return LMENU;
      case 165:
        return RMENU;
      case 166:
        return BROWSER_BACK;
      case 167:
        return BROWSER_FORWARD;
      case 168:
        return BROWSER_REFRESH;
      case 169:
        return BROWSER_STOP;
      case 170:
        return BROWSER_SEARCH;
      case 171:
        return BROWSER_FAVORITES;
      case 172:
        return BROWSER_HOME;
      case 173:
        return VOLUME_MUTE;
      case 174:
        return VOLUME_DOWN;
      case 175:
        return VOLUME_UP;
      case 176:
        return MEDIA_NEXT_TRACK;
      case 177:
        return MEDIA_PREV_TRACK;
      case 178:
        return MEDIA_STOP;
      case 179:
        return MEDIA_PLAY_PAUSE;
      case 180:
        return MEDIA_LAUNCH_MAIL;
      case 181:
        return MEDIA_LAUNCH_MEDIA_SELECT;
      case 182:
        return MEDIA_LAUNCH_APP1;
      case 183:
        return MEDIA_LAUNCH_APP2;
      case 186:
        return OEM_1;
      case 187:
        return OEM_PLUS;
      case 188:
        return OEM_COMMA;
      case 189:
        return OEM_MINUS;
      case 190:
        return OEM_PERIOD;
      case 191:
        return OEM_2;
      case 192:
        return OEM_3;
      case 219:
        return OEM_4;
      case 220:
        return OEM_5;
      case 221:
        return OEM_6;
      case 222:
        return OEM_7;
      case 223:
        return OEM_8;
      case 226:
        return OEM_102;
      case 229:
        return PROCESSKEY;
      case 231:
        return PACKET;
      case 243:
        return DBE_SBCSCHAR;
      case 244:
        return DBE_DBCSCHAR;
      case 246:
        return ATTN;
      case 247:
        return CRSEL;
      case 248:
        return EXSEL;
      case 249:
        return EREOF;
      case 250:
        return PLAY;
      case 251:
        return ZOOM;
      case 252:
        return NONAME;
      case 253:
        return PA1;
      case 254:
        return OEM_CLEAR;
      case 0:
        return UNKNOWN;
      case 225:
        return ALTGR;
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
      case BACK:
        return 'KeyboardCode.BACK';
      case TAB:
        return 'KeyboardCode.TAB';
      case CLEAR:
        return 'KeyboardCode.CLEAR';
      case RETURN:
        return 'KeyboardCode.RETURN';
      case SHIFT:
        return 'KeyboardCode.SHIFT';
      case CONTROL:
        return 'KeyboardCode.CONTROL';
      case MENU:
        return 'KeyboardCode.MENU';
      case PAUSE:
        return 'KeyboardCode.PAUSE';
      case CAPITAL:
        return 'KeyboardCode.CAPITAL';
      case KANA:
        return 'KeyboardCode.KANA';
      case HANGUL:
        return 'KeyboardCode.HANGUL';
      case JUNJA:
        return 'KeyboardCode.JUNJA';
      case FINAL:
        return 'KeyboardCode.FINAL';
      case HANJA:
        return 'KeyboardCode.HANJA';
      case KANJI:
        return 'KeyboardCode.KANJI';
      case ESCAPE:
        return 'KeyboardCode.ESCAPE';
      case CONVERT:
        return 'KeyboardCode.CONVERT';
      case NONCONVERT:
        return 'KeyboardCode.NONCONVERT';
      case ACCEPT:
        return 'KeyboardCode.ACCEPT';
      case MODECHANGE:
        return 'KeyboardCode.MODECHANGE';
      case SPACE:
        return 'KeyboardCode.SPACE';
      case PRIOR:
        return 'KeyboardCode.PRIOR';
      case NEXT:
        return 'KeyboardCode.NEXT';
      case END:
        return 'KeyboardCode.END';
      case HOME:
        return 'KeyboardCode.HOME';
      case LEFT:
        return 'KeyboardCode.LEFT';
      case UP:
        return 'KeyboardCode.UP';
      case RIGHT:
        return 'KeyboardCode.RIGHT';
      case DOWN:
        return 'KeyboardCode.DOWN';
      case SELECT:
        return 'KeyboardCode.SELECT';
      case PRINT:
        return 'KeyboardCode.PRINT';
      case EXECUTE:
        return 'KeyboardCode.EXECUTE';
      case SNAPSHOT:
        return 'KeyboardCode.SNAPSHOT';
      case INSERT:
        return 'KeyboardCode.INSERT';
      case DELETE:
        return 'KeyboardCode.DELETE';
      case HELP:
        return 'KeyboardCode.HELP';
      case NUM_0:
        return 'KeyboardCode.NUM_0';
      case NUM_1:
        return 'KeyboardCode.NUM_1';
      case NUM_2:
        return 'KeyboardCode.NUM_2';
      case NUM_3:
        return 'KeyboardCode.NUM_3';
      case NUM_4:
        return 'KeyboardCode.NUM_4';
      case NUM_5:
        return 'KeyboardCode.NUM_5';
      case NUM_6:
        return 'KeyboardCode.NUM_6';
      case NUM_7:
        return 'KeyboardCode.NUM_7';
      case NUM_8:
        return 'KeyboardCode.NUM_8';
      case NUM_9:
        return 'KeyboardCode.NUM_9';
      case A:
        return 'KeyboardCode.A';
      case B:
        return 'KeyboardCode.B';
      case C:
        return 'KeyboardCode.C';
      case D:
        return 'KeyboardCode.D';
      case E:
        return 'KeyboardCode.E';
      case F:
        return 'KeyboardCode.F';
      case G:
        return 'KeyboardCode.G';
      case H:
        return 'KeyboardCode.H';
      case I:
        return 'KeyboardCode.I';
      case J:
        return 'KeyboardCode.J';
      case K:
        return 'KeyboardCode.K';
      case L:
        return 'KeyboardCode.L';
      case M:
        return 'KeyboardCode.M';
      case N:
        return 'KeyboardCode.N';
      case O:
        return 'KeyboardCode.O';
      case P:
        return 'KeyboardCode.P';
      case Q:
        return 'KeyboardCode.Q';
      case R:
        return 'KeyboardCode.R';
      case S:
        return 'KeyboardCode.S';
      case T:
        return 'KeyboardCode.T';
      case U:
        return 'KeyboardCode.U';
      case V:
        return 'KeyboardCode.V';
      case W:
        return 'KeyboardCode.W';
      case X:
        return 'KeyboardCode.X';
      case Y:
        return 'KeyboardCode.Y';
      case Z:
        return 'KeyboardCode.Z';
      case LWIN:
        return 'KeyboardCode.LWIN';
      case COMMAND:
        return 'KeyboardCode.COMMAND';
      case RWIN:
        return 'KeyboardCode.RWIN';
      case APPS:
        return 'KeyboardCode.APPS';
      case SLEEP:
        return 'KeyboardCode.SLEEP';
      case NUMPAD0:
        return 'KeyboardCode.NUMPAD0';
      case NUMPAD1:
        return 'KeyboardCode.NUMPAD1';
      case NUMPAD2:
        return 'KeyboardCode.NUMPAD2';
      case NUMPAD3:
        return 'KeyboardCode.NUMPAD3';
      case NUMPAD4:
        return 'KeyboardCode.NUMPAD4';
      case NUMPAD5:
        return 'KeyboardCode.NUMPAD5';
      case NUMPAD6:
        return 'KeyboardCode.NUMPAD6';
      case NUMPAD7:
        return 'KeyboardCode.NUMPAD7';
      case NUMPAD8:
        return 'KeyboardCode.NUMPAD8';
      case NUMPAD9:
        return 'KeyboardCode.NUMPAD9';
      case MULTIPLY:
        return 'KeyboardCode.MULTIPLY';
      case ADD:
        return 'KeyboardCode.ADD';
      case SEPARATOR:
        return 'KeyboardCode.SEPARATOR';
      case SUBTRACT:
        return 'KeyboardCode.SUBTRACT';
      case DECIMAL:
        return 'KeyboardCode.DECIMAL';
      case DIVIDE:
        return 'KeyboardCode.DIVIDE';
      case F1:
        return 'KeyboardCode.F1';
      case F2:
        return 'KeyboardCode.F2';
      case F3:
        return 'KeyboardCode.F3';
      case F4:
        return 'KeyboardCode.F4';
      case F5:
        return 'KeyboardCode.F5';
      case F6:
        return 'KeyboardCode.F6';
      case F7:
        return 'KeyboardCode.F7';
      case F8:
        return 'KeyboardCode.F8';
      case F9:
        return 'KeyboardCode.F9';
      case F10:
        return 'KeyboardCode.F10';
      case F11:
        return 'KeyboardCode.F11';
      case F12:
        return 'KeyboardCode.F12';
      case F13:
        return 'KeyboardCode.F13';
      case F14:
        return 'KeyboardCode.F14';
      case F15:
        return 'KeyboardCode.F15';
      case F16:
        return 'KeyboardCode.F16';
      case F17:
        return 'KeyboardCode.F17';
      case F18:
        return 'KeyboardCode.F18';
      case F19:
        return 'KeyboardCode.F19';
      case F20:
        return 'KeyboardCode.F20';
      case F21:
        return 'KeyboardCode.F21';
      case F22:
        return 'KeyboardCode.F22';
      case F23:
        return 'KeyboardCode.F23';
      case F24:
        return 'KeyboardCode.F24';
      case NUMLOCK:
        return 'KeyboardCode.NUMLOCK';
      case SCROLL:
        return 'KeyboardCode.SCROLL';
      case LSHIFT:
        return 'KeyboardCode.LSHIFT';
      case RSHIFT:
        return 'KeyboardCode.RSHIFT';
      case LCONTROL:
        return 'KeyboardCode.LCONTROL';
      case RCONTROL:
        return 'KeyboardCode.RCONTROL';
      case LMENU:
        return 'KeyboardCode.LMENU';
      case RMENU:
        return 'KeyboardCode.RMENU';
      case BROWSER_BACK:
        return 'KeyboardCode.BROWSER_BACK';
      case BROWSER_FORWARD:
        return 'KeyboardCode.BROWSER_FORWARD';
      case BROWSER_REFRESH:
        return 'KeyboardCode.BROWSER_REFRESH';
      case BROWSER_STOP:
        return 'KeyboardCode.BROWSER_STOP';
      case BROWSER_SEARCH:
        return 'KeyboardCode.BROWSER_SEARCH';
      case BROWSER_FAVORITES:
        return 'KeyboardCode.BROWSER_FAVORITES';
      case BROWSER_HOME:
        return 'KeyboardCode.BROWSER_HOME';
      case VOLUME_MUTE:
        return 'KeyboardCode.VOLUME_MUTE';
      case VOLUME_DOWN:
        return 'KeyboardCode.VOLUME_DOWN';
      case VOLUME_UP:
        return 'KeyboardCode.VOLUME_UP';
      case MEDIA_NEXT_TRACK:
        return 'KeyboardCode.MEDIA_NEXT_TRACK';
      case MEDIA_PREV_TRACK:
        return 'KeyboardCode.MEDIA_PREV_TRACK';
      case MEDIA_STOP:
        return 'KeyboardCode.MEDIA_STOP';
      case MEDIA_PLAY_PAUSE:
        return 'KeyboardCode.MEDIA_PLAY_PAUSE';
      case MEDIA_LAUNCH_MAIL:
        return 'KeyboardCode.MEDIA_LAUNCH_MAIL';
      case MEDIA_LAUNCH_MEDIA_SELECT:
        return 'KeyboardCode.MEDIA_LAUNCH_MEDIA_SELECT';
      case MEDIA_LAUNCH_APP1:
        return 'KeyboardCode.MEDIA_LAUNCH_APP1';
      case MEDIA_LAUNCH_APP2:
        return 'KeyboardCode.MEDIA_LAUNCH_APP2';
      case OEM_1:
        return 'KeyboardCode.OEM_1';
      case OEM_PLUS:
        return 'KeyboardCode.OEM_PLUS';
      case OEM_COMMA:
        return 'KeyboardCode.OEM_COMMA';
      case OEM_MINUS:
        return 'KeyboardCode.OEM_MINUS';
      case OEM_PERIOD:
        return 'KeyboardCode.OEM_PERIOD';
      case OEM_2:
        return 'KeyboardCode.OEM_2';
      case OEM_3:
        return 'KeyboardCode.OEM_3';
      case OEM_4:
        return 'KeyboardCode.OEM_4';
      case OEM_5:
        return 'KeyboardCode.OEM_5';
      case OEM_6:
        return 'KeyboardCode.OEM_6';
      case OEM_7:
        return 'KeyboardCode.OEM_7';
      case OEM_8:
        return 'KeyboardCode.OEM_8';
      case OEM_102:
        return 'KeyboardCode.OEM_102';
      case PROCESSKEY:
        return 'KeyboardCode.PROCESSKEY';
      case PACKET:
        return 'KeyboardCode.PACKET';
      case DBE_SBCSCHAR:
        return 'KeyboardCode.DBE_SBCSCHAR';
      case DBE_DBCSCHAR:
        return 'KeyboardCode.DBE_DBCSCHAR';
      case ATTN:
        return 'KeyboardCode.ATTN';
      case CRSEL:
        return 'KeyboardCode.CRSEL';
      case EXSEL:
        return 'KeyboardCode.EXSEL';
      case EREOF:
        return 'KeyboardCode.EREOF';
      case PLAY:
        return 'KeyboardCode.PLAY';
      case ZOOM:
        return 'KeyboardCode.ZOOM';
      case NONAME:
        return 'KeyboardCode.NONAME';
      case PA1:
        return 'KeyboardCode.PA1';
      case OEM_CLEAR:
        return 'KeyboardCode.OEM_CLEAR';
      case UNKNOWN:
        return 'KeyboardCode.UNKNOWN';
      case ALTGR:
        return 'KeyboardCode.ALTGR';
    }
  }

  int toJson() => value;
}



