//
//  ViewStyleOptions.swift
//  ViewStyleOptions
//
//  Created by İbrahim Taşdemir on 11.01.2025.
//
 
import UIKit
import ViewStyleOptions
import SnapKit
   
final public class FlyingFloatingMenu: UIView {
    
    public let topButton = UIButton(
        configs: .setRadius(25), .setBackground(.systemGray5),
        special: .setImage(.init(systemName: "square.grid.2x2")?.withConfiguration(UIImage.SymbolConfiguration.init(pointSize: 20, weight: .semibold)))
    )
    
    public var backButtons: [UIButton] = []
    
    public static let backButtonSymbols: [String] = [
        "magnifyingglass",         // Büyüteç (Arama)
        "star.fill",               // Yıldız (Favori, önemli)
        "house.fill",              // Ev (Ana Sayfa)
        "pencil",                  // Kalem (Düzenle)
        "heart.fill"               // Kalp (Beğenme)
    ]

    static public let backButtonBackgrounds: [UIColor] = [
        .systemBlue,               // Mavi (Arama, etkileyici)
        .systemYellow,             // Sarı (Favori, dikkat çekici)
        .systemGreen,              // Yeşil (Ana sayfa, güven verici)
        .systemOrange,             // Turuncu (Düzenle, dikkat çekici)
        .systemPink                // Pembe (Beğenme, eğlenceli)
    ]
    
    public struct Args {
        let topButtonStyleOptions: (configs: [ViewStyleOptions], special: [ButtonViewStyleOptions])
        let backButtonArgs: [BackButtonArgs]
        let onTapButton: (() -> Void)?
        
        public init(topButtonStyleOptions: (configs: [ViewStyleOptions], special: [ButtonViewStyleOptions]) = ([], []),
             backButtonArgs: [BackButtonArgs], onTapButton: (() -> Void)?) {
            self.topButtonStyleOptions = topButtonStyleOptions
            self.backButtonArgs = backButtonArgs
            self.onTapButton = onTapButton
        }
    }
    
    public struct BackButtonArgs {
        let buttonStyleOptions: (configs: [ViewStyleOptions], special: [ButtonViewStyleOptions])
        
        public init(buttonStyleOptions: (configs: [ViewStyleOptions], special: [ButtonViewStyleOptions])) {
            self.buttonStyleOptions = buttonStyleOptions
        }
    }
    
    private var args: Args!
    public convenience init(args: Args) {
        self.init(frame: .zero)
        self.args = args
        self.backButtons = args.backButtonArgs.map({
            .init(configs: $0.buttonStyleOptions.configs, special: $0.buttonStyleOptions.special)
        })
        self.commonInıt()
    }
    
    private func commonInıt() {
        configureUI()
        setupConstraints(addSubviews(_:))
    }
    
    private var originalPosition: CGPoint = .zero
    
    @objc private func onMovedTopButton(_ gesture: UIPanGestureRecognizer) {
        guard let superview else {
            return
        }
        let translation = gesture.translation(in: superview)
        switch gesture.state {
        case .began:
            originalPosition = topButton.center
        case .changed:
            setPosition(translation)
        case .ended:
            setPosition(originalPosition, end: true)
        default: break
        }
    }
    
    public func setPosition(_ point: CGPoint, end: Bool = false) {
        self.topButton.center = point
        if (!end) {
            backButtons.enumerated().forEach { index, button in
                UIView.animate(withDuration: 0.1, delay: Double(index + 1) * 0.1,
                               animations: {
                    button.center = point
                }
                )
            }
        } else {
            backButtons.enumerated().forEach { index, button in
                  UIView.animate(withDuration: 0.1, delay: Double(index + 1) * 0.1,
                                 usingSpringWithDamping: 0.4,initialSpringVelocity: 0, options: .curveEaseInOut,
                                 animations: {
                                     button.center = point
                                 }
                  )
              }
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            self.topButton.applyStyles(.disableSkeleton)
        })
    }
    

}

private extension FlyingFloatingMenu {
    func configureUI() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(onMovedTopButton(_:)))
        topButton.addGestureRecognizer(gesture)
        topButton.addAction(UIAction.init(handler: { [weak self] _ in
            self?.args.onTapButton?()
        }), for: .touchUpInside)
        topButton.applyStyles(args.topButtonStyleOptions.configs)
        topButton.applyStyles(args.topButtonStyleOptions.special)
    }
    
    func setupConstraints(_ subviews: (UIView...) -> Void) {
        backButtons.forEach({ subviews($0) })
        subviews(topButton)
        topButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        ([] + backButtons).forEach({
            $0.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(1)
            }
        })
    }
    
    
}

