import CombineFirebase
import FirebaseAuth
import Combine

extension Auth: CombineExtensionsProvider {
  
}

extension CX where Base: Auth {
  public func updateCurrentUser(_ user: User) -> AnyPublisher<Void, Error> {
    Future<Void, Error> { [weak base] promise in
      base?.updateCurrentUser(user) { error in
        guard let error = error else {
          promise(.success(()))
          return
        }
        promise(.failure(error))
      }
    }
    .eraseToAnyPublisher()
  }
  
  public func signIn(withEmail email: String, password: String) -> AnyPublisher<AuthDataResult, Error> {
    Future<AuthDataResult, Error> { [weak self] promise in
      self?.signIn(withEmail: email, password: password) { auth, error in
        if let error = error {
          promise(.failure(error))
        } else if let auth = auth {
          promise(.success(auth))
        }
      }
    }.eraseToAnyPublisher()
  }
}
