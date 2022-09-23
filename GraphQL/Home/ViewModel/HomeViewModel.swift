import Foundation

struct HomeViewModel {
    struct Row {
        let id: String
        let site: String
    }
    let title: String
    let rows: [Row]
}
