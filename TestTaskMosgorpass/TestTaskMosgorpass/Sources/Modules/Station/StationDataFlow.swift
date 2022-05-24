import Foundation

enum StationLoad {
    ///Show stations data
    enum Loading {
        struct Response {
            let result: Result<[Station], Error>
        }
        
        struct ViewModel {
            let data: ([StationViewModel], [[TypeElement: Int]])
        }
        
        struct onError {}
    }
    /// Update stations
    enum StationUpdate {
        struct Request {}
    }
    
    enum StationDetailFinding {
        struct Response {
            let result: Result<[StationDetailRM], Error>
        }
       
        struct ViewModel {
            let data: StationDetailRM
        }
        
        struct onError {}
    }
}
