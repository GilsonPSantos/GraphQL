import Foundation
import Apollo
import PromiseKit

protocol GraphQLNetworkProtocol {
    func send<T>(_ resource: T) -> Promise<T.Value> where T: GraphQLRequestProtocol
}

final class GraphQLNetwork: GraphQLNetworkProtocol {
    private let apolloClient: ApolloClientProtocol
    private let configuration: GraphQLNetworkConfigurationProtocol

    static let shared: GraphQLNetworkProtocol = GraphQLNetwork()

    private init(configuration: GraphQLNetworkConfigurationProtocol = GraphQLNetworkConfiguration()) {
        self.configuration = configuration
        self.apolloClient = configuration.createClient(with: [GraphQLNetworkInterceptor()])
    }

    func send<T>(_ resource: T) -> Promise<T.Value> where T : GraphQLRequestProtocol {
        setupAditionalHeadersIfNeeded(resource)
        return sendRequest(resource)
    }

    private func setupAditionalHeadersIfNeeded<T: GraphQLRequestProtocol>(_ resource: T) {
        configuration.setAditionalHeaders(resource.headers)
    }

    private func sendRequest<T>(_ resource: T) -> Promise<T.Value> where T : GraphQLRequestProtocol {
        return Promise<T.Query.Data> { seal in
            let query = T.Query()
                _ = apolloClient.send(query: query) { result in
                    guard let data = try? result.get().data else {
                        seal.reject(NetworkError.invalidData)
                        return
                    }
                    seal.fulfill(data)
                }
        }.then { data -> Promise<T.Value> in
            do {
                let value = try resource.serialize(data: data)
                return Promise<T.Value>.value(value)
            } catch {
                throw error
            }
        }
    }
}
