import System.Dynamic
import System.Threading
import Nancy
import System.Collections.Concurrent

public class WebUI : NancyModule {

	lazy let pager = App.global!.pager;

	public init() {
		super.init("/waste")
		Get["/test"] = createHandler(test)
		Get["/stop"] = createHandler(receiveStopRequest)
		Get["/page"] = createHandler(getPage)
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

	func createHandler(_ originalFunction: (DynamicDictionary) -> Any) -> Func<Any, Any> {
		func result(a: Any) -> Any {
			var r: Any = "No result"
			requestGroup.add()
			do {
				try r = originalFunction(a)
			} catch System.Exception {
				Console.WriteLine(error)
			}
			requestGroup.remove()
			return r
		}
		return result
	}

	class let requestGroup = RequestGroup()

	public class func start() {
		requestGroup.add()
	}

	public class func stop() {
		requestGroup.remove()
		requestGroup.wait()
	}

	func getPage(a: DynamicDictionary) -> Any {
		let pageName: String = a["name"].ToString()
		Console.WriteLine(pageName)
		return pager.getPage(pageName)
	}

}

