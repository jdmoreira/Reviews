import UIKit

extension UIView {
    func embed(_ view: UIView, insets: UIEdgeInsets = .zero, edges: UIRectEdge = .all) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)

        let constraints = NSLayoutConstraint.constraints(embedding: view,
                                                         in: self,
                                                         insets: insets,
                                                         edges: edges)
        NSLayoutConstraint.activate(constraints)
    }
}

private extension NSLayoutConstraint {
    static func constraints(embedding child: UIView,
                            in container: UIView,
                            insets: UIEdgeInsets = .zero,
                            edges: UIRectEdge = .all) -> [NSLayoutConstraint] {
        var constaints: [NSLayoutConstraint] = []
        let leadingAnchor = container.leadingAnchor
        let trailingAnchor = container.trailingAnchor
        let topAnchor = container.topAnchor
        let bottomAnchor = container.bottomAnchor
        let centerXAnchor = container.centerXAnchor
        let centerYAnchor = container.centerYAnchor

        if edges.contains(.left) {
            constaints.append(child.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left))
        }
        if edges.contains(.right) {
            constaints.append(trailingAnchor.constraint(equalTo: child.trailingAnchor, constant: insets.right))
        }
        if edges.contains(.top) {
            constaints.append(child.topAnchor.constraint(equalTo: topAnchor, constant: insets.top))
        }
        if edges.contains(.bottom) {
            constaints.append(bottomAnchor.constraint(equalTo: child.bottomAnchor, constant: insets.bottom))
        }

        // If not pinned to any vertical edge we center the view vertically in the container
        if edges.intersection([.top, .bottom]).isEmpty {
            constaints.append(child.centerYAnchor.constraint(equalTo: centerYAnchor).priority(.defaultLow))
        }
        // If not pinned to any horizontal edge we center the view horizontally in the container
        if edges.intersection([.left, .right]).isEmpty {
            constaints.append(child.centerXAnchor.constraint(equalTo: centerXAnchor).priority(.defaultLow))
        }

        return constaints
    }
}

private extension NSLayoutConstraint {
    func priority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
