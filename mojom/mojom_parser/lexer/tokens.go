// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
//
// TokenKinds is a type which describes the kinds of tokens which can be
// encountered in a mojom file.

package lexer

import (
	"fmt"
)

type TokenKind int

// TokenKinds
const (
	// An error of an unknown nature has occured.
	ErrorUnknown TokenKind = iota
	// A character was found which is not part of a valid token.
	ErrorIllegalChar
	// A quoted string was opened but not closed.
	ErrorUnterminatedStringLiteral
	// A multiline comment was opened but not closed.
	ErrorUnterminatedComment
	// Indicates the end of a stream of tokens.
	EOF

	// Punctuators and Separators
	LParen
	RParen
	LBracket
	RBracket
	LBrace
	RBrace
	LAngle
	RAngle
	Semi
	Comma
	Dot
	Minus
	Plus
	Amp
	Qstn
	Equals
	Response

	// Names
	Name

	// Keywords
	Import
	Module
	Struct
	Union
	Interface
	Enum
	Const
	True
	False
	Default

	// Constants
	IntConstDec
	IntConstHex
	FloatConst
	Ordinal
	StringLiteral
)

// This method is used to generate user-facing strings in compilation error
// messages. For example for LBrace we produce the string "'{'". Notice the
// single-quotes. This will be used for example in an error message that looks
// like the following:
// Unexpected token at line 5, column 6: '###'. Expecting '{'.
func (tokenKind TokenKind) String() string {
	switch tokenKind {
	// Errors
	case ErrorUnknown:
		return "unknown token"
	case ErrorIllegalChar:
		return "illegal token"
	case ErrorUnterminatedStringLiteral:
		return "unterminated string literal"
	case ErrorUnterminatedComment:
		return "unterminated comment"

	// End of file
	case EOF:
		return "eof"

	// Punctuators and Separators
	case LParen:
		return "'('"
	case RParen:
		return "')'"
	case LBracket:
		return "'['"
	case RBracket:
		return "']'"
	case LBrace:
		return "'{'"
	case RBrace:
		return "'}'"
	case LAngle:
		return "'<'"
	case RAngle:
		return "'>'"
	case Semi:
		return "';'"
	case Comma:
		return "','"
	case Dot:
		return "'.'"
	case Minus:
		return "'-'"
	case Plus:
		return "'+'"
	case Amp:
		return "'&'"
	case Qstn:
		return "'?'"
	case Equals:
		return "'='"
	case Response:
		return "'=>'"

	// Names
	case Name:
		return "a name"

	// Keywords
	case Import:
		return "'import'"
	case Module:
		return "'module'"
	case Struct:
		return "'struct'"
	case Union:
		return "'union'"
	case Interface:
		return "'interface'"
	case Enum:
		return "'enum'"
	case Const:
		return "'const'"
	case True:
		return "'true'"
	case False:
		return "'false'"
	case Default:
		return "'default'"

	// Constants
	case IntConstDec:
		return "decimal integer literal"
	case IntConstHex:
		return "hex integer literal"
	case FloatConst:
		return "float literal"
	case Ordinal:
		return "an ordinal"
	case StringLiteral:
		return "a string literal"

	default:
		// Note(rudominer) It is important to use %d below so as to avoid
		// re-invoking this method and causing an infinite recursion.
		return fmt.Sprintf("%d", tokenKind)
	}
}

type Token struct {
	Kind TokenKind
	Text string
	// CharPos is the number of runes preceeding the token.
	CharPos int
	// LineNo is the line on which the token is found. (First line is 0.)
	LineNo int
	// LinePost is the number of runes preceeding the token on its line.
	LinePos int
}

// ShortLocationString is used to generate user-facing strings in compilation
// error messages. This will be used for example in an error message that looks
// like the following:
// Unexpected token at line 5, column 6: '###'. Expecting '{'.
func (t Token) ShortLocationString() string {
	return fmt.Sprintf("%d,%d", t.LineNo+1, t.LinePos+1)
}

func (t Token) LongLocationString() string {
	return fmt.Sprintf("line %d, column %d", t.LineNo+1, t.LinePos+1)
}

// EOF returns true if the token on which it is called represents the end of the
// token string.
func (t Token) EOF() bool {
	return t.Kind == EOF
}

// String is used to generate user-facing strings in compilation error
// messages. For many token kinds the TokenKind.String() method will produce
// good results for representing the token. But for other TokenKinds we will
// want to include some information besides a representation of the kind.
// For example for an ErrorUnknown kind we wnat to show the text.
// This will be used for example in an error message that looks
// like the following:
// Unexpected token at line 5, column 6: '###'. Expecting '{'.
func (token Token) String() string {
	switch token.Kind {
	case ErrorUnknown, Name, StringLiteral, IntConstDec, IntConstHex, FloatConst, Ordinal:
		return fmt.Sprintf("'%s'", token.Text)

	default:
		return token.Kind.String()
	}
}
