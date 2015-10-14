// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
//
// TokenStream is the interface between the lexer and the parser. The lexer
// creates a TokenStream which the parser consumes.

package lexer

type TokenStream interface {
	// Returns the next Token in the stream without advancing the cursor,
	// or returns the EOF token if the cursor is already past the end.
	PeekNext() Token

	// Advances the cursor in the stream or does nothing if the cursor is
	// already past the end of the stream
	ConsumeNext()
}

// The EOF token is returned by TokenStream to signal the end of the stream.
var eofToken = Token{Kind: EOF}

// *TokenChan implements TokenStream.
// This implementation uses a non-buffered channel to pass the tokens from the
// lexer to the parser. One end of the channel is held by the lexer and the
// other is in the TokenChan object that is passed to the parser.
type TokenChan struct {
	tokenChan chan Token
	nextToken Token
	// read is true if a token has been read out of the channel into nextToken.
	read bool
}

// See TokenStream.
func (s *TokenChan) PeekNext() (token Token) {
	if !s.read {
		s.read = true
		s.ConsumeNext()
	}

	return s.nextToken
}

// See TokenStream.
func (s *TokenChan) ConsumeNext() {
	if t, open := <-s.tokenChan; open {
		s.nextToken = t
	} else {
		s.nextToken = eofToken
	}
}
