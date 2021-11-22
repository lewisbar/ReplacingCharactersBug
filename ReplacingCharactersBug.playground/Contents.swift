import Foundation

/*
 Summary: Although the two strings are equal (==),
 the one that has been modified by replacingCharacters(in:with:) leads to a crash,
 while the one modified by insert(_:at:) works as expected.
 */

// Create two identical strings containing an emoji
var string1 = "012🙂3"
var string2 = "012🙂3"

// The emoji has a utf16 count of 2
print(string1.utf16.count)  // prints "6"
print(string2.utf16.count)  // prints "6"

// Create an empty range as an insertion point at the end of each string
var string1EndRange = string1.endIndex..<string1.endIndex
var string2EndRange = string2.endIndex..<string2.endIndex

// Here it works as expected
print(string1[..<string1EndRange.lowerBound])  // prints "012🙂3"
print(string2[..<string2EndRange.lowerBound])  // prints "012🙂3"

// Use two different methods to add a character to the string
string1.insert("4", at: string1EndRange.lowerBound)
string2 = string2.replacingCharacters(in: string2EndRange, with: "4")

// The two strings seem to be exactly equal
print(string1)  // prints "012🙂34"
print(string2)  // prints "012🙂34"
print(string1.utf16.count)  // prints "7"
print(string2.utf16.count)  // prints "7"
print(string1 == string2)  // prints "true"

// This would prevent the crash
// string2 = string1

// They are not equal after all. How is that possible?
print(string1[..<string1EndRange.lowerBound])  // prints "012🙂3"
print(string2[..<string2EndRange.lowerBound])  // "Swift/StringRangeReplaceableCollection.swift:308: Fatal error: String index range is out of bounds"
