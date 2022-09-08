//
//  ViewController.swift
//  TrainingApp
//
//  Created by Alla Shkolnik on 25.07.2022.
//

import SnapKit
import UIKit

extension UIEdgeInsets {
    func inverted() -> UIEdgeInsets {
        return UIEdgeInsets(top: -top, left: -left,
                            bottom: -bottom, right: -right)
    }
}

final class ControlView: UIControl {
    
//    let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    //// Увеличивает область кажатия на insets
//    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//        let rect = bounds.inset(by: insets.inverted())
//
//        return rect.contains(point)
//    }
    
    
    //// конвертирует область нажатия во фрейм родителя, так чтобы выступающие вьюхи считывались
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let inside = super.point(inside: point, with: event)
        if !inside {
            for subview in subviews {
                let pointInSubview = subview.convert(point, from: self)
                if subview.point(inside: pointInSubview, with: event) {
                    return true
                }
            }
        }
        return inside
    }
    
}

class TouchesPassView: UIControl {
    
    //// Отключает обработку нажатия на той или иной области. (Может отключить нажатие у родителя)
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view === self {
            return nil
        }
        return view
    }
}

class ViewController1: UIViewController {
    
    let viewA = TouchesPassView()
    
    let viewB = ControlView()
    let viewB1 = ControlView()
    let viewB2 = ControlView()
    
    let viewC = TouchesPassView()
    let viewC1 = ControlView()
    let viewC2 = ControlView()
    
    let labelB = UILabel()
    let labelB1 = UILabel()
    let labelB2 = UILabel()
    let labelC = UILabel()
    let labelC1 = UILabel()
    let labelC2 = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ViewConttoller2")
        
        setupViewA()
        
        setupViewB()
        setupViewC()
        
        viewA.addTarget(nil, action: #selector(printA), for: .touchUpInside)
        
        viewB.addTarget(nil, action: #selector(printB), for: .touchUpInside)
        viewB1.addTarget(nil, action: #selector(printB1), for: .touchUpInside)
        viewB2.addTarget(nil, action: #selector(printB2), for: .touchUpInside)
        
        viewC.addTarget(nil, action: #selector(printC), for: .touchUpInside)
        viewC1.addTarget(nil, action: #selector(printC1), for: .touchUpInside)
        viewC2.addTarget(nil, action: #selector(printC2), for: .touchUpInside)
                
    }
    
    private func setupViewA() {
        viewA.backgroundColor = .systemPink
        
        view.addSubview(viewA)
        
        viewA.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupViewB() {
        
        viewB.backgroundColor = .systemYellow
        viewB1.backgroundColor = .white
        viewB2.backgroundColor = .white
        
        labelB.text = "B"
        labelB1.text = "B1"
        labelB2.text = "B2"
        
        viewA.addSubview(viewB)
        
        viewB.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.top.equalTo(60)
            make.height.equalTo(200)
        }
        
        viewB.addSubview(viewB1)
        viewB1.snp.makeConstraints { make in
            make.bottom.equalTo(-16)
            make.width.equalTo(100)
            make.top.equalTo(16)
            make.leading.equalTo(16)
        }
        
        viewB.addSubview(viewB2)
        viewB2.snp.makeConstraints { make in
            make.bottom.equalTo(40)
            make.width.equalTo(100)
            make.top.equalTo(16)
            make.trailing.equalTo(-16)
        }
        
        viewB.addSubview(labelB)
        labelB.snp.makeConstraints { make in
            make.top.equalTo(16)
            make.centerX.equalTo(viewB)
            make.height.equalTo(24)
        }
        
        viewB1.addSubview(labelB1)
        labelB1.snp.makeConstraints { make in
            make.top.equalTo(16)
            make.leading.equalTo(16)
            make.height.equalTo(24)
            make.width.equalTo(40)
        }
        
        viewB2.addSubview(labelB2)
        labelB2.snp.makeConstraints { make in
            make.top.equalTo(16)
            make.leading.equalTo(16)
            make.height.equalTo(24)
            make.width.equalTo(40)
        }
    }
    
    private func setupViewC() {
        
        viewC.backgroundColor = .systemYellow
        viewC1.backgroundColor = .white
        viewC2.backgroundColor = .white
        
        labelC.text = "C"
        labelC1.text = "C1"
        labelC2.text = "C2"
        
        viewA.addSubview(viewC)
        
        viewC.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.bottom.equalTo(-60)
            make.height.equalTo(200)
        }
        
        viewC.addSubview(viewC1)
        viewC1.snp.makeConstraints { make in
            make.bottom.equalTo(-16)
            make.width.equalTo(100)
            make.top.equalTo(16)
            make.leading.equalTo(16)
        }
        
        viewC.addSubview(viewC2)
        viewC2.snp.makeConstraints { make in
            make.bottom.equalTo(-16)
            make.width.equalTo(100)
            make.top.equalTo(16)
            make.trailing.equalTo(-16)
        }
        
        viewC.addSubview(labelC)
        labelC.snp.makeConstraints { make in
            make.top.equalTo(16)
            make.centerX.equalTo(viewB)
            make.height.equalTo(24)
        }
        
        viewC1.addSubview(labelC1)
        labelC1.snp.makeConstraints { make in
            make.top.equalTo(16)
            make.leading.equalTo(16)
            make.height.equalTo(24)
            make.width.equalTo(40)
        }
        
        viewC2.addSubview(labelC2)
        labelC2.snp.makeConstraints { make in
            make.top.equalTo(16)
            make.leading.equalTo(16)
            make.height.equalTo(24)
            make.width.equalTo(40)
        }
    }
    
    @objc private func printB(_ target: ControlView) {
        print("view B tapped!")
    }
    
    @objc private func printB1(_ target: ControlView) {
        print("view B1 tapped!")
    }
    
    @objc private func printB2(_ target: ControlView) {
        print("view B2 tapped!")
    }
    
    @objc private func printC(_ target: ControlView) {
        print("view C tapped!")
    }
    
    @objc private func printC1(_ target: ControlView) {
        print("view C1 tapped!")
    }
    
    @objc private func printC2(_ target: ControlView) {
        print("view C2 tapped!")
    }
    
    @objc private func printA(_ target: ControlView) {
        print("view A tapped!")
    }
}
