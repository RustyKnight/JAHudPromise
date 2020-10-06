//
//  Hud+Promise.swift
//  JAHudHydra
//
//  Created by Shane Whitehead on 9/9/18.
//  Copyright © 2018 Shane Whitehead. All rights reserved.
//
import Foundation
import PromiseKit
import JAHud

public extension Hud {
	
	static func asyncPresentWait(on parent: UIViewController,
																			title: String? = nil,
																			text: String? = nil,
																			presentationStyle: PresentationStyle = .overCurrentContext,
																			configuration: Configuration? = nil) -> Promise<Void> {

		return .presentWaitHud(on: parent,
													 title: title,
													 text: text,
													 presentationStyle: presentationStyle,
													 configuration: configuration)
		
	}
	
	static func asyncPresentProgress(on parent: UIViewController,
																					progress: Progress,
																					title: String? = nil,
																					text: String? = nil,
																					presentationStyle: PresentationStyle = .overCurrentContext,
																					configuration: Configuration? = nil) -> Promise<Void> {
		
		return .presentProgressHud(on: parent,
															 progress: progress,
															 title: title,
															 text: text,
															 presentationStyle: presentationStyle,
															 configuration: configuration)
		
	}
	
	static func asyncPresentSuccess(on parent: UIViewController,
																				 title: String? = nil,
																				 text: String? = nil,
																				 presentationStyle: PresentationStyle = .overCurrentContext,
																				 configuration: Configuration? = nil) -> Promise<Void> {
		return .presentSuccessHud(on: parent,
															title: title,
															text: text,
															presentationStyle: presentationStyle,
															configuration: configuration)
		
	}
	
	static func asyncPresentFailure(on parent: UIViewController,
																				 title: String? = nil,
																				 text: String? = nil,
																				 presentationStyle: PresentationStyle = .overCurrentContext,
																				 configuration: Configuration? = nil) -> Promise<Void> {
		
		return .presentFailureHud(on: parent,
												 title: title,
												 text: text,
												 presentationStyle: presentationStyle,
												 configuration: configuration)
		
	}
  
  static func asynDismiss(from parent: UIViewController) -> Promise<Void> {
		return Promise<Void>.on(.main) { (resolver) in
      Hud.dismiss(from: parent, then: {
				resolver.fulfill(())
      })
    }
  }
	
}
