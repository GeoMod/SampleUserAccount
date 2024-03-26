//
//  ModalType.swift
//  SampleUserAccount
//
//  Created by Daniel O'Leary on 3/22/24.
//

import Foundation

enum ModalType: Identifiable {
	case add
	case update(Song)

	var id: String {
		switch self {
			case .add: return "add"
			case .update: return "update"
		}
	}
}
