import System.Dynamic
import System.Threading
import Nancy

public class WebUI : NancyModule {

	let requestGroup = Barrier(0)

	public init() {
		Get["/test"] = createHandler(test)
		Get["/"] = createHandler(test)
		Get["/stop"] = createHandler(receiveStopRequest)
	}

	func start() {
		requestGroup.AddParticipant()
	}

	func test(a: Any) -> Any {
		Console.WriteLine(a.GetType())
		return "Test."
	}

	func receiveStopRequest(a: Any) -> Any {
		return ""
	}

	func createHandler(_ originalFunction: (Any) -> Any) -> Func<Any, Any> {
		func result(a: Any) -> Any {
			var r: Any = "unset"
			self.requestGroup.AddParticipant()
			do {
				try r = originalFunction(a)
			} catch System.Exception {
				print(error)
			}
			self.requestGroup.RemoveParticipant()
			return r
		}
		return result
	}

	public func stop() {
		//requestGroup.RemoveParticipant()
		while (requestGroup.ParticipantsRemaining > 0) {
			Thread.Sleep(100)
		}
	}

}
