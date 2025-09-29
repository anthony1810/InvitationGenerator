//
//  AddStudentSUViewState.swift
//  InvitationGenerator
//
//  Created by Anthony on 29/9/25.
//


import SwiftUI

@MainActor
@Observable
final class AddStudentSUViewState {
  let titleText: String = "Add a new student"
  let descriptionText: String = "Copy the code below and share it with your new student. This code will expire after 24 hours and can only be used once."
  let generateButtonText: String = "Generate new code"
  let shareButtonText: String = "Share"
  
  var inviteCodeValue: String?
  var error: Error?
  var onLoading: VoidResult?
  var onError: ErrorResult?
  var onSuccess: VoidResult?
  
  func updateInviteCodeValue(_ newValue: String?) {
    inviteCodeValue = newValue
  }
  
  func updateInviteCodeError(_ newValue: Error?) {
    error = newValue
    if let newValue {
      onError?(newValue)
    }
  }
  
  func updateOnLoading(_ newValue: VoidResult?) {
    onLoading = newValue
  }
  
  func updateOnError(_ newValue: ErrorResult?) {
    onError = newValue
  }
  
  func updateOnSuccess(_ newValue: VoidResult?) {
    onSuccess = newValue
  }
}
