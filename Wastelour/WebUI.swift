import System.Dynamic
import System.Threading
import Nancy

public class WebUI : NancyModule {

	public var stopReceiver: () -> Void = {}
	public class let requestGroup = Barrier(1)

	public init() {
		Get["/test"] = createHandler(test)
		Get["/stop"] = createHandler(receiveStopRequest)
	}

	func test(a: Any) -> Any {
		Console.WriteLine(a.GetType())
		return "Test."
	}

	func receiveStopRequest(a: Any) -> Any {
		print("stop")
		App.global!.holder.Set()
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

	public class func waitForRequests() {
		requestGroup.SignalAndWait()
	}

}

