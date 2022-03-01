import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(messari_challenge_r28Tests.allTests),
    ]
}
#endif
