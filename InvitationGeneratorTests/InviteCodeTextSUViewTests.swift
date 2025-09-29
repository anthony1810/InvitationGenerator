//
//  InviteCodeTextSUView.swift
//  Jamtime
//
//  Created by Anthony on 26/9/25.
//  Copyright © 2025 Appetiser Pty Ltd. All rights reserved.
//

import XCTest
import UIKit
import SwiftUI
@testable import InvitationGenerator
import ViewInspector

@MainActor
final class InviteCodeTextSUViewTests: XCTestCase {
    
    // MARK: - Uncopied State Tests
    func test_uncopiedState_isProperlyConfigured() throws {
        let (sut, _) = makeSUT()
        
        // Main Button
        let mainButton = try sut.getMainContainerView()
        XCTAssertEqual(try backgroundColorFromView(mainButton), .surfacesBackground2, "Background")
        
        // Title
        let titleLabel = try sut.getTitleLabel()
        XCTAssertEqual(try textFromLabel(titleLabel), "Student invite code")
        XCTAssertEqual(try foregroundColorFromLabel(titleLabel), .textSecondary)
        XCTAssertEqual(try fontFromLabel(titleLabel), .caption)
        
        // Code - should be empty initially
        let codeLabel = try sut.getCodeLabel()
        XCTAssertEqual(try textFromLabel(codeLabel), "")
        XCTAssertEqual(try fontFromLabel(codeLabel), .body)
        
        // "Code Copied" label should not exist
        XCTAssertThrowsError(try sut.getCopiedLabel())
    }
    
    // MARK: - Copied State Tests
      func test_whenTapped_transitionsToCopiedState() async throws {
        var copiedValue: String?
        let expectedInviteCode = "372366"
        let (sut, viewModel) = makeSUT(inviteCode: expectedInviteCode) { code in
          copiedValue = code
        }
        try sut.getContainerButton().tap()
    
        XCTAssertEqual(copiedValue, expectedInviteCode)
        XCTAssertEqual(viewModel.isCopied, true)
    
        // Re-fetch the main button after state change
        let mainButton = try sut.getMainContainerView()
          XCTAssertEqual(try backgroundColorFromView(mainButton), .secondaryDefault.opacity(0.1))
    
        // "Code Copied" label should now be visible
        let copiedLabel = try sut.getCopiedLabel()
        XCTAssertEqual(try textFromLabel(copiedLabel), "Code copied")
          XCTAssertEqual(try foregroundColorFromLabel(copiedLabel), .textSecondary)
      }
    
    // MARK: - Helpers
    private func makeSUT(
        inviteCode: String? = nil,
        onCopy: SingleResult<String>? = nil
    )
    -> (sut: InviteCodeTextSUView, viewModel: InviteCodeTextViewModel)
    {
        let viewModel = InviteCodeTextViewModel()
        
        let suView = InviteCodeTextSUView(
            inviteCode: inviteCode,
            onCopy: onCopy, viewModel: viewModel
        )
        
        return (suView, viewModel)
    }
}


// MARK: - ViewInspector Helpers
extension InviteCodeTextSUView {
    typealias ViewIdentifier = InviteCodeTextSUView.ViewIdentifier
    
    func getContainerButton() throws -> InspectableView<ViewType.Button> {
        try self
            .inspect()
            .find(viewWithAccessibilityIdentifier: ViewIdentifier.inviteCodeButton.rawValue)
            .button()
    }
    
    func getMainContainerView() throws -> InspectableView<ViewType.ClassifiedView> {
        try self
            .inspect()
            .find(viewWithAccessibilityIdentifier: ViewIdentifier.inviteCodeContainerView.rawValue)
    }
    
    func getTitleLabel() throws -> InspectableView<ViewType.Text> {
        try self
            .inspect()
            .find(viewWithAccessibilityIdentifier: ViewIdentifier.inviteCodeTitleLabel.rawValue)
            .text()
    }
    
    func getCodeLabel() throws -> InspectableView<ViewType.Text> {
        try self
            .inspect()
            .find(viewWithAccessibilityIdentifier: ViewIdentifier.inviteCodeLabel.rawValue)
            .text()
    }
    
    func getIconImage() throws -> InspectableView<ViewType.Image> {
        try self
            .inspect()
            .find(viewWithAccessibilityIdentifier: ViewIdentifier.inviteCodeIconImage.rawValue)
            .image()
    }
    
    func getCopiedLabel() throws -> InspectableView<ViewType.Text> {
        try self
            .inspect()
            .find(viewWithAccessibilityIdentifier: ViewIdentifier.inviteCodeCopiedLabel.rawValue)
            .text()
    }
}

