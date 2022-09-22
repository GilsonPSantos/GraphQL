import Foundation
import Apollo

protocol GraphQLNetworkInterceptorProviderProtocol {
    func setup(_ interceptors: [BaseInterceptorProtocol])
    func setAditionalHeaders(_ headers: [String : String])
}

final class GraphQLNetworkInterceptorProvider: DefaultInterceptorProvider, GraphQLNetworkInterceptorProviderProtocol {
    var interceptors: [BaseInterceptorProtocol] = []

    func setup(_ interceptors: [BaseInterceptorProtocol]) {
        self.interceptors = interceptors
    }

    func setAditionalHeaders(_ headers: [String : String]) {
        guard let interceptor = interceptors.first(where: { $0 is GraphQLNetworkInterceptorProtocol}) as? GraphQLNetworkInterceptorProtocol else {
            return
        }
        interceptor.setAditionalHeaders(headers)
    }
    
    override func interceptors<Operation>(for operation: Operation) -> [ApolloInterceptor] where Operation : GraphQLOperation {
        addInterceptorsIfNeeded(for: operation)
    }

    private func addInterceptorsIfNeeded<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
        var interceptors = super.interceptors(for: operation)
        self.interceptors.enumerated().forEach {
            interceptors.insert($0.element, at: $0.offset)
        }
        return interceptors
    }
}
