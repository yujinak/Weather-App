//
//  ViewController.swift
//  Weather App
//
//  Created by Vilson Beregula on 24/07/24.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var customView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()


    override func viewDidLoad() {
        // Executa uma vez ao iniciar o aplicativo
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Executa quando a ViewController aparece na tela
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Executa antes da ViewController aparecer na tela, e antes de viewDidAppear
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Executa antes da ViewController desaparecer na tela
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // Executa quando a ViewController desaparece na tela
        super.viewDidDisappear(animated)
    }
    
    private func setupView() {
        view.backgroundColor = .red
        
        view.addSubview(customView)
        
        setHierarchy()
        setConstraints()
    

    }
    
    private func setHierarchy(){
        view.addSubview(customView)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo:
                                            view.safeAreaLayoutGuide.topAnchor,
                                            constant: 100),
            customView.leadingAnchor.constraint(equalTo:
                                                view.safeAreaLayoutGuide.leadingAnchor,
                                                constant: 50),
            customView.trailingAnchor.constraint(equalTo:
                                                view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            customView.bottomAnchor.constraint(equalTo:
                                                view.safeAreaLayoutGuide.bottomAnchor,
                                               constant: -100)
        ])
    }
}

