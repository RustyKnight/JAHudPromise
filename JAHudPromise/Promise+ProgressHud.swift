//
//  Promise+ProgressHud.swift
//  JAHudHydra
//
//  Created by Shane Whitehead on 8/11/18.
//  Copyright © 2018 Shane Whitehead. All rights reserved.
//

import Foundation
import PromiseKit
import JAHud

public extension Promise {
	static func presentProgressHud(on parent: UIViewController,
																 progress: Progress,
																 title: String? = nil,
																 text: String? = nil,
																 presentationStyle: Hud.PresentationStyle = .overCurrentContext,
																 configuration: Hud.Configuration? = nil) -> Promise<Void> {
		
		return Promise<Void>.on(.main) { (resolver) in
			print("Present progress")
			Hud.presentProgress(on: parent,
													progress: progress,
													title: title,
													text: text,
													presentationStyle: presentationStyle,
													configuration: configuration,
													then: {
														print("Resolve")
														resolver.fulfill(())
													})
		}
	}
	
	@discardableResult
	func thenPresentProgressHud(on parent: UIViewController,
															progress: Progress,
															title: String? = nil,
															text: String? = nil,
															presentationStyle: Hud.PresentationStyle = .overCurrentContext,
															configuration: Hud.Configuration? = nil) -> Promise<T> {
		
		
		let rp = Promise<T>.pending()
		
		pipe { (result) in
			DispatchQueue.main.async {
				switch result {
				case .fulfilled(let value):
					Hud.presentProgress(on: parent,
															progress: progress,
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
}
