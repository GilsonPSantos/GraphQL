import UIKit

protocol HomeCoordinatorProtocol {
    func start() -> UIViewController
}

// TODO: Complete Coordinator
final class HomeCoordinator: HomeCoordinatorProtocol {
    private let graphQLNetwork: GraphQLNetworkProtocol

    deinit {
        print("De init")
    }

    init(graphQLNetwork: GraphQLNetworkProtocol) {
        self.graphQLNetwork = graphQLNetwork
    }

    func start() -> UIViewController {
        let presenter = HomePresenter()
        let service = HomeService(graphQLNetwork: graphQLNetwork, presenter: presenter)
        let view = HomeView.make()
        let viewController = HomeViewController(service: service, customView: view)
        presenter.viewController = viewController
        view.setup(delegate: viewController)
        return viewController
    }
}
