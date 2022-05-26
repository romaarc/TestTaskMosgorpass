//
//  MapDetailPresenterSpec.swift
//  TestTaskMosgorpassTests
//
//  Created by Roman Gorshkov on 25.05.2022.
//

import Quick
import Nimble
@testable import TestTaskMosgorpass

class MapDetailPresenterSpec: QuickSpec {
    override func spec() {
        // MARK: - Subject Under Test (SUT) - объект под тестирование
        var sut: MapDetailPresenter!

        // MARK: - Test Doubles
        var viewControllerSpy: MapDetailViewControllerProtocolSpy!

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
        describe("Present fetched detail station data from interactor") {
            it("Should ask view controller to display detail station data") {
                ///given
                let response = StationDetail(id: "0072202b-5f34-4a7a-86bf-020e4795b7d7", name: "Курьяново", type: "bus", wifi: false, bench: nil, elevator: nil, photo: nil, commentTotalCount: 0, routePath: [RoutePath](), color: "#ffffff", routeNumber: "10", isFavorite: false, shareURL: "", lat: 55.649425, lon: 37.700874, cityShuttle: false, electrobus: false, transportTypes: [String](), routeName: nil, shuttleType: nil, regional: false)
                ///when
                sut.presentStationResult(response: .init(result: .success(response)))
                ///then
                expect(viewControllerSpy.displayWasDetailStation).to(beTrue())
            }
        }
        
        describe("Present error data from interactor") {
            it("Should ask view controller to display error") {
                ///when
                sut.presentStationResult(response: .init(result: .failure(Error.unloadable)))
                ///then
                expect(viewControllerSpy.displayError).to(beTrue())
            }
        }

        // MARK: - Test Helpers
        func setupPresenter() {
            sut = MapDetailPresenter()
        }

        func setupDisplayLogic() {
            viewControllerSpy = MapDetailViewControllerProtocolSpy()
            sut.viewController = viewControllerSpy
        }
        
        enum Error: Swift.Error {
            case unloadable
        }
    }
}

extension MapDetailPresenterSpec {
    class MapDetailViewControllerProtocolSpy: MapDetailViewControllerProtocol {

        // MARK: Spied Methods
        var displayWasDetailStation = false
        var displayDetailStationViewModel: ([StationDetailViewModel], [[TypeElement: Int]])?
        func displayStationDetail(viewModel: MapDetailLoad.Loading.ViewModel) {
            displayWasDetailStation = true
            displayDetailStationViewModel = viewModel.data
        }

        var displayError = false
        func displayError(error: MapDetailLoad.Loading.onError) {
            displayError = true
        }
    }
}
