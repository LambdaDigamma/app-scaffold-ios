import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(app_scaffold_iosTests.allTests),
    ]
}
#endif
