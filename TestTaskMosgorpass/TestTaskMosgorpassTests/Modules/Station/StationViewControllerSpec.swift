//
//  StationViewControllerSpec.swift
//  TestTaskMosgorpassTests
//
//  Created by Roman Gorshkov on 25.05.2022.
//

import Quick
import Nimble
@testable import TestTaskMosgorpass

class StationViewControllerSpec: QuickSpec {
    override func spec() {
        // MARK: - Subject Under Test (SUT) - объект под тестирование
        var sut: StationViewController!
        var window: UIWindow!

        // MARK: - Test Doubles
        var interactorSpy: StationInteractorProtocolSpy!
        var routerSpy: StationRouterProtocolSpy!

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
            it("Should ask interactor to display stations data") {
                //given
                //when
                loadView()
                sut.viewWillAppear(true)

                ///then
            }
        }

        // MARK: Display Logic
        describe("Display fetch stations data") {
            it("Shoud ask sut to display detail station data") { 
                ///given
                loadView()
                let response = ([StationViewModel(
                    id: "0072202b-5f34-4a7a-86bf-020e4795b7d7",
                    lat: 55.649425,
                    lon: 37.700874)],
                    [[TypeElement.bus: 1]]
                )
                ///then
                sut.displayStations(viewModel: .init(data: response))
            }
        }
        
        describe("Display fetch detail station data") {
            it("Shoud ask sut to display detail station data using router") {
                ///given
                loadView()
                let viewModel = StationDetailRM(
                    id: "0072202b-5f34-4a7a-86bf-020e4795b7d7",
                    isWasViewed: true,
                    lat: 55.649425,
                    lon: 37.700874)
                ///then
                sut.displayDetailStation(viewModel: .init(data: viewModel))
                expect(routerSpy.showDetailCalled).to(beTrue())
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
            interactorSpy = StationInteractorProtocolSpy()
            routerSpy = StationRouterProtocolSpy()
            sut = StationViewController(
                interactor: interactorSpy,
                router: routerSpy
            )
        }

        func loadView() {
            window.addSubview(sut.view)
            RunLoop.current.run(until: Date())
        }
    }
}
// MARK: - Test Doubles
extension StationViewControllerSpec {
    class StationInteractorProtocolSpy: StationInteractorProtocol {
        // MARK: Spied Methods
        var doStationUpdateCalled = false
        func doStationsUpdate(request: StationLoad.StationUpdate.Request) {
            doStationUpdateCalled = true
        }

        var doFindingDetailStationCalled = false
        func doFindingDetailStation(request: StationLoad.StationUpdate.Request) {
            doFindingDetailStationCalled = false
        }

        var doDetailStationDeleteCalled = false
        func doDetailStationDelete(request: StationLoad.StationUpdate.Request) {
            doDetailStationDeleteCalled = true
        }
    }
    
    class StationRouterProtocolSpy: StationRouterInput {
        var showDetailCalled = false
        func showDetail(with viewModel: StationViewModel) {
            showDetailCalled = true
        }
    }
}
