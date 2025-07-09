import Foundation

public struct FileSystemInfo: Codable, Equatable {
  public let blockSize: UInt32
  public let ioSize: Int32
  public let totalBlocks: UInt64
  public let freeBlocks: UInt64
  public let availableBlocks: UInt64
  public let totalFiles: UInt64
  public let freeFiles: UInt64

  public func toJson(
    encoder: JSONEncoder = JSONEncoder()
  ) -> Result<Data, Error> {
    Result { try encoder.encode(self) }
  }

  public func toJsonString(
    encoder: JSONEncoder = JSONEncoder()
  ) -> Result<String, Error> {
    toJson(encoder: encoder).flatMap { data in
      guard let jsonString = String(data: data, encoding: .utf8) else {
        return .failure(
          EncodingError.invalidValue(
            data,
            .init(
              codingPath: [],
              debugDescription: "Could not convert Data to String",
            ),
          ),
        )
      }
      return .success(jsonString)
    }
  }
}

public func getFileSystemInfo(path: String) -> FileSystemInfo? {
  var stat: statfs = statfs()
  guard statfs(path, &stat) == 0 else { return nil }

  return FileSystemInfo(
    blockSize: stat.f_bsize,
    ioSize: stat.f_iosize,
    totalBlocks: stat.f_blocks,
    freeBlocks: stat.f_bfree,
    availableBlocks: stat.f_bavail,
    totalFiles: stat.f_files,
    freeFiles: stat.f_ffree
  )
}
