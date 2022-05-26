//
//  MapDetailProviderSpec.swift
//  TestTaskMosgorpassTests
//
//  Created by Roman Gorshkov on 25.05.2022.
//

import Quick
import Nimble
import PromiseKit
@testable import TestTaskMosgorpass

class MapDetailProviderSpec: QuickSpec {
    override func spec() {
        // MARK: - Subject Under Test (SUT) - объект под тестирование
        var sut: MapDetailProvider!

        // MARK: - Test Doubles
        var providerSpy: MapDetailProviderProtocolSpy!
        
        // MARK: - Tests
        beforeEach {
            setup()
        }

        afterEach {
            sut = nil
        }
        
        // MARK: Use Cases
        describe("Fetch data") {
            it("Should ask provider to fetch data from API") {
                ///given
                let id = "0072202b-5f34-4a7a-86bf-020e4795b7d7"
                ///when
                sut.fetchById(withID: id).done { _ in }.catch { _ in }
                ///then
                providerSpy.fetchById(withID: id).done { _ in }.catch { _ in }
            }
        }
        
        describe("Save object to Realm") {
            it("Should ask provider to save object using Realm") {
                ///given
                let response = StationDetail(id: "0072202b-5f34-4a7a-86bf-020e4795b7d7",
                                             name: "Курьяново",
                                             type: "bus",
                                             wifi: false,
                                             bench: nil,
                                             elevator: nil,
                                             photo: nil,
                                             commentTotalCount: 0,
                                             routePath: [RoutePath](),
                                             color: "#ffffff",
                                             routeNumber: "10",
                                             isFavorite: false,
                                             shareURL: "",
                                             lat: 55.649425,
                                             lon: 37.700874,
                                             cityShuttle: false,
                                             electrobus: false,
                                             transportTypes: [String](),
                                             routeName: nil,
                                             shuttleType: nil, regional: false)
                ///then
                providerSpy.saveIdToRealm(response)
            }
        }
        
        describe("Delete objects from Realm") {
            it("Should ask provider to remove all objects") {
                //then
                providerSpy.deleteObjects()
            }
        }
        
        // MARK: - Test Helpers
        func setup() {
            providerSpy = MapDetailProviderProtocolSpy()
            sut = MapDetailProvider(
                mosgorpassNetworkService: NetworkService(),
                stationDetailRealmService: RealmService()
            )
        }
    }
}
// MARK: - Test Doubles
extension MapDetailProviderSpec {
    class MapDetailProviderProtocolSpy: MapDetailProviderProtocol {
        func fetchById(withID id: String) -> Promise<StationDetail> {
            return Promise { seal in
                seal.fulfill(StationDetail(id: "0072202b-5f34-4a7a-86bf-020e4795b7d7",
                                           name: "Курьяново",
                                           type: "bus",
                                           wifi: false,
                                           bench: nil,
                                           elevator: nil,
                                           photo: nil,
                                           commentTotalCount: 0,
                                           routePath: [RoutePath](),
                                           color: "#ffffff",
                                           routeNumber: "10",
                                           isFavorite: false,
                                           shareURL: "",
                                           lat: 55.649425,
                                           lon: 37.700874,
                                           cityShuttle: false,
                                           electrobus: false,
                                           transportTypes: [String](),
                                           routeName: nil,
                                           shuttleType: nil, regional: false))
            }
        }
        
        func saveIdToRealm(_ model: StationDetail) {}
        func deleteObjects() {}
    }
}
