//
// SpriteFiles.swift
// DvdScreensaver
//
// Created by rsbj on 18/10/22.
//

import SpriteKit
import AVFoundation
import SwiftUI

public class PongScene: SKScene {
    
    var tocador: AVAudioPlayer?
    
    @Binding var scoreBound: Int
    @Binding var shouldShow: Bool
    @Binding var pausedGame: Bool
    
    var ballNode: SKNode
    var ballNodeShadow: SKNode
    var raqueteNode : SKNode
    var nuvemNode1: SKNode
    var nuvemNode2: SKNode
    var nuvemNode3: SKNode
    
    var randomStart = Double.random(in: -1...1)
    
    var moveTransformBall = CGAffineTransform(translationX: Double.random(in: 2...3) * (Double.random(in: -1...1) >= 0 ? 1 : -1)
, y: Double.random(in: 2...3) * (Double.random(in: -1...1) >= 0 ? 1 : -1)) // função para mover a bola
    var moveTransformNuvem = CGAffineTransform(translationX: 4, y: -0.4) // função para mover a nuvem
    var moveTransformNuvem2 = CGAffineTransform(translationX: -4, y: -0.4)
    var moveTransformNuvem3 = CGAffineTransform(translationX: 4, y: -0.4)
    
    public init(ballNode: SKNode, ballNodeShadow: SKNode, size: CGSize, raquete: SKNode, nuvem: SKNode, nuvem2: SKNode, nuvem3: SKNode, score: Binding<Int>, deveMostrar: Binding<Bool>, pausou: Binding<Bool>) {
        self.ballNode = ballNode // pegando os dados da ContentView
        self.raqueteNode = raquete
        self.nuvemNode1 = nuvem
        self.nuvemNode2 = nuvem2
        self.nuvemNode3 = nuvem3
        self.ballNodeShadow = ballNodeShadow
        _scoreBound = score
        _shouldShow = deveMostrar
        _pausedGame = pausou
        super.init(size: size) // Definido o tamanho da Scene o tamanho dado
        setup()
    }
    
    
    private func setup() {
        let background = SKSpriteNode(imageNamed: "background")
        background.size = frame.size
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(background)
        
        addChild(ballNode) // colocando os objetos na Scene
        addChild(raqueteNode)
        addChild(nuvemNode3)
        addChild(nuvemNode2)
        addChild(nuvemNode1)
        addChild(ballNodeShadow)
        
        ballNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY) // definindo a posição inicial
        raqueteNode.position = CGPoint(x: self.frame.midX, y: CGFloat(Int(self.frame.minY)+60))
        
        nuvemNode1.position = CGPoint(x: self.frame.midX, y: self.frame.maxY+(CGFloat(nuvemNode1.frame.size.height)/2)+10) // nessa parte, na declaração do y, a gente tem que usar “CGFloat(nuvemNode.frame.size.height)/2” para corrigir, por a função “position(x:,y:)” sempre usa o midX e midY
        nuvemNode2.position = CGPoint(x: self.frame.midX, y: self.frame.maxY+(CGFloat(nuvemNode2.frame.size.height)/2))
        nuvemNode3.position = CGPoint(x: self.frame.midX+10, y: self.frame.maxY+(CGFloat(nuvemNode2.frame.size.height)/2)-2)
        
