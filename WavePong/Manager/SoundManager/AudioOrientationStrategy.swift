//
//  AudioOrientationStrategy.swift
//  WavePong
//
//  Created by rsbj on 22/09/23.
//

import Foundation

protocol StereoProportionCalculable {
    
    func processStereoProportion(nodesInfo: AudioOrientationInfo, newProportion: @escaping (Float) -> Void)
}


class CurvedOrientationStragtegy: StereoProportionCalculable {
    func processStereoProportion(nodesInfo: AudioOrientationInfo, newProportion: @escaping (Float) -> Void) {
        let ballPositionX = nodesInfo.ballPosition.x
        let sizeWidth = nodesInfo.size.width
        
        
        let proportion = Float(ballPositionX / sizeWidth)
        let curvedProportion = sigmoidCurve(proportion)
        
        newProportion(curvedProportion)
    }
    
    private func sigmoidCurve(_ x: Float) -> Float {
        return Float(
            pow((x - 0.5), 3) / 0.0675)
    }
    
}


class LinearOrientationStrategy: StereoProportionCalculable {
    func processStereoProportion(nodesInfo: AudioOrientationInfo, newProportion: @escaping (Float) -> Void) {
        let ballPositionX = nodesInfo.ballPosition.x
        let sizeWidth = nodesInfo.size.width
        
        newProportion(Float(ballPositionX / sizeWidth/2))
    }
    
    
}

class HighContrastOrientationStrategy: StereoProportionCalculable {
    func processStereoProportion(nodesInfo: AudioOrientationInfo, newProportion: @escaping (Float) -> Void) {
        let ballPositionX = nodesInfo.ballPosition.x
        let sizeWidth = nodesInfo.size.width
        var proportion = Float((ballPositionX - (sizeWidth / 2) ) / (sizeWidth/2))
        
        if proportion >= 0.33 {
            proportion = 1
        }
        else if proportion <= -0.33 {
            proportion = -1
        }
        else {
            proportion = 0
        }
        
        newProportion(proportion)
    }
}

class PaddleOrientationLinearStrategy: StereoProportionCalculable {
    func processStereoProportion(nodesInfo: AudioOrientationInfo, newProportion: @escaping (Float) -> Void) {
        let ballPositionX = nodesInfo.ballPosition.x
        let paddlePositionX = nodesInfo.paddlePosition.x
        let sizeWidth = nodesInfo.size.width
        
        var proportion = Float((ballPositionX - paddlePositionX ) / (sizeWidth/2.5))
        if proportion >= 1 { proportion = 1 }
        if proportion <= -1 { proportion = -1 }
        
        newProportion(proportion)
    }
}

class PaddleOrientationExponencialStrategy: StereoProportionCalculable {
    func processStereoProportion(nodesInfo: AudioOrientationInfo, newProportion: @escaping (Float) -> Void) {
        let ballPositionX = nodesInfo.ballPosition.x
        let paddlePositionX = nodesInfo.paddlePosition.x
        let sizeWidth = nodesInfo.size.width
        
        let proportion = Float((ballPositionX - paddlePositionX)/sizeWidth) + 0.5
        var curvedProportion = sigmoidCurve(proportion)
        
        if curvedProportion >= 1 { curvedProportion = 1 }
        if curvedProportion <= -1 { curvedProportion = -1 }
        print(curvedProportion)
        newProportion(curvedProportion)
    }
    
    private func sigmoidCurve(_ x: Float) -> Float {
        return Float(
            pow((x - 0.5), 3) / 0.0675)
    }
}

class PaddleOrientationHighContrastStrategy: StereoProportionCalculable {
    func processStereoProportion(nodesInfo: AudioOrientationInfo, newProportion: @escaping (Float) -> Void) {
        let ballPositionX = nodesInfo.ballPosition.x
        let paddlePositionX = nodesInfo.paddlePosition.x
        let sizeWidth = nodesInfo.size.width
        
        var proportion = Float((ballPositionX - paddlePositionX ) / (sizeWidth/5))
        if proportion >= 1 { proportion = 1 }
        else if proportion <= -1 { proportion = -1 }
        else { proportion = 0 }
        print(proportion)
        newProportion(proportion)
    }
}
