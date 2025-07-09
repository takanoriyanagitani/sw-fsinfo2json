import ArgumentParser
import Foundation

import struct FsInfoToJson.FileSystemInfo
import func FsInfoToJson.getFileSystemInfo

@main
struct FsInfoToJsonCli: ParsableCommand {
  @Argument(help: "The path to the file or directory.")
  var path: String?  // get this from env or arg

  mutating func run() throws {
    let path2fileOrDir: String
    if let argPath = path {
      path2fileOrDir = argPath
    } else if let envPath = ProcessInfo.processInfo.environment["FSINFO_PATH"] {
      path2fileOrDir = envPath
    } else {
      path2fileOrDir = "."
    }

    let ofsinfo: FileSystemInfo? = getFileSystemInfo(path: path2fileOrDir)
    guard let fsinfo = ofsinfo else {
      print("Failed to get file system info for path: \(path2fileOrDir)")
      return
    }

    guard let jsonString = try? fsinfo.toJsonString().get() else {
      print("Error converting to JSON")
      return
    }
    print(jsonString)
  }
}
