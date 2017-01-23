import System.Dynamic
import System.Threading
import Nancy

public let requestGroup = Barrier(0)

public class WebUI : NancyModule {

	public var stopReceiver: () -> Void = {}

	public init() {
		Get["/test"] = createHandler(test)
		Get["/stop"] = createHandler(receiveStopRequest)
		print("meow")
	}

	func start() {
		requestGroup.AddParticipant()
	}

	func test(a: Any) -> Any {
		Console.WriteLine(a.GetType())
		return "Test."
	}

	func receiveStopRequest(a: Any) -> Any {
		print("stop")
		stopReceiver()
		return "Stop"
	}

	func createHandler(_ originalFunction: (Any) -> Any) -> Func<Any, Any> {
		func result(a: Any) -> Any {
			var r: Any = "unset"
			requestGroup.AddParticipant()
			do {
				try r = originalFunction(a)
			} catch System.Exception {
				print(error)
			}
			requestGroup.RemoveParticipant()
			return r
		}
		return result
	}

	public func stop() {
		requestGroup.RemoveParticipant()
		while (requestGroup.ParticipantsRemaining > 0) {
			Thread.Sleep(100)
		}
	}

}
