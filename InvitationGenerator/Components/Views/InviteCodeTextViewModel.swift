//
//  InviteCodeTextViewModel.swift
//  Jamtime
//
//  Created by Anthony on 27/9/25.
//  Copyright © 2025 Appetiser Pty Ltd. All rights reserved.
//
import Foundation
import SwiftUI

@MainActor
@Observable
final class InviteCodeTextViewModel {
  var inviteCode: String?
  var isCopied = false
  
  var onCopy: ((String) -> Void)?
  
  init(inviteCode: String? = nil, onCopy: ((String) -> Void)? = nil) {
    self.inviteCode = inviteCode
    self.onCopy = onCopy
  }
  
  func copyCode() {
    guard let code = inviteCode, !code.isEmpty else { return }
    onCopy?(code)
    withAnimation {
      isCopied = true
    }
  }
}