        ballNodeShadow.position = ballNode.position
        ballNodeShadow.isHidden = true
    }
    
    fileprivate func showShadow() {
        ballNodeShadow.position = ballNode.position
        ballNodeShadow.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.ballNodeShadow.isHidden = true
        }
    }
    
    var ballPositionX: CGFloat = 0
    var ballPositionY: CGFloat = 0
    var speeed : Float = 2 // velocidade inicial da bola
    var primeiraSpeeed: Float = 0
    var scoreCount = 0
    
    // Update is called once per frame
    fileprivate func didLose(_ ballFrame: CGRect) {
        tocador?.stop()
        moveTransformBall.tx = 0
        moveTransformBall.ty = 0
        moveTransformNuvem.ty = 0
        moveTransformNuvem2.ty = 0
        moveTransformNuvem3.ty = 0
        
        nuvemNode1.isHidden = true
        nuvemNode2.isHidden = true
        nuvemNode3.isHidden = true
        raqueteNode.isHidden = true
        
        shouldShow = true
    }
    
    public override func update(_ currentTime: TimeInterval) {
        speeed = speeed + 0.0005
        
        // Collect a reference frame for the node’s current position
        let ballFrame = ballNode.calculateAccumulatedFrame()
        let frameRaquete = raqueteNode.calculateAccumulatedFrame()
        let frameNuvem1 = nuvemNode1.calculateAccumulatedFrame()
        let frameNuvem2 = nuvemNode2.calculateAccumulatedFrame()
        let frameNuvem3 = nuvemNode3.calculateAccumulatedFrame()
        
        // Update the node’s position by applying the transform
        if pausedGame == false {
            ballNode.position = ballNode.position.applying(moveTransformBall)
            nuvemNode1.position = nuvemNode1.position.applying(moveTransformNuvem)
            nuvemNode2.position = nuvemNode2.position.applying(moveTransformNuvem2)
            nuvemNode3.position = nuvemNode3.position.applying(moveTransformNuvem3)
            
            ballPositionX = ballFrame.midX-15 // Used to determinate de side were the music is coming from
            ballPositionY = ballFrame.midY-15
        }
//        ballNode.position = ballNode.position.applying(moveTransformBall)
//        nuvemNode1.position = nuvemNode1.position.applying(moveTransformNuvem)
//        nuvemNode2.position = nuvemNode2.position.applying(moveTransformNuvem2)
//        nuvemNode3.position = nuvemNode3.position.applying(moveTransformNuvem3)
//        
//        ballPositionX = ballFrame.midX-15 // Used to determinate de side were the music is coming from
//        ballPositionY = ballFrame.midY-15 //Used to determinate the intensity of the music
        
        // Top bound
        if ballFrame.maxY >= self.frame.maxY-20 {
            moveTransformBall.ty = CGFloat(-speeed)
            if moveTransformBall.tx > 0 {
                moveTransformBall.tx = CGFloat(speeed)
            }
            else {
                moveTransformBall.tx = CGFloat(-speeed)
            }
            
            if ballFrame.minY >= frameNuvem1.minY{
                showShadow()
            }
        }
        
        // Right bound
        if ballFrame.maxX >= self.frame.maxX+10 {
            moveTransformBall.tx = CGFloat(-speeed)
            
            if moveTransformBall.ty > 0 {
                moveTransformBall.ty = CGFloat(speeed)
            }
            else {
                moveTransformBall.ty = CGFloat(-speeed)
            }
            
            if ballFrame.minY >= frameNuvem1.minY{
                showShadow()
            }
        }
        
        // Left bound
        if ballFrame.minX <= self.frame.minX-15 {
            moveTransformBall.tx = CGFloat(+speeed)
            
            if moveTransformBall.ty > 0 {
                moveTransformBall.ty = CGFloat(speeed)
            }
            else {
                moveTransformBall.ty = CGFloat(-speeed)
            }
            
            if ballFrame.minY >= frameNuvem1.minY{
                showShadow()
            }
        }
        
        // Bottom bound -> raquete
        if frameRaquete.maxY >= ballFrame.minY+15 && ballFrame.minX <= frameRaquete.maxX-15 && ballFrame.maxX >= frameRaquete.minX+15 && frameRaquete.minY <= ballFrame.minY{

            // Raquete
            if frameRaquete.maxY >= ballFrame.minY+15 && ballFrame.minX <= frameRaquete.maxX-15 && ballFrame.maxX >= frameRaquete.minX+15 && frameRaquete.minY <= ballFrame.midY && moveTransformBall.tx != 0
            {
                
                if speeed > (primeiraSpeeed + 0.0015) {
                    primeiraSpeeed = speeed
                    moveTransformBall.ty = CGFloat(+speeed)
 
                    UIDevice.vibrate() // Vibration System
                    
                    scoreBound += 1
                    
                    if ballFrame.midX <= (frameRaquete.midX-(frameRaquete.width/4)){
                        moveTransformBall.tx = CGFloat(-speeed)
//                        print("extrema esquerda")
                    }
                    else if ballFrame.midX <= frameRaquete.midX && ballFrame.midX >= (frameRaquete.midX-(frameRaquete.width/4)){
                        moveTransformBall.tx = CGFloat(-speeed)/2
//                        print("mid esquerda")
                    }
                    else if ballFrame.midX > (frameRaquete.midX+(frameRaquete.width/4)){
                        moveTransformBall.tx = CGFloat(speeed)
//                        print("extrema direita")
                    }
                    else if ballFrame.midX > frameRaquete.midX && ballFrame.midX <= (frameRaquete.midX+(frameRaquete.width/4)){
                        moveTransformBall.tx = CGFloat(speeed)/2
//                        print("mid direita")
                    }
                }
            }
        }
        
        //Se a bola sai da tela
        if ballFrame.maxY <= self.frame.minY && moveTransformBall.tx != 0 {
            didLose(ballFrame)

        }
            
        //MARK: Se o jogador tocou com dois dedos
        if pausedGame == true {
            tocador?.stop()
            moveTransformBall.tx = 0
            moveTransformBall.ty = 0
            moveTransformNuvem.ty = 0
            moveTransformNuvem2.ty = 0
            moveTransformNuvem3.ty = 0
            moveTransformNuvem.tx = 0
            moveTransformNuvem2.tx = 0
            moveTransformNuvem3.tx = 0
//            let auxBallPosition = ballNode.position
//            let auxRaquetePosition = raqueteNode.position
//            let auxCloudPosition = nuvemNode1.position
//            let auxCloudPosition2 = nuvemNode2.position
//            let auxCloudPosition3 = nuvemNode3.position
            //imagino q va precisar chamar outra instancia dessa SKscene, sendo que passando como parametro
            shouldShow = true 
        }
        
        if frameNuvem1.minY <= self.frame.minY+80{
            moveTransformNuvem.ty = 0
        }
        if frameNuvem1.midX >= self.frame.maxX-5{
            moveTransformNuvem.tx = -4
        }
        if frameNuvem1.midX <= self.frame.minX+5{
            moveTransformNuvem.tx = 4
        }
        if frameNuvem2.minY <= self.frame.minY+80{
            moveTransformNuvem2.ty = 0
        }
        if frameNuvem2.midX >= self.frame.maxX-5{
            moveTransformNuvem2.tx = -4
        }
        if frameNuvem2.midX <= self.frame.minX+5{
            moveTransformNuvem2.tx = 4
        }
        if frameNuvem3.minY <= self.frame.minY+80{
            moveTransformNuvem3.ty = 0
        }
        if frameNuvem3.midX >= self.frame.maxX-5{
            moveTransformNuvem3.tx = -6
        }
        if frameNuvem3.midX <= self.frame.minX+5{
            moveTransformNuvem3.tx = 6
        }
        
        Music()
    }
    
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let frameRaquete = raqueteNode.calculateAccumulatedFrame()
            
            let location = touch.location(in: self)
            
            if frameRaquete.maxX <= self.frame.maxX && frameRaquete.minX >= self.frame.minX{
                raqueteNode.position.x = location.x
            }
            // Right bound safe
            if frameRaquete.maxX >= self.frame.maxX {
                raqueteNode.position.x = raqueteNode.position.x - 2.5
            }
            // Left bound safe
            if frameRaquete.minX <= self.frame.minX {
                raqueteNode.position.x = raqueteNode.position.x + 2.5
            }
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

