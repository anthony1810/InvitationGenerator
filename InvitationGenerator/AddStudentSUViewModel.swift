//
//  AddStudentSUViewModel.swift
//  InvitationGenerator
//
//  Created by Anthony on 29/9/25.
//


import Foundation
import UIKit

actor AddStudentSUViewModel: AddStudentSUViewModelProtocol {
  weak var viewState: AddStudentSUViewState?
  let teacherService: TeacherServiceProtocol
  
  init(teacherService: TeacherServiceProtocol) {
    self.teacherService = teacherService
  }
  
  func injectViewState(_ viewState: AddStudentSUViewState) {
    self.viewState = viewState
  }
  
  enum GenerateErrorCode: Error {
    case notAvailable
  }
  
  @MainActor
  func generateInviteCode() async {
    do {
      await viewState?.onLoading?()
      let inviteCode = try await teacherService.fetchInviteCode()
      
      await viewState?.updateInviteCodeValue(inviteCode)
      await viewState?.onSuccess?()
    } catch {
      await viewState?.updateInviteCodeError(error)
    }
  }
  
  func copyInviteCodeToClipboard() async {
    guard let inviteCodeValue = await viewState?.inviteCodeValue
    else { return }
    
    UIPasteboard.general.string = inviteCodeValue
  }
  
  func shareInviteCode() async {
    
  }
}
