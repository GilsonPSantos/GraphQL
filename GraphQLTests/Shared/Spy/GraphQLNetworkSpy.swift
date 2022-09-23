import Foundation
import PromiseKit
@testable import GraphQL

final class GraphQLNetworkSpy: GraphQLNetworkProtocol {

    func send<T>(_ resource: T) -> Promise<T.Value> where T : GraphQLRequestProtocol {
        <#code#>
    }
}
