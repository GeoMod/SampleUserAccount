//
//  Song.swift
//  SampleUserAccount
//
//  Created by Daniel O'Leary on 3/21/24.
//

import Foundation

struct Song: Identifiable, Codable {
	let id: UUID?
	let title: String
}
