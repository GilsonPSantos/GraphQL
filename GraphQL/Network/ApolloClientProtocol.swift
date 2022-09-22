import Foundation
import Apollo

public protocol ApolloClientProtocol {
    func send<Query: GraphQLQuery>(query: Query, resultHandler: GraphQLResultHandler<Query.Data>?) -> Cancellable
}


extension ApolloClient: ApolloClientProtocol {
    public func send<Query: GraphQLQuery>(query: Query, resultHandler: GraphQLResultHandler<Query.Data>?) -> Cancellable {
        fetch(query: query, resultHandler: resultHandler)
    }
}
