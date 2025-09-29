//
//  ContentView.swift
//  InvitationGenerator
//
//  Created by Anthony on 29/9/25.
//

import SwiftUI

struct AddStudentSUView<ViewModel: AddStudentSUViewModelProtocol>: View {
    var onClose: VoidResult?
    var onLoading: VoidResult?
    var onError: ErrorResult?
    var onSuccess: VoidResult?
    
    @State var viewState: AddStudentSUViewState
    @State var viewModel: ViewModel
    
    enum ViewIdentifier: String {
        case mainContainer
        case closeButton
        case titleLabel
        case descriptionLabel
        case generateButton
        case shareButton
        case sharePreview
    }
    
    var body: some View {
        VStack {
            closeButtonView
                .padding(.top)
            
            mainContainerView
            
            Spacer()
            
            buttonsView
        }
        .task {
            viewState.updateOnLoading(onLoading)
            viewState.updateOnError(onError)
            viewState.updateOnSuccess(onSuccess)
            
            await viewModel.injectViewState(viewState)
            
            await viewModel.generateInviteCode()
        }
        .accessibilityIdentifier(ViewIdentifier.mainContainer.rawValue)
        .padding(.horizontal, 24)
    }
}

private extension AddStudentSUView {
    var closeButtonView: some View {
        HStack {
            Button(action: { onClose?() }, label: {
                Image(.xClose)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(Color.iconsDefault)
                    .frame(width: 24, height: 24)
            })
            .accessibilityIdentifier(ViewIdentifier.closeButton.rawValue)
            
            Spacer()
        }
    }
    
    var mainContainerView: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text(verbatim: viewState.titleText)
                .foregroundStyle(.primary)
                .font(.title)
                .accessibilityIdentifier(ViewIdentifier.titleLabel.rawValue)
            
            Text(verbatim: viewState.descriptionText)
                .foregroundStyle(Color.textSecondary)
                .font(.body)
                .accessibilityIdentifier(ViewIdentifier.descriptionLabel.rawValue)
            
            InviteCodeTextSUView(
                isCopied: $viewState.isInviteCodeCopied,
                inviteCode: viewState.inviteCodeValue ?? "",
                onCopy: { _ in
                    
                }
            )
        }
    }
    
    var buttonsView: some View {
        VStack(spacing: 12) {
            Button(action: {
                Task {
                    await viewModel.generateInviteCode()
                }
            }, label: {
                Text(viewState.generateButtonText)
                    .font(.body)
                    .padding()
                    .frame(maxWidth: .infinity)
            })
            .background(Color.surfacesBrandShade3)
            .foregroundStyle(Color.textBrandDefault)
            .clipShape(RoundedRectangle(cornerRadius: 48))
            .accessibilityIdentifier(ViewIdentifier.generateButton.rawValue)
            
            if let inviteCode = viewState.inviteCodeValue {
                ShareLink(
                    item: "Use this invite code to join: \(inviteCode)",
                    preview: SharePreview(
                        "JamTime",
                        icon: Image(.appIcon)
                    )
                ) {
                    Text(viewState.shareButtonText)
                        .font(.body)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.textBrandDefault)
                        .foregroundStyle(Color.textInverted)
                        .clipShape(RoundedRectangle(cornerRadius: 48))
                }
                .accessibilityIdentifier(ViewIdentifier.shareButton.rawValue)
            }
        }
    }
}

#Preview {
    @Previewable @State var viewModel = AddStudentSUViewModel(teacherService: MockTeacherService())
    @Previewable @State var viewState = AddStudentSUViewState()
    
    AddStudentSUView(
        onClose: {},
        viewState: viewState,
        viewModel: viewModel
    )
}

