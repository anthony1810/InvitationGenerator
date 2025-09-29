//
//  TestHelpers.swift
//  InvitationGenerator
//
//  Created by Anthony on 29/9/25.
//
import Foundation

func anyNSError() -> NSError {
  return NSError(domain: "TestError", code: 0, userInfo: nil)
}

func anyURL() -> URL {
  URL(string: "https://anyurl.com")!
}
