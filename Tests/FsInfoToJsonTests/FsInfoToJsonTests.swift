import XCTest

@testable import FsInfoToJson

final class FsInfoToJsonTests: XCTestCase {
  func testGetFileSystemInfo() {
    // Test with a valid path
    if let fsInfo = getFileSystemInfo(path: "/") {
      XCTAssertNotNil(fsInfo)
      XCTAssertGreaterThan(fsInfo.totalBlocks, 0)
    } else {
      XCTFail("Failed to get file system info for root path")
    }

    // Test with an invalid path
    XCTAssertNil(getFileSystemInfo(path: "/non_existent_path"))
  }

  func testToJson() {
    let fsInfo = FileSystemInfo(
      blockSize: 4096,
      ioSize: 4096,
      totalBlocks: 1000,
      freeBlocks: 500,
      availableBlocks: 400,
      totalFiles: 100,
      freeFiles: 50
    )

    switch fsInfo.toJson() {
    case .success(let jsonData):
      do {
        let decodedFsInfo = try JSONDecoder().decode(FileSystemInfo.self, from: jsonData)
        XCTAssertEqual(fsInfo, decodedFsInfo)
      } catch {
        XCTFail("Failed to decode JSON: \(error)")
      }
    case .failure(let error):
      XCTFail("Failed to convert to JSON: \(error)")
    }
  }

  func testToJsonString() {
    let fsInfo = FileSystemInfo(
      blockSize: 4096,
      ioSize: 4096,
      totalBlocks: 1000,
      freeBlocks: 500,
      availableBlocks: 400,
      totalFiles: 100,
      freeFiles: 50
    )

    switch fsInfo.toJsonString() {
    case .success(let jsonString):
      XCTAssertTrue(jsonString.contains("\"blockSize\":4096"))
      XCTAssertTrue(jsonString.contains("\"ioSize\":4096"))
      XCTAssertTrue(jsonString.contains("\"totalBlocks\":1000"))
    case .failure(let error):
      XCTFail("Failed to convert to JSON string: \(error)")
    }
  }
}
