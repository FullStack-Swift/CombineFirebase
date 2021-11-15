import Combine

public protocol CombineExtensionsProvider {}

extension CombineExtensionsProvider {
  public var cx: CX<Self> {
    return CX(self)
  }

  public static var reactive: CX<Self>.Type {
    return CX<Self>.self
  }
}

public struct CX<Base> {
  public let base: Base
  fileprivate init(_ base: Base) {
    self.base = base
  }
}

@dynamicMemberLookup
public struct FirebasePublisher<FirebaseData>: Publisher {
  public typealias Output = FirebaseData
  public typealias Failure = Never
  
  public let upstream: AnyPublisher<FirebaseData, Never>
  
  fileprivate init(anyPublisher: AnyPublisher<FirebaseData, Never>) {
    self.upstream = anyPublisher
  }
  
  public func receive<S>(subscriber: S)
  where S: Subscriber, Failure == S.Failure, Output == S.Input {
    self.upstream.subscribe(
      AnySubscriber(
        receiveSubscription: subscriber.receive(subscription:),
        receiveValue: subscriber.receive(_:),
        receiveCompletion: {
          subscriber.receive(completion: $0)
        }
      )
    )
  }
  
  private init<P>(
    upstream: P
  ) where P: Publisher, Failure == P.Failure, Output == P.Output {
    self.upstream = upstream.eraseToAnyPublisher()
  }
  
  public subscript<LocalState>(
    dynamicMember keyPath: KeyPath<FirebaseData, LocalState>
  ) -> FirebasePublisher<LocalState>
  where LocalState: Equatable {
    .init(upstream: self.upstream.map(keyPath).removeDuplicates())
  }
}
