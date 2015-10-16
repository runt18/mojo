// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/*
 This file contains the main() for the Mojom parser binary. This tool parses
 a set of .mojom files and emits a serialized MojomFileGraph struct. See
 mojom_files.mojom for the definition of MojomFileGraph.

 The tool is invoked as follows:

     mojom_parser [-I <include_dirs>] [-out <out_file>] [-debug] <mojom_file>...

 <include_dirs> is comma-separated list of directory paths to search for mojom imports.
 <out_file> is the path to the output file. If not given the output will be written to standard out.
 <mojom_file>... is one or more paths to  .mojom files to be parsed.

 If there are no errors then the program returns status zero and writes nothing
 to standard error and writes nothing to standard out except possibly the output
 if <out_file> is not specified. If there are any errors then the program returns
 status code 1 and writes error messages to standard error.

 If -debug is specified then the program emits lots of debugging data to
 standard out, including a depiction of the parse trees. If also <out_file> is
 not specified then the actual output is written at the end after the debugging
 data.
*/

package main

import (
	"bufio"
	"flag"
	"fmt"
	"io/ioutil"
	"mojom/mojom_parser/mojom"
	"mojom/mojom_parser/parser"
	"mojom/mojom_parser/serialization"
	"os"
	"path/filepath"
	"strings"
)

// DirectoryList holds the result of parsing a command-line flag
// that accepts a comma-separated list of directory paths. This
// type satisfies the flag.Value interface.
type DirectoryList []string

func (dl *DirectoryList) String() string {
	return fmt.Sprintf("%v", *dl)
}

func (dl *DirectoryList) Set(args string) error {
	for _, name := range strings.Split(args, ",") {
		info, err := os.Stat(name)
		if err != nil {
			return err
		}
		if !info.IsDir() {
			return fmt.Errorf("%s is not a directory.", name)
		}
		*dl = append(*dl, name)
	}
	return nil
}

var directoryListFlag DirectoryList

func init() {
	flag.Var(&directoryListFlag, "I", "comma-separated list of directory paths to search for mojom imports")
}

func main() {
	outFile := flag.String("out", "", "The path to the output file. If not present the output will "+
		"be written to standard out.")
	debug := flag.Bool("debug", false, "Generate debug data including the parse tree and print it to standard out.")
	flag.Parse()

	fileNames := flag.Args()
	if len(fileNames) == 0 {
		ErrorExit(fmt.Sprintf("No .mojom files given.\n"+
			"Usage: %s [-I <include_dirs>] [-out <out_file>] [-debug] <mojom_file>...",
			filepath.Base(os.Args[0])))
	}

	parseDriver := parser.NewDriver(directoryListFlag, *debug)

	// Do the parsing
	descriptor, err := parseDriver.ParseFiles(fileNames)
	if err != nil {
		ErrorExit(fmt.Sprintf("%s", err.Error()))
	} else if *debug {
		fmt.Println("Parsing complete.")
	}

	// Serialize the result.
	bytes, err := serialization.Serialize(descriptor)
	if err != nil {
		ErrorExit(fmt.Sprintf("Serialization error: %s", err))
	}

	// In debug mode print out the debug information.
	if *debug {
		PrintDebugOutput(bytes, descriptor)
	}

	// Emit the output to a file or standard out.
	if len(*outFile) == 0 {
		w := bufio.NewWriter(os.Stdout)
		if _, err := w.Write(bytes); err != nil {
			ErrorExit(fmt.Sprintf("Error writing output to standard out: %s.", *outFile, err.Error()))
		}
		w.Flush()
	} else {
		if err := ioutil.WriteFile(*outFile, bytes, os.ModePerm); err != nil {
			ErrorExit(fmt.Sprintf("Error writing output to %s: %s.", *outFile, err.Error()))
		} else {
			if *debug {
				fmt.Printf("The output was written to %s.\n", *outFile)
			}
		}
	}
}

func ErrorExit(message string) {
	fmt.Fprintf(os.Stderr, "%s\n", message)
	os.Exit(1)
}

func PrintDebugOutput(bytes []byte, descriptor *mojom.MojomDescriptor) {
	fmt.Println("\n\n=============================================")
	fmt.Println("\n Debug Serialized Output:")
	if bytes == nil {
		fmt.Println("bytes == nil")
	} else {
		fmt.Printf("len(bytes)=%d\n", len(bytes))
		for _, b := range bytes {
			fmt.Printf("%X ", b)
		}
	}
	fmt.Println("\n\n=============================================")
	fmt.Println("\n Pre-Serialized Go Object:")
	fmt.Printf("\n%s\n", descriptor.String())
}
