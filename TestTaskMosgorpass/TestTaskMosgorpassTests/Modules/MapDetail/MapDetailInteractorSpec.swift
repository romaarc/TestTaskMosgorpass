//
//  MapDetailInteractorSpec.swift
//  TestTaskMosgorpassTests
//
//  Created by Roman Gorshkov on 25.05.2022.
//

import Quick
import Nimble
import PromiseKit
@testable import TestTaskMosgorpass

class MapDetailInteractorSpec: QuickSpec {
    override func spec() {
        // MARK: - Subject Under Test (SUT)
        var sut: MapDetailInteractor!

        // MARK: - Test Doubles
        var presenterSpy: MapDetailPresenterProtocolSpy!
        var providerSpy: MapDetailProviderProtocolSpy!

        // MARK: - Tests
        beforeEach {
            setup()
        }

        afterEach {
            sut = nil
        }

        // MARK: Use Cases
        describe("Fetch data from provider") {
            it("Should ask provider to fetch station detail data and ask presenter to present data") {
                ///given
                let response = StationViewModel(
                    id: "0072202b-5f34-4a7a-86bf-020e4795b7d7",
                    lat: 55.649425,
                    lon: 37.700874
                )
                ///when
                sut.doStationUpdate(request: .init(data: response))
                
                ///then
                providerSpy.fetchById(withID: response.id).then { stationDetail -> Promise<StationDetail> in
                    providerSpy.deleteObjects()
                    providerSpy.saveIdToRealm(stationDetail)
                    return .value(stationDetail)
                }.done { stationDetail in
                    presenterSpy.presentStationResult(response: .init(result: .success(stationDetail)))
                    expect(presenterSpy.presentStationCalled).to(beTrue())
                }.catch { _ in
                    presenterSpy.presentStationResult(response: .init(result: .failure(Error.unloadable)))
                    expect(presenterSpy.presentStationCalled).to(beTrue())
                }
            }
        }

        // MARK: - Test Helpers
        func setup() {
            presenterSpy = MapDetailPresenterProtocolSpy()
            providerSpy = MapDetailProviderProtocolSpy()
            sut = MapDetailInteractor(
                presenter: presenterSpy,
                provider: providerSpy
            )
        }

    }
    
    enum Error: Swift.Error {
        case unloadable
    }
}

extension MapDetailInteractorSpec {
    class MapDetailPresenterProtocolSpy: MapDetailPresenterProtocol {
        //MARK: Spied Method
        var presentStationCalled = false
        var presentStationResponse: MapDetailLoad.Loading.Response?
        func presentStationResult(response: MapDetailLoad.Loading.Response) {
            presentStationCalled = true
            presentStationResponse = response
        }
    }

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
        var deleteObjectsCalled = false
        func deleteObjects() { deleteObjectsCalled = true }
    }
}
