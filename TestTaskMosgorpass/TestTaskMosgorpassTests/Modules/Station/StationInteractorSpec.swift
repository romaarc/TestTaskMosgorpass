//
//  StationInteractorSpec.swift
//  TestTaskMosgorpassTests
//
//  Created by Roman Gorshkov on 25.05.2022.
//

import Quick
import Nimble
import PromiseKit
@testable import TestTaskMosgorpass

class StationInteractorSpec: QuickSpec {
    override func spec() {
        // MARK: - Subject Under Test (SUT)
        var sut: StationInteractor!

        // MARK: - Test Doubles
        var presenterSpy: StationPresenterProtocolSpy!
        var providerSpy: StationProviderProtocolSpy!

        // MARK: - Tests
        beforeEach {
            setup()
        }

        afterEach {
            sut = nil
        }

        // MARK: Use Cases
        describe("Fetch data from provider") {
            it("Should ask provider to fetch stations data and ask presenter to present their data") {
                ///when
                sut.doStationsUpdate(request: .init())
                ///then
                providerSpy.fetch().then { stations -> Promise<[Station]> in
                    providerSpy.deleteObjects()
                    return.value(stations)
                }.done { stations in
                    presenterSpy.presentStationsResult(response: .init(result: .success(stations)))
                    expect(presenterSpy.presentStationCalled).to(beTrue())
                }.catch { _ in
                    presenterSpy.presentStationsResult(response: .init(result: .failure(Error.unloadable)))
                    expect(presenterSpy.presentStationCalled).to(beTrue())
                }
            }
        }
        
        describe("Finding data from Realm") {
            it("Should ask provider request data from Realm and ask presenter to present data or sut update station") {
                ///given
                let objs = providerSpy.fetchObjects()
                ///then
                if !objs.isEmpty {
                    presenterSpy.presentDetailStationResult(response: .init(result: .success(objs)))
                    expect(presenterSpy.presentDetailStationCalled).to(beTrue())
                } else {
                    providerSpy.fetch().then { stations -> Promise<[Station]> in
                        providerSpy.deleteObjects()
                        return.value(stations)
                    }.done { stations in
                        presenterSpy.presentStationsResult(response: .init(result: .success(stations)))
                        expect(presenterSpy.presentStationCalled).to(beTrue())
                    }.catch { _ in
                        presenterSpy.presentStationsResult(response: .init(result: .failure(Error.unloadable)))
                        expect(presenterSpy.presentStationCalled).to(beTrue())
                    }
                }
            }
        }
        
        describe("Delete objects from Realm") {
            it("Should ask provider to remove all objects from Realm") {
                ///then
                providerSpy.deleteObjects()
                expect(providerSpy.deleteObjectsCalled).to(beTrue())
            }
        }

        // MARK: - Test Helpers
        func setup() {
            presenterSpy = StationPresenterProtocolSpy()
            providerSpy = StationProviderProtocolSpy()
            sut = StationInteractor(
                presenter: presenterSpy,
                provider: providerSpy)
        }
    }
    
    enum Error: Swift.Error {
        case unloadable
    }
}

extension StationInteractorSpec {
    class StationPresenterProtocolSpy: StationPresenterProtocol {
        //MARK: Spied Method
        var presentStationCalled = false
        var presentStationResponse: StationLoad.Loading.Response?
        func presentStationsResult(response: StationLoad.Loading.Response) {
            presentStationCalled = true
            presentStationResponse = response
        }

        var presentDetailStationCalled = false
        var presentDetailStationResponse: StationDetailFinding.Loading.Response?
        func presentDetailStationResult(response: StationDetailFinding.Loading.Response) {
            presentDetailStationCalled = true
            presentDetailStationResponse = response
        }
    }

    class StationProviderProtocolSpy: StationProviderProtocol {
        //MARK: Spied Method
        func fetch() -> Promise<[Station]> {
            return Promise { seal in
                seal.fulfill([Station(id: "0072202b-5f34-4a7a-86bf-020e4795b7d7",
                                      lat: 55.649425,
                                      lon: 37.700874,
                                      name: "Курьяново",
                                      type: .publicTransport,
                                      routeNumber: nil,
                                      color: nil,
                                      routeName: nil,
                                      subwayID: nil,
                                      shareURL: "",
                                      wifi: false,
                                      usb: false,
                                      transportType: nil,
                                      transportTypes: [TypeElement](),
                                      isFavorite: false,
                                      icon: nil,
                                      mapIcon: nil,
                                      mapIconSmall: nil,
                                      cityShuttle: false, electrobus: false)])
            }
        }
        
        func fetchObjects() -> [StationDetailRM] {
            [StationDetailRM]()
        }
        var deleteObjectsCalled = false
        func deleteObjects() { deleteObjectsCalled = true }
    }
}
