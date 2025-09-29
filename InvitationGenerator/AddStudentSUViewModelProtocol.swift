//
//  AddStudentSUViewModelProtocol.swift
//  InvitationGenerator
//
//  Created by Anthony on 29/9/25.
//

import Foundation

protocol AddStudentSUViewModelProtocol: Actor {
  var viewState: AddStudentSUViewState? { get }
  
  func injectViewState(_ viewState: AddStudentSUViewState)
  func generateInviteCode() async
  func copyInviteCodeToClipboard() async
  func shareInviteCode() async
}
