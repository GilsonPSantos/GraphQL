import Foundation

protocol CoreBuilderProtocol {
    var graphQLNetwork: GraphQLNetworkProtocol { get }
}

final class CoreBuilder: CoreBuilderProtocol {
    let graphQLNetwork: GraphQLNetworkProtocol

    init(graphQLNetwork: GraphQLNetworkProtocol) {
        self.graphQLNetwork = graphQLNetwork
    }
}
