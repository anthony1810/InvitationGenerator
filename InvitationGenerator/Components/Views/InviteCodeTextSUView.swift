//
//  InviteCodeTextSUView.swift
//  Jamtime
//
//  Created by Anthony on 27/9/25.
//  Copyright © 2025 Appetiser Pty Ltd. All rights reserved.
//
import Foundation
import SwiftUI

struct InviteCodeTextSUView: View {
    @State var viewModel: InviteCodeTextViewModel
    
    enum ViewIdentifier: String {
        case inviteCodeButton
        case inviteCodeContainerView
        case inviteCodeTitleLabel
        case inviteCodeLabel
        case inviteCodeIconImage
        case inviteCodeCopiedLabel
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Button(action: viewModel.copyCode) {
                mainContainerView()
                    .accessibilityIdentifier(ViewIdentifier.inviteCodeContainerView.rawValue)
            }
            .accessibilityIdentifier(ViewIdentifier.inviteCodeButton.rawValue)
            
            if viewModel.isCopied {
                HStack {
                    copyCodeLabel()
                        .accessibilityIdentifier(ViewIdentifier.inviteCodeCopiedLabel.rawValue)
                    
                    Spacer()
                }
            }
        }
    }
    
    private func mainContainerView() -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                titleLabel()
                    .accessibilityIdentifier(ViewIdentifier.inviteCodeTitleLabel.rawValue)
                
                inviteCodeLabel()
                    .accessibilityIdentifier(ViewIdentifier.inviteCodeLabel.rawValue)
            }
            
            Spacer()
            copyStatusIcon()
                .accessibilityIdentifier(ViewIdentifier.inviteCodeIconImage.rawValue)
        }
        .padding()
        .background(viewModel.isCopied
                    ? Color.secondaryDefault.opacity(0.1)
                    : Color.surfacesBackground2
        )
        .clipShape(RoundedRectangle(cornerRadius: 48))
        .overlay(
            RoundedRectangle(cornerRadius: 48)
                .stroke(viewModel.isCopied ? Color.secondaryDefault : Color.clear, lineWidth: 1)
        )
    }
    
    func titleLabel() -> some View {
        Text(verbatim: "Student invite code")
            .font(.caption)
            .foregroundStyle(Color.textSecondary)
    }
    
    func inviteCodeLabel() -> some View {
        Text(viewModel.inviteCode ?? "")
            .font(.body)
            .foregroundStyle(.textPrimary)
    }
    
    func copyStatusIcon() -> some View {
        Image(viewModel.isCopied ? .checkedCopyIcon : .uncheckedCopyIcon)
            .resizable()
            .frame(width: 24, height: 24)
    }
    
    private func copyCodeLabel() -> some View {
        Text(verbatim: "Code copied")
            .font(.caption)
            .foregroundStyle(Color.textSecondary)
            .transition(.opacity.animation(.easeInOut))
            .padding(.leading, 16)
    }
}
