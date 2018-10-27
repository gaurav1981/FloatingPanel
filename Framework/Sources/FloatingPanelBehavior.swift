//
//  Created by Shin Yamamoto on 2018/10/03.
//  Copyright © 2018 Shin Yamamoto. All rights reserved.
//

import UIKit

public protocol FloatingPanelBehavior {
    // Returns a UIViewPropertyAnimator object for interacting with a floating panel by a user pan gesture
    func interactionAnimator(_ fpc: FloatingPanelController, to targetPosition: FloatingPanelPosition, with velocity: CGVector) -> UIViewPropertyAnimator

    // Returns a UIViewPropertyAnimator object to add a floating panel to a position.
    func addAnimator(_ fpc: FloatingPanelController, to: FloatingPanelPosition) -> UIViewPropertyAnimator

    // Returns a UIViewPropertyAnimator object to move a floating panel from a position to a position.
    func moveAnimator(_ fpc: FloatingPanelController, from: FloatingPanelPosition, to: FloatingPanelPosition) -> UIViewPropertyAnimator

    // Returns a UIViewPropertyAnimator object to remove a floating panel from a position.
    func removeAnimator(_ fpc: FloatingPanelController, from: FloatingPanelPosition) -> UIViewPropertyAnimator
}

public extension FloatingPanelBehavior {
    func addAnimator(_ fpc: FloatingPanelController, to: FloatingPanelPosition) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: 0.25, curve: .easeInOut)
    }

    func moveAnimator(_ fpc: FloatingPanelController, from: FloatingPanelPosition, to: FloatingPanelPosition) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: 0.25, curve: .easeInOut)
    }

    func removeAnimator(_ fpc: FloatingPanelController, from: FloatingPanelPosition) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: 0.25, curve: .easeInOut)
    }
}

class FloatingPanelDefaultBehavior: FloatingPanelBehavior {
    func interactionAnimator(_ fpc: FloatingPanelController, to targetPosition: FloatingPanelPosition, with velocity: CGVector) -> UIViewPropertyAnimator {
        let timing = timeingCurve(to: targetPosition, with: velocity)
        return UIViewPropertyAnimator(duration: 0, timingParameters: timing)
    }

    private func timeingCurve(to: FloatingPanelPosition, with velocity: CGVector) -> UITimingCurveProvider {
        log.debug("velocity", velocity)
        let damping = self.getDamping(with: velocity)
        return UISpringTimingParameters(dampingRatio: damping,
                                        frequencyResponse: 0.3,
                                        initialVelocity: velocity)
    }

    private let velocityThreshold: CGFloat = 8.0
    private func getDamping(with velocity: CGVector) -> CGFloat {
        let dy = abs(velocity.dy)
        if dy > velocityThreshold {
            return 0.7
        } else {
            return 1.0
        }
    }
}
