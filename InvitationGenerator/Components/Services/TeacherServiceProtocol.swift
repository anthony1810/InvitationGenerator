//
//  TeacherServiceProtocol.swift
//  InvitationGenerator
//
//  Created by Anthony on 29/9/25.
//


import Foundation

protocol TeacherServiceProtocol {
  func fetchInviteCode() async throws -> String
}

