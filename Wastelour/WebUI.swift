import System.Dynamic
import Nancy

public class WebUI : NancyModule {

	let requestGroup = System.Threading.Barrier(0)

	public func start() {
		Get["/test"] = createHandler(test)
		Get["/stop"] = createHandler(stopReq)
		requestGroup.AddParticipant()
	}

	func test(a: Any) -> Any {
		Console.WriteLine(a.GetType())
		return "Test."
	}

	func stopReq(a: Any) -> Any {
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

	func stop() {
		requestGroup.SignalAndWait()
	}

}
