import XCTest
import SwiftSequence

class PermutationsTests: XCTestCase {
  
  var allTests : [(String, () -> ())] {
    return [
      ("testLexPermsClosure", testLexPermsClosure),
      ("testLexPerms", testLexPerms),
      ("testPermsInds", testPermsInds),
      ("testLazyLexPermsClosure", testLazyLexPermsClosure),
      ("testLazyLexPerms", testLazyLexPerms),
      ("testLazyPermsInds", testLazyPermsInds),
      ("testCounts", testCounts)
    ]
  }
  
  // MARK: Eager
  
  func testLexPermsClosure() {
    
    let forward = [1, 2, 3].lexPermutations(<)
    
    let fExpectation = [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]
    
    XCTAssert(forward == fExpectation)
    
    let backward = [1, 2, 3].lexPermutations(>)
    
    let bExpectation = [[1, 2, 3]]
    
    XCTAssertEqual(backward, bExpectation)
    
  }
  
  func testLexPerms() {
    
    let forward = [1, 2, 3].lexPermutations()
    
    let fExpectation = [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]
    
    XCTAssert(forward == fExpectation)
    
    let backward = [3, 2, 1].lexPermutations()
    
    let bExpectation = [[3, 2, 1]]
    
    XCTAssertEqual(backward, bExpectation)
    
  }
  
  func testPermsInds() {
    
    let perms = [1, 2, 3].permutations()
    
    let expectation = [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]
    
    XCTAssertEqual(perms, expectation)
    
  }
  
  // MARK: Lazy
  
  func testLazyLexPermsClosure() {
    
    let forward = [1, 2, 3].lazyLexPermutations(<)
    
    let fExpectation = [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]
    
    XCTAssertEqualNested(forward, fExpectation)
    
    let backward = [1, 2, 3].lazyLexPermutations(>)
    
    let bExpectation = [[1, 2, 3]]
    
    XCTAssertEqualNested(backward, bExpectation)

    
  }
  
  func testLazyLexPerms() {
    
    let forward = [1, 2, 3].lazyLexPermutations()
    
    let fExpectation = [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]
    
    XCTAssertEqualNested(forward, fExpectation)
    
    let backward = [3, 2, 1].lazyLexPermutations()
    
    let bExpectation = [[3, 2, 1]]
    
    XCTAssertEqualNested(backward, bExpectation)

    
  }
  
  func testLazyPermsInds() {
    
    let perms = [1, 2, 3].lazyPermutations()
    
    let expectation = [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]
    
    XCTAssertEqualNested(perms, expectation)
    
  }
  
  func nk(n: Int, _ k: Int) -> Int {
    let num = n.fac
    let den = (n - k).fac
    return num / den
  }
  
  func testCounts() {
    
    for randAr in (1...5).map(Array<Character>.init).map(Set.init) {
      for i in (0..<randAr.count).map ({ n in n.successor() }) {
        let perms = randAr.permutations(i)
        let settd = Set(perms.map { cs in cs.map { c in String(c) }.joinWithSeparator("") })
        XCTAssertEqual(perms.count, settd.count)
        XCTAssertEqual(nk(randAr.count, i), perms.count)
      }
    }
  }
}