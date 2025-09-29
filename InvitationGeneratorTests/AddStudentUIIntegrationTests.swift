//
//  AddStudentUIIntegrationTests.swift
//  InvitationGenerator
//
//  Created by Anthony on 29/9/25.
//


import SwiftUI
import XCTest

import ViewInspector
@testable import InvitationGenerator

@MainActor
final class AddStudentUIIntegrationTests: XCTestCase {
  
  func test_onAppear_fetchInviteCode() async throws {
    let expectedInviteCode = "111111"
    let (sut, viewModel, _) = try await makeSUT()
    
    await viewModel.setExpectedInviteCodeResult(.success(expectedInviteCode))
    try await sut.triggerViewAppear()
    
    let inviteCodeLabel = try sut.getInviteCodeLabel()
    XCTAssertEqual(try inviteCodeLabel.string(), expectedInviteCode)
  }
    
  func test_tapGenerateCodeButton_displaysExpectedInviteCode() async throws {
    let expectedInviteCode = "111111"
    let (sut, viewModel, _) = try await makeSUT()
    try await sut.triggerViewAppear()
    
    let generateInviteCodeButton = try sut.getGenerateNewCodeButtonView().button()
    
    await viewModel.setExpectedInviteCodeResult(.success(expectedInviteCode))
    try generateInviteCodeButton.tap()
    
    try await Task.sleep(for: .milliseconds(100))
    
    let inviteCodeLabel = try sut.getInviteCodeLabel()
    XCTAssertEqual(try inviteCodeLabel.string(), expectedInviteCode)
  }
  
  func test_tapGenerateCodeButton_displaysExpectedError() async throws {
    let (sut, viewModel, viewState) = try await makeSUT()
    let generateInviteCodeButton = try sut.getGenerateNewCodeButtonView().button()
    try await sut.triggerViewAppear()
    
    await viewModel.setExpectedInviteCodeResult(.failure(anyNSError()))
    try generateInviteCodeButton.tap()
    try await Task.sleep(for: .milliseconds(100))
    
    XCTAssertEqual(viewState.error as? NSError, anyNSError())
  }
  
  // MARK: - Helpers
  private func makeSUT(stubbedInviteCode: Result<String, Error>? = nil)
  async throws -> (
    sut: AddStudentSUView<AddStudentSUViewModelStub>,
    viewModel: AddStudentSUViewModelStub, AddStudentSUViewState
  ) {
    let viewModel: AddStudentSUViewModelStub = .init()
    let viewState = AddStudentSUViewState()
    
    let sut = AddStudentSUView(
      viewState: viewState,
      viewModel: viewModel
    )
  
    return (sut, viewModel, viewState)
  }
  
  actor AddStudentSUViewModelStub: AddStudentSUViewModelProtocol {
    weak var viewState: AddStudentSUViewState?
    private(set) var stubbedInviteCode: Result<String, Error>?
    
    func injectViewState(_ viewState: AddStudentSUViewState) {
      self.viewState = viewState
    }
    
    enum GenerateErrorCode: Error {
      case notAvailable
    }
    
    func generateInviteCode() async {
      do {
        guard let stubbedInviteCode
        else { throw GenerateErrorCode.notAvailable }
        
        let inviteCode = try stubbedInviteCode.get()
       
        await viewState?.updateInviteCodeValue(inviteCode)
      } catch {
        await viewState?.updateInviteCodeError(error)
      }
    }
    
    func copyInviteCodeToClipboard() async {}
    
    func shareInviteCode() async {}
    
    func setExpectedInviteCodeResult(_ result: Result<String, Error>) {
      self.stubbedInviteCode = result
    }
  }
}

extension AddStudentSUView {
  func triggerViewAppear() async throws {
    try await self
      .inspect()
      .find(
        viewWithAccessibilityIdentifier: ViewIdentifier.mainContainer.rawValue
      ).callTask()
  }
}

extension AddStudentSUView {
  typealias ViewIdentifier = AddStudentSUView<AddStudentSUViewModel>.ViewIdentifier
  typealias InviteCodeViewIdentifier = InviteCodeTextSUView.ViewIdentifier
  
  func getCloseButtonView() throws -> InspectableView<ViewType.ClassifiedView> {
    try getButtonView(ViewIdentifier.closeButton.rawValue)
  }
  
  func getTitleLabel() throws -> InspectableView<ViewType.Text> {
    try self
      .inspect()
      .find(viewWithAccessibilityIdentifier: ViewIdentifier.titleLabel.rawValue)
      .text()
  }
  
  func getDescriptionLabel() throws -> InspectableView<ViewType.Text> {
    try self
      .inspect()
      .find(viewWithAccessibilityIdentifier: ViewIdentifier.descriptionLabel.rawValue)
      .text()
  }
  
  func getGenerateNewCodeButtonView() throws -> InspectableView<ViewType.ClassifiedView> {
    try getButtonView(ViewIdentifier.generateButton.rawValue)
  }
  
  func getShareLinkView() throws -> InspectableView<ViewType.ShareLink> {
    try self
      .inspect()
      .find(viewWithAccessibilityIdentifier: ViewIdentifier.shareButton.rawValue)
      .shareLink()
  }
  
  func getInviteCodeLabel() throws -> InspectableView<ViewType.Text> {
    try self
      .inspect()
      .find(viewWithAccessibilityIdentifier: InviteCodeViewIdentifier.inviteCodeLabel.rawValue)
      .text()
  }
  
  func getCopyButton() throws -> InspectableView<ViewType.Button> {
    try self
      .inspect()
      .find(viewWithAccessibilityIdentifier: InviteCodeViewIdentifier.inviteCodeContainerView.rawValue
      )
      .button()
  }
  
  func getInviteCodeButton() throws -> InspectableView<ViewType.Button> {
    try self
      .inspect()
      .find(viewWithAccessibilityIdentifier: InviteCodeViewIdentifier.inviteCodeButton.rawValue)
      .button()
  }
  
  func getInviteCodeLabelView() throws -> InspectableView<ViewType.ClassifiedView> {
    try getInviteCodeButton().labelView()
  }
  
  func getInviteTitleLabel() throws -> InspectableView<ViewType.Text> {
    try self
      .inspect()
      .find(viewWithAccessibilityIdentifier: InviteCodeViewIdentifier.inviteCodeTitleLabel.rawValue)
      .text()
  }
  
  func getInviteIconImage() throws -> InspectableView<ViewType.Image> {
    try self
      .inspect()
      .find(viewWithAccessibilityIdentifier: InviteCodeViewIdentifier.inviteCodeIconImage.rawValue)
      .image()
  }
  
  func getInviteCopiedLabel() throws -> InspectableView<ViewType.Text> {
    try self
      .inspect()
      .find(viewWithAccessibilityIdentifier: InviteCodeViewIdentifier.inviteCodeCopiedLabel.rawValue)
      .text()
  }
  
  private func getButtonView(_ identifier: String) throws -> InspectableView<ViewType.ClassifiedView> {
    try self
      .inspect()
      .find(viewWithAccessibilityIdentifier: identifier)
  }
}
