import XCTest
@testable import GraphQL

final class HomeCoordinatorTests: XCTestCase {
    private lazy var coordinator = HomeCoordinator(graphQLNetwork: GraphQLNetworkProtocol)
}
