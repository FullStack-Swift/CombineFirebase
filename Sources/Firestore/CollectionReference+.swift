import FirebaseFirestore
import Combine
import CombineFirebase
import Foundation

extension CollectionReference: CombineExtensionsProvider {}

extension CX where Base: CollectionReference {
  public func addDocument(dict: [String: Any]) -> AnyPublisher<DocumentReference, NSError> {
    let pass = PassthroughSubject<DocumentReference, NSError>()
    var ref: DocumentReference?
    ref = base.addDocument(data: dict) { error in
      if let error = error {
        pass.send(completion: .failure(error as NSError))
      } else if let ref = ref {
        pass.send(ref)
      }
    }
    return pass.eraseToAnyPublisher()
  }
  
  public func getDocuments() -> AnyPublisher<QuerySnapshot?, NSError> {
    let pass = PassthroughSubject<QuerySnapshot?, NSError>()
    base.getDocuments() { querySnapshot, error in
      if let error = error {
        pass.send(completion: .failure(error as NSError))
      } else {
        pass.send(querySnapshot)
      }
    }
    return pass.eraseToAnyPublisher()
  }
}
