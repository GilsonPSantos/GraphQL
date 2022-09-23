import Foundation

protocol HomePresenterProtocol {
    func present(_ response: HomeResponse)
}

final class HomePresenter: HomePresenterProtocol {
    weak var viewController: HomeViewControllerProtocol?

    deinit {
        print("De init")
    }

    func present(_ response: HomeResponse) {
        let viewModel = createViewModel(response)
        viewController?.render(viewModel)
    }

    private func createViewModel(_ response: HomeResponse) -> HomeViewModel {
        let rows = response.launches.launches.map { HomeViewModel.Row(id: $0.id, site: $0.site) }
        return .init(title: "Exemplo de request GraphQL", rows: rows)
    }
}
