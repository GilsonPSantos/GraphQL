import Foundation

struct HomeResponse: Decodable {
    struct Launch: Decodable {
        struct Element: Decodable {
            let id: String
            let site: String
            let isBooked: Bool
        }

        let cursor: String
        let hasMore: Bool
        let launches: [Element]
    }

    let launches: Launch
}
