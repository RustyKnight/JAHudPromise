//
//  Promise+PresentHud.swift
//  JAHudHydra
//
//  Created by Shane Whitehead on 8/11/18.
//  Copyright © 2018 Shane Whitehead. All rights reserved.
//

import Foundation
import PromiseKit
import JAHud

public extension Promise {
	static func presentWaitHud(on parent: UIViewController,
														 title: String? = nil,
														 text: String? = nil,
														 presentationStyle: Hud.PresentationStyle = .overCurrentContext,
														 configuration: Hud.Configuration? = nil) -> Promise<Void> {
		return Promise<Void>.on(.main) { (resolver) in
			Hud.presentWait(on: parent,
											title: title,
											text: text,
											presentationStyle: presentationStyle,
											configuration: configuration,
											then: {
												resolver.fulfill(())
											})
		}
	}
	
	@discardableResult
	func thenPresentWaitHud(on parent: UIViewController,
													title: String? = nil,
													text: String? = nil,
													presentationStyle: Hud.PresentationStyle = .overCurrentContext,
													configuration: Hud.Configuration? = nil) -> Promise<T> {
		
		let rp = Promise<T>.pending()
		
		pipe { (result) in
			DispatchQueue.main.async {
				switch result {
				case .fulfilled(let value):
					Hud.presentWait(on: parent,
													title: title,
													text: text,
													presentationStyle: presentationStyle,
													configuration: configuration,
													then: {
														rp.resolver.fulfill(value)
													})
				case .rejected(let error):
					rp.resolver.reject(error)
				}
			}
		}

		return rp.promise
	}
	
	@discardableResult
	func thenDismissHud(from parent: UIViewController) -> Promise<T> {
		let rp = Promise<T>.pending()
		
		pipe { (result) in
			DispatchQueue.main.async {
				switch result {
				case .fulfilled(let value):
					Hud.dismiss(from: parent, then: {
						rp.resolver.fulfill(value)
					})
				case .rejected(let error):
					rp.resolver.reject(error)
				}
			}
		}

		return rp.promise
	}
}
