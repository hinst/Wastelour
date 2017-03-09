import System.IO

public class Pager {
	
	var path = ""

	func getPageList() -> Dictionary<String, String> {
		let result = Dictionary<String, String>()
		let files = Directory.GetFiles(path)
		for filePath in files {
			let shortName = Path.GetFileNameWithoutExtension(filePath)
			result[shortName] = filePath
		}
		return result
	}

	func getPage(_ name: String) -> String {
		let pageContent = getPageContent(name)
		if pageContent != nil {
			let template = getTemplate()
			let fullPage = template.Replace("$content$", pageContent)
			return fullPage
		} else {
			return "No such page"
		}
	}

	func getTemplate() -> String {
		return File.ReadAllText(path + "\page.html")
	}

	func getPageContent(_ name: String) -> String? {
		var pageList = getPageList()
		if let pageFilePath = pageList[name] {
			let page = File.ReadAllText(pageFilePath)
			return page
		} else {
			return nil
		}
	}

}
