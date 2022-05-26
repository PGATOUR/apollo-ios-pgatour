import Foundation
import ArgumentParser
import ApolloCodegenLib

struct Validate: ParsableCommand {

  // MARK: - Configuration
  
  static var configuration = CommandConfiguration(
    abstract: "Validate a configuration file or JSON formatted string."
  )

  @Option(
    name: .shortAndLong,
    help: "Path to a configuration file."
  )
  var path: String?

  @Option(
    name: .shortAndLong,
    help: "Configuration string in JSON format."
  )
  var json: String?

  // MARK: - Implementation

  func validate() throws {
    if path == nil && json == nil {
      throw ValidationError("You must specify at least one valid option.")
    }
  }
  
  func run() throws {
    if let path = path {
      try validate(path: path)
    }

    if let json = json {
      try validate(json: json)
    }
  }

  func validate(path: String) throws {
    try validate(data: try String(contentsOfFile: path).asData())

    print("The configuration file is valid.")
  }

  func validate(json: String) throws {
    try validate(data: try json.asData())

    print("The configuration string is valid.")
  }

  private func validate(data: Data) throws {
    let configuration = try JSONDecoder().decode(ApolloCodegenConfiguration.self, from: data)

    try configuration.validate()
  }
}
