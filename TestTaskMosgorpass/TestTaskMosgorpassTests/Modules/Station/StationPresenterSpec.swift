//
//  StationPresenterSpec.swift
//  TestTaskMosgorpassTests
//
//  Created by Roman Gorshkov on 25.05.2022.
//

import Quick
import Nimble
@testable import TestTaskMosgorpass

class StationPresenterSpec: QuickSpec {
    override func spec() {
        // MARK: - Subject Under Test (SUT) - объект под тестирование
        var sut: StationPresenter!

        // MARK: - Test Doubles
        var viewControllerSpy: StationViewControllerProtocolSpy!

        // MARK: - Tests
        ///Перед тестом устанавливаем переменные
        beforeEach {
            setupPresenter()
            setupDisplayLogic()
        }
        ///После теста зануляем объект под тестирование
        afterEach {
            sut = nil
        }

        // MARK: Use Cases
        describe("Present fetch stations data from interactor") {
            it("Should ask view controller to display stations data") {
                ///given
                let response = [Station(id: "0072202b-5f34-4a7a-86bf-020e4795b7d7",
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
                                         cityShuttle: false, electrobus: false)]
                ///when
                sut.presentStationsResult(response: .init(result: .success(response)))
                ///then
                expect(viewControllerSpy.displayWasStations).to(beTrue())
            }
        }
        
        describe("Present error data from interactor") {
            it("Should ask view controller to display error") {
                ///when
                sut.presentStationsResult(response: .init(result: .failure(Error.unloadable)))
                ///then
                expect(viewControllerSpy.displayError).to(beTrue())
            }
        }
        
        describe("Present fetch detail station data from interactor") {
            it("Should ask view controller to display detail station data") {
                ///given
                let response = [StationDetailRM(
                    id: "0072202b-5f34-4a7a-86bf-020e4795b7d7",
                    isWasViewed: true,
                    lat: 55.649425,
                    lon: 37.700874)]
                ///when
                sut.presentDetailStationResult(response: .init(result: .success(response)))
                ///then
                expect(viewControllerSpy.displayWasDetailStation).to(beTrue())
            }
        }

        // MARK: - Test Helpers
        func setupPresenter() {
            sut = StationPresenter()
        }

        func setupDisplayLogic() {
            viewControllerSpy = StationViewControllerProtocolSpy()
            sut.viewController = viewControllerSpy
        }
        
        enum Error: Swift.Error {
            case unloadable
        }
    }
}

extension StationPresenterSpec {
    class StationViewControllerProtocolSpy: StationViewControllerProtocol {

        // MARK: Spied Methods
        var displayWasStations = false
        var displayStationViewModel: [StationViewModel]?
        func displayStations(viewModel: StationLoad.Loading.ViewModel) {
            displayWasStations = true
            displayStationViewModel = viewModel.data.0
        }

        var displayError = false
        func displayError(error: StationLoad.Loading.OnError) {
            displayError = true
        }

        var displayWasDetailStation = false
        var displayDetailStationViewModel: StationDetailRM?
        func displayDetailStation(viewModel: StationDetailFinding.Loading.ViewModel) {
            displayWasDetailStation = true
            displayDetailStationViewModel = viewModel.data
        }
    }
}
