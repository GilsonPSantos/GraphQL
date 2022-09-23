import Foundation

final class AppConfiguration {
    let coreBuilder: CoreBuilderProtocol

    convenience init() {
        let graphQLNetwork = GraphQLNetwork()
        let coreBuilder = CoreBuilder(graphQLNetwork: graphQLNetwork)
        self.init(coreBuilder: coreBuilder)
    }

    init(coreBuilder: CoreBuilderProtocol) {
        self.coreBuilder = coreBuilder
    }
}
