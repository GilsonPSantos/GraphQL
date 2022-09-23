import UIKit

protocol HomeViewProtocol where Self: UIView {
    func setup(delegate: HomeViewDelegate)
    func render(title: String)
    func reloadData()
}

typealias HomeViewDelegate = UITableViewDataSource

final class HomeView: UIView, HomeViewProtocol {

    deinit {
        print("De init")
    }
    static func make() -> HomeViewProtocol
    {
        return HomeView(tableView: tableView())
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private static func tableView() -> UITableView
    {
        let tableView = UITableView(frame: .zero)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        tableView.backgroundColor = .red
        return tableView
    }

    private let tableView: UITableView

    init(frame: CGRect = .zero,
         tableView: UITableView)
    {
        self.tableView = tableView
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError()
    }

    private func setup()
    {
        backgroundColor = .white
        setupTitleLabel()
        setupTableView()
    }

    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
    }

    private func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    func setup(delegate: HomeViewDelegate) {
        tableView.dataSource = delegate
    }

    func render(title: String) {
        titleLabel.text = title
    }

    func reloadData()
    {
        tableView.reloadData()
    }
}
