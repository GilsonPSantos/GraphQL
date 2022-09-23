import UIKit

protocol HomeViewControllerProtocol where Self: UIViewController {
    func render(_ viewModel: HomeViewModel)
}

class HomeViewController: UIViewController {

    private let service: HomeServiceProtocol
    private let customView: HomeViewProtocol
    private var rowsViewModel: [HomeViewModel.Row] = []

    deinit {
        print("De init")
    }

    init(service: HomeServiceProtocol,
         customView: HomeViewProtocol)
    {
        self.service = service
        self.customView = customView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError()
    }

    override func loadView()
    {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        service.fetchData()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsViewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = rowsViewModel[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel?.text = element.id
        cell.detailTextLabel?.text = element.site
        return cell
    }
}

extension HomeViewController: HomeViewControllerProtocol {
    func render(_ viewModel: HomeViewModel) {
        self.rowsViewModel = viewModel.rows
        customView.render(title: viewModel.title)
        customView.reloadData()
    }
}
