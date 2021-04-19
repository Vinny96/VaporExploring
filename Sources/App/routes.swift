import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
    app.get("hello", "vapor"){ req -> String in
        return "Hello Vapor!"
    }
    
    app.get("hello", ":name"){req -> String in
        guard let name = req.parameters.get("name") else{
            throw Abort(.internalServerError)
        }
        return "Hello \(name)"
    }
    
    app.post("info"){ req -> InfoResponse in
        let data = try req.content.decode(InfoData.self)
        return InfoResponse(request: data)
    }
}

struct InfoData : Content
{
    let name : String
    let character : String
}

struct InfoResponse : Content
{
    let request : InfoData
}
