import FirebaseStorage
import FirebaseStorageSwift
import CombineFirebase
import Combine

extension StorageReference: CombineExtensionsProvider {}

extension CX where Base: StorageReference {
  public func putData(_ uploadData: Data, metadata: StorageMetadata? = nil) -> AnyPublisher<StorageMetadata, NSError> {
    let pass = PassthroughSubject<DocumentReference, NSError>()
    var task: StorageUploadTask?
    task = base.putData(uploadData, metadata: metadata, completion: { result, error in
      if let error = error {
        pass.send(completion: .failure(error as NSError))
      } else {
        pass.send(result)
      }
    })
    return pass.handleEvents(receiveCancel: {
      task?.cancel()
  })
  .eraseToAnyPublisher()
    
  }
}
