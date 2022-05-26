//
//  MapDetailViewControllerSpec.swift
//  TestTaskMosgorpassTests
//
//  Created by Roman Gorshkov on 25.05.2022.
//

import Quick
import Nimble
@testable import TestTaskMosgorpass

class MapDetailViewControllerSpec: QuickSpec {
    override func spec() {
        //MARK: - Subject Under Test (SUT) - объект под тестирование
        var sut: MapDetailViewController!
        var window: UIWindow!

        // MARK: - Test Doubles
        var interactorMapDetailProtocolSpy: MapDetailInteractorProtocolSpy!

        // MARK: - Tests
        beforeEach {
            window = UIWindow()
            setup()
        }

        afterEach {
            window = nil
            sut = nil
        }

        // MARK: View Lifecycle
        describe("ViewDidLoad") {
            it("Should ask interactor to do station update") {
                ///given
                ///when
                loadView()
                sut.viewWillAppear(true)

                ///then
            }
        }

        // MARK: Display Logic
        describe("Display fetch detail station data") {
            it("Shoud ask sut to display detail station data") {
                ///given
                loadView()
                let viewModel: ([StationDetailViewModel], [[TypeElement : Int]]) =
                ([StationDetailViewModel(
                    id: "0072202b-5f34-4a7a-86bf-020e4795b7d7",
                    name: "Курьяново",
                    type: "bus",
                    color: "#ffffff",
                    routePath: [RoutePath]())],
                 [[.bus: 1]])
                ///then
                sut.displayStationDetail(viewModel: .init(data: viewModel))
            }
        }
        
        describe("Display fetch error") {
            it("Shoud ask sut to display error") {
                ///given
                loadView()
                ///then
                sut.displayError(error: .init())
            }
        }

        // MARK: - Test Helpers
        func setup() {
            interactorMapDetailProtocolSpy = MapDetailInteractorProtocolSpy()
            sut = MapDetailViewController(
                interactor: interactorMapDetailProtocolSpy,
                stationViewModel: StationViewModel(
                    id: "0072202b-5f34-4a7a-86bf-020e4795b7d7",
                    lat: 55.649425,
                    lon: 37.700874
                )
            )
        }

        func loadView() {
            window.addSubview(sut.view)
            RunLoop.current.run(until: Date())
        }
    }
}
// MARK: - Test Doubles
extension MapDetailViewControllerSpec {
    class MapDetailInteractorProtocolSpy: MapDetailInteractorProtocol {
        // MARK: Spied Methods
        var doStationUpdateCalled = false
        func doStationUpdate(request: MapDetailLoad.StationDetailUpdate.Request) {
            doStationUpdateCalled = true
        }
    }
}
