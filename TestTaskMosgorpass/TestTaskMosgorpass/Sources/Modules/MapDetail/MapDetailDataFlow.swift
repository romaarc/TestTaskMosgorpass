import Foundation

enum MapDetailLoad {
    enum Loading {
        struct Response {
            let result: Result<StationDetail, Error>
        }

        struct ViewModel {
            let data: ([StationDetailViewModel], [[TypeElement: Int]])
        }
        
        struct onError {}
    }
    
    enum StationDetailUpdate {
        struct Request {
            let data: StationViewModel
        }
    }
}
