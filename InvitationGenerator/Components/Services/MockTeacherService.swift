//
//  MockTeacherService.swift
//  InvitationGenerator
//
//  Created by Anthony on 29/9/25.
//
import Foundation

struct MockTeacherService: TeacherServiceProtocol {
    func fetchInviteCode() async throws -> String {
        String("1234567890".shuffled())
    }
}
