import Foundation
import Apollo

protocol GraphQLNetworkConfigurationProtocol {
    func createClient(with interceptors: [GraphQLNetworkInterceptorProtocol]) -> ApolloClientProtocol
    func setAditionalHeaders(_ headers: [String : String])
}

final class GraphQLNetworkConfiguration: GraphQLNetworkConfigurationProtocol {
    private var interceptorDataProvider: GraphQLNetworkInterceptorProviderProtocol?

    init(interceptorDataProvider: GraphQLNetworkInterceptorProviderProtocol? = nil) {
        self.interceptorDataProvider = interceptorDataProvider
    }

    // TODO: - create a EnvConfig for url
    func createClient(with interceptors: [GraphQLNetworkInterceptorProtocol]) -> ApolloClientProtocol {
//        return ApolloClient(url: URL(string: "https://apollo-fullstack-tutorial.herokuapp.com/graphql")!)
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        let urlSessionClient = URLSessionClient()
        let provider = GraphQLNetworkInterceptorProvider(client: urlSessionClient, store: store)
        self.interceptorDataProvider = provider
        interceptorDataProvider?.setup(interceptors)
        let url = URL(string: "https://apollo-fullstack-tutorial.herokuapp.com/graphql")!

        let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider,
                                                                 endpointURL: url)
        return ApolloClient(networkTransport: requestChainTransport,
                            store: store)
    }

    func setAditionalHeaders(_ headers: [String : String]) {
        interceptorDataProvider?.setAditionalHeaders(headers)
    }
}
