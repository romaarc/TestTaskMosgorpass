//
//  StationProviderSpec.swift
//  TestTaskMosgorpassTests
//
//  Created by Roman Gorshkov on 25.05.2022.
//

import Quick
import Nimble
import PromiseKit
@testable import TestTaskMosgorpass

class StationProviderSpec: QuickSpec {
    override func spec() {
        // MARK: - Subject Under Test (SUT) - объект под тестирование
        var sut: StationProvider!

        // MARK: - Test Doubles
        var providerSpy: StationProviderProtocolSpy!

        // MARK: - Tests
        beforeEach {
            setup()
        }

        afterEach {
            sut = nil
        }

        // MARK: Use Cases
        describe("fetch data") {
            it("should fetch data from API") {
                //when
                sut.fetch().done { _ in }.catch { _ in }
                //then
                providerSpy.fetch().done { _ in }.catch { _ in }
            }
        }
        
        describe("fetch objects from Realm") {
            it("should fetch objects") {
                //then
                let objectsSpy = providerSpy.fetchObjects()
                expect(objectsSpy).to(beEmpty())
            }
        }
        
        describe("Delete objects from Realm") {
            it("should remove all objects") {
                //then
                providerSpy.deleteObjects()
                expect(providerSpy.deleteObjectsCalled).to(beTrue())
            }
        }

        // MARK: - Test Helpers
        func setup() {
            providerSpy = StationProviderProtocolSpy()
            sut = StationProvider(
                mosgorpassNetworkService: NetworkService(),
                stationDetailRealmService: RealmService()
            )
        }
    }
}

// MARK: - Test Doubles
extension StationProviderSpec {
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
