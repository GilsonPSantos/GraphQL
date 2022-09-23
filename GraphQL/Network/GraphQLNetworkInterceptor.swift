import Foundation
import Apollo

protocol BaseInterceptorProtocol: ApolloInterceptor {}

protocol GraphQLNetworkInterceptorProtocol: BaseInterceptorProtocol {
    func setAditionalHeaders(_ headers: [String : String])
}

final class GraphQLNetworkInterceptor: GraphQLNetworkInterceptorProtocol {
    private var aditionalHeaders: [String : String] = [:]

    func setAditionalHeaders(_ headers: [String : String]) {
        aditionalHeaders = headers
    }

    func interceptAsync<Operation>(chain: RequestChain,
                                   request: HTTPRequest<Operation>,
                                   response: HTTPResponse<Operation>?,
                                   completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) where Operation : GraphQLOperation {
        request.addHeader(name: "Authorization", value: "token")
        setupAditionalHeaders(in: request)
        chain.proceedAsync(request: request, response: response, completion: completion)
    }

    private func setupAditionalHeaders<Operation>(in request: HTTPRequest<Operation>) {
        request.additionalHeaders = request.additionalHeaders.merging(aditionalHeaders) { _, new -> String in new }
    }
}
