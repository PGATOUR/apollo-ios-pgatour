import Foundation
import ApolloAPI

open class MockMutableSelectionSet: MutableRootSelectionSet {
  open class var schema: SchemaConfiguration.Type { MockSchemaConfiguration.self }
  open class var selections: [Selection] { [] }
  open class var __parentType: ParentType { .Object(Object.self) }

  public var data: DataDict = DataDict([:], variables: nil)

  public required init(data: DataDict) {
    self.data = data
  }

  public subscript<T: AnyScalarType>(dynamicMember key: String) -> T? {
    get { data[key] }
    set { data._data[key] = newValue }
  }

  public subscript<T: MockSelectionSet>(dynamicMember key: String) -> T? {
    get { data[key] }
    set { data._data[key] = newValue }
  }
}

open class MockLocalCacheMutation<SelectionSet: MutableRootSelectionSet>: LocalCacheMutation {
  public typealias Data = SelectionSet

  open var variables: GraphQLOperation.Variables?

  public init() {}

}
