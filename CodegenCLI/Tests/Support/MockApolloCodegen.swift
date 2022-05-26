import Foundation
import apollo_ios_codegen
import ApolloCodegenLib
import Nimble

class MockApolloCodegen: CodegenProvider {
  static var buildHandler: ((ApolloCodegenConfiguration) throws -> Void)? = nil

  static func build(with configuration: ApolloCodegenConfiguration) throws {
    guard let handler = buildHandler else {
      fail("You must set buildHandler before calling \(#function)!")
      return
    }

    defer {
      buildHandler = nil
    }

    try handler(configuration)
  }
}
