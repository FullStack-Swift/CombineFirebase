import FirebaseFirestore
import Combine
import CombineFirebase
import Foundation

extension DocumentReference: CombineExtensionsProvider {}

extension CX where Base: DocumentReference {
  
  public func getDocument(source: FirestoreSource = .default) -> AnyPublisher<DocumentSnapshot?, NSError> {
    let pass = PassthroughSubject<DocumentSnapshot?, NSError>()
    base.getDocument(source: source) { documentSnapshot, error in
      if let error = error {
        pass.send(completion: .failure(error as NSError))
      } else {
        pass.send(documentSnapshot)
      }
    }
    return pass.eraseToAnyPublisher()
  }
  
  public func setData(dict: [String: Any]) -> AnyPublisher<Void, NSError> {
    let pass = PassthroughSubject<Void, NSError>()
    base.setData(dict) {error in
      if let error = error {
        pass.send(completion: .failure(error as NSError))
      } else {
        pass.send(())
      }
    }
    return pass.eraseToAnyPublisher()
  }
  
  public func delete() -> AnyPublisher<Void, NSError> {
    let pass = PassthroughSubject<Void, NSError>()
    base.delete { error in
      if let error = error {
        pass.send(completion: .failure(error as NSError))
      } else {
        pass.send(())
      }
    }
    return pass.eraseToAnyPublisher()
  }
  
  public func updateData(_ fields: [AnyHashable: Any]) -> AnyPublisher<Void, NSError> {
    let pass = PassthroughSubject<Void, NSError>()
    base.updateData(fields) { error in
      if let error = error {
        pass.send(completion: .failure(error as NSError))
      } else {
        pass.send(())
      }
    }
    return pass.eraseToAnyPublisher()
  }
  
}
