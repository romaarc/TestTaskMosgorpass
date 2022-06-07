import Foundation

enum MapDetailLoad {
    enum Loading {
        struct Response {
            let result: Result<StationDetail, Error>
        }

        struct ViewModel {
            let data: ([StationDetailViewModel], [[TypeElement: Int]])
        }
        
        struct OnError {}
    }
    
    enum StationDetailUpdate {
        struct Request {
            let data: StationViewModel
        }
    }
}
