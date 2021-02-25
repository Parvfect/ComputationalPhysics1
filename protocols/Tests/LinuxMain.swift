import XCTest

import protocolsTests

var tests = [XCTestCaseEntry]()
tests += protocolsTests.allTests()
XCTMain(tests)
