import Foundation

protocol HomeServiceProtocol {
    func fetchData()
}

final class HomeService: HomeServiceProtocol {
    private let graphQLNetwork: GraphQLNetworkProtocol
    private let presenter: HomePresenterProtocol

    deinit {
        print("De init")
    }


    init(graphQLNetwork: GraphQLNetworkProtocol, presenter: HomePresenterProtocol){
        self.graphQLNetwork = graphQLNetwork
        self.presenter = presenter
    }

    // TODO: Start and stop loading and show error
    func fetchData()
    {
        graphQLNetwork.send(HomeRequest()).done { response in
            self.presenter.present(response)
        }.catch { error in
            print(error)
        }
    }
}
